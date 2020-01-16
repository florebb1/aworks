package com.laidback.controller;

import com.laidback.mapper.VersionManageMapper;
import com.laidback.model.Repository;
import com.laidback.model.VersionManage;
import com.laidback.repository.VersionManageRepository;
import com.laidback.response.ResponseService;
import com.laidback.service.AmazonClient;
import com.laidback.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class VersionManageController extends RootController{

    @Autowired
    AmazonClient amazonClient;

    @Autowired
    VersionManageMapper versionManageMapper;

    @Autowired
    VersionManageRepository versionManageRepository;

    @Autowired
    protected ResponseService responseService;

    @GetMapping(value = "/version_manage/list")
    public ModelAndView versionManageList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
    ){

        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);

        // Order value Change
        setOrderValueChange(mav, params, order);

        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
//            params.put("startDate",startDate);
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,1),"yyyy-MM-dd HH:mm:ss"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = versionManageMapper.count(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<VersionManage> results = versionManageMapper.find(params);
        mav.addObject("results",results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);
        mav.addObject("sort", sort);

        mav.setViewName("version_manage/list");
        return mav;
    }

    @PostMapping(value = "/version_manage/save")
    public Object save(VersionManage versionManage, BindingResult bindingResult)
    {
        Map<String,Object> result = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }
//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            versionManage.setCreateDatetime(new Date());
            if(versionManage.getFile() != null && !"".equals(versionManage.getFile().getOriginalFilename())){

                String originalFilenamefileName = versionManage.getFile().getOriginalFilename();
//                String fileName = originalFilenamefileName.substring(0, originalFilenamefileName.lastIndexOf("."));
//                String ext = originalFilenamefileName.substring(originalFilenamefileName.lastIndexOf("."), originalFilenamefileName.length());
//                String fileNameByVersion = fileName + "_" + versionManage.getVersionNumber() + ext;
                String file = amazonClient.uploadOriginalFile(versionManage.getFile(), originalFilenamefileName);
                versionManage.setFilePath(file);
            }else{
                versionManage.setFilePath("");
            }
            DateFormat fullDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            versionManage.setUpdateDatetime(fullDateFormat.parse(versionManage.getUpdateDatetimeStr()));
            versionManageRepository.save(versionManage);
            versionManageRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    @DeleteMapping(value = "/version_manage/delete")
    public Object delete(
            @RequestParam(value="seq") Integer seq
    ){
        Map<String,Object> result = new HashMap<>();
//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            VersionManage versionManage = versionManageRepository.findOne(seq);

            versionManage.setDeleteDatetime(new java.util.Date());
            versionManageRepository.save(versionManage);
            versionManageRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    @DeleteMapping(value = "/version_manage/delete_check")
    public Object deleteCheck(
            @RequestParam(value="seq") Integer[] seq
    ){

        Map<String,Object> result = new HashMap<>();
//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            for(int i = 0 ; i < seq.length;i++) {
                VersionManage versionManage = versionManageRepository.findOne(seq[i]);

                versionManage.setDeleteDatetime(new java.util.Date());
                versionManageRepository.save(versionManage);
                versionManageRepository.flush();
            }
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    @GetMapping(value = "/version_manage/ajax_list")
    public Object version_manageAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
    ){
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("order",order);
        // Order value Change

        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = versionManageMapper.count(params);

        List<VersionManage> results = versionManageMapper.find(params);

        return responseService.getListResult(totalCount,results);
    }
}
