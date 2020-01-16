package com.laidback.controller;

/**
 * Created by tim on 2018. 10. 08..
 */

import com.laidback.mapper.AdminMapper;
import com.laidback.model.Admin;
import com.laidback.repository.AdminRepository;
import com.laidback.response.ResponseService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;
@RestController
public class AdminController extends RootController{
    @Autowired
    AdminMapper adminMapper;

    @Autowired
    AdminRepository adminRepository;

    @Autowired
    protected ResponseService responseService;

    @GetMapping(value = "/admin/list")
    public ModelAndView list(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,ModelAndView mav
    ) {
        Map<String, Object> params = new HashMap<>();
        int totalCount = adminMapper.count(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);
        List<Admin> results = adminMapper.find(params);
        mav.addObject("results",results);
        setPaginationData(mav, totalCount, page, row);

        mav.addObject("page",page);
        mav.addObject("row",row);
        mav.setViewName("/admin/list");
        return  mav;
    }

    @GetMapping(value = "/admin/view_form")
    public ModelAndView viewForm(
            @RequestParam("adminId") Integer adminId
            ,ModelAndView mav
    ){
        Map<String, Object> params = new HashMap<>();
        params.put("adminId", adminId);

        Admin admin = adminMapper.getAdmin(adminId);
        mav.addObject("admin",admin);
        mav.setViewName("admin/view_form");
        return  mav;
    }

    @PostMapping(value = "/admin/save")
    public Object save(Admin admin, BindingResult bindingResult){
        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            return responseService.getFailResult(0,"실패");
        }
//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);
        BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
        try{

            Admin old = adminRepository.findByAdmin(admin.getAdminId());
            old.setUpdateDatetime(new Date());
            if(!StringUtils.isEmpty(admin.getAdminPw()))old.setAdminPw(pe.encode(admin.getAdminPw()));

            old.setAdminName(admin.getAdminName());
            adminRepository.save(old);
            adminRepository.flush();

//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"실패");
        }
    }

    @DeleteMapping(value = "/admin/delete")
    public Object delete(@RequestParam("adminIds")Integer[] adminIds){
        Map<String,Object> result = new HashMap<>();
//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);
        try{
            for(Integer adminId : adminIds){

                adminRepository.delete(adminId);
            }
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"실패");
        }
    }

    @PostMapping(value = "/admin/findPassword")
    public Object resetPw(Admin admin) {

        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("adminPhone", admin.getAdminPhone());
        params.put("adminEmail", admin.getAdminEmail());

        Admin findAdminInfo = adminMapper.findInfo(params);

        String adminId = "";
        if(findAdminInfo != null) {
            adminId = findAdminInfo.getAdminId();
            return super.resetPw(adminId);
        } else {
            result.put("message", "이메일 발송 실패!\n입력정보를 다시 확인해주세요.");
            result.put("result", false);
            return result;
        }
    }

}
