package com.laidback.controller;

import com.laidback.mapper.*;
import com.laidback.model.Admin;
import com.laidback.model.BbsOnetoone;
import com.laidback.model.TrialUser;
import com.laidback.model.User;
import com.laidback.repository.BbsOnetooneRepository;
import com.laidback.util.CookieUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@RestController
public class MainController extends RootController {

    @Autowired
    AdminMapper adminMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    TrialUserMapper trialUserMapper;

    @Autowired
    BbsOnetooneMapper bbsOnetooneMapper;

    @Autowired
    BbsOnetooneRepository bbsOnetooneRepository;

    @Autowired
    RepositoryMapper repositoryMapper;

    @Autowired
    CompanyMapper companyMapper;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView main(ModelAndView mav){

        User userCnt = userMapper.getTotalUserCnt();
        mav.addObject("userCnt", userCnt);

        List<BbsOnetoone> bbsOnetooneList = bbsOnetooneMapper.findByMain();
        mav.addObject("bbsOnetooneList", bbsOnetooneList);

        Map<String, Object> params = new HashMap<>();
        Integer repositoryCount = repositoryMapper.count(params);

        mav.addObject("repositoryCount",repositoryCount);

        Integer companyCount = companyMapper.count(params);
        mav.addObject("companyCount",companyCount);
        mav.setViewName("main");
        return mav;
    }
    @GetMapping(value = "/login")
    public ModelAndView login(ModelAndView mav){
        mav.setViewName("login");
        return mav;
    }

    @GetMapping(value = "/findPassword")
    public ModelAndView findPassword(ModelAndView mav){
        mav.setViewName("findPassword");
        return mav;
    }

    @PostMapping(value = "/adminInfo")
    public ModelAndView adminInfo(ModelAndView mav,
           @RequestParam(value = "adminId") String adminId)
    {
        Admin admin = adminMapper.findByAdminInfo(adminId);
        mav.addObject("admin", admin);

        mav.setViewName("adminInfo");
        return mav;
    }

    @PostMapping(value = "/adminInfoSave")
    public Object save(Admin admin, BindingResult bindingResult)
    {
        Map<String,Object> result = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            result.put("result",false);
            return result;
        }
//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);
        BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
        try{
            // 수정
            Admin old = adminMapper.findByAdminInfo(admin.getAdminId());
            old.setAdminPhone(admin.getAdminPhone());
            old.setAdminEmail(admin.getAdminEmail());
            old.setUpdateDatetime(new Date());
            old.setLicenseDate1(admin.getLicenseDate1());
            old.setLicenseDate2(admin.getLicenseDate2());
            old.setLicenseDate3(admin.getLicenseDate3());
//            old.setChagerName1(admin.getChagerName1());
//            old.setChargerEmail1(admin.getChargerEmail1());
//            old.setChargerName2(admin.getChargerName2());
//            old.setChargerEmail2(admin.getChargerEmail2());
            if(!StringUtils.isEmpty(admin.getAdminPw())) old.setAdminPw(pe.encode(admin.getAdminPw()));
            adminMapper.save(old);
//            transactionManager.commit(status);
            result.put("result",true);
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            result.put("result",false);
        }

        return result;
    }

    // list 개발
    @RequestMapping(value = "/list_dev", method = RequestMethod.GET)
    public ModelAndView listDev(ModelAndView mav){
        mav.setViewName("dev/list");
        return mav;
        // 개발된 ftl 정의
        // ex) 사용자 리스트 - user/list.ftl
    }

    // view 개발
    @RequestMapping(value = "/view_dev", method = RequestMethod.GET)
    public ModelAndView viewDev(ModelAndView mav){
        mav.setViewName("dev/view");
        return mav;
        // 개발된 ftl 정의
        // ex) 사용자 상세 - user/view.ftl
    }

    // write/update 개발
    @RequestMapping(value = "/write_dev", method = RequestMethod.GET)
    public ModelAndView writeDev(ModelAndView mav){
        mav.setViewName("dev/write");
        return mav;
        // 개발된 ftl 정의
        // ex) 사용자 등록 - user/write.ftl
    }
}

