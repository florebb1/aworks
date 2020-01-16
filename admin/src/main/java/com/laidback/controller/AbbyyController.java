package com.laidback.controller;

import com.laidback.mapper.ComAbbyyMapper;
import com.laidback.mapper.ComLicenseMapper;
import com.laidback.mapper.CompanyMapper;
import com.laidback.model.ComAbbyy;
import com.laidback.model.ComLicense;
import com.laidback.model.ComLicenseUse;
import com.laidback.repository.ComAbbyyRepository;
import com.laidback.repository.ComLicenseRepository;
import com.laidback.repository.ComLicenseUseRepository;
import com.laidback.response.ResponseService;
import com.laidback.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class AbbyyController extends RootController {

    @Autowired
    ComAbbyyMapper comAbbyyMapper;

    @Autowired
    ComAbbyyRepository comAbbyyRepository;

    @Autowired
    CompanyMapper companyMapper;

    @Autowired
    ComLicenseMapper comLicenseMapper;

    @Autowired
    ComLicenseRepository comLicenseRepository;

    @Autowired
    ComLicenseUseRepository comLicenseUseRepository;

    @Autowired
    protected ResponseService responseService;

    // ABBYY 라이선스 리스트 조회
    @GetMapping(value = "/abbyy/list")
    public ModelAndView abbyyList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "aby.create_datetime") String sort
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
            //params.put("startDate", Date.valueOf(startDate));
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
//            params.put("endDate", Date.valueOf(endDate));
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,1),"yyyy-MM-dd HH:mm:ss"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = comAbbyyMapper.count(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<ComLicense> results = comAbbyyMapper.find(params);
        mav.addObject("results",results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);

        mav.setViewName("abbyy/list");
        return mav;
    }

    // ABBYY 라이선스 등록 화면 호출
    @GetMapping(value = "/abbyy/registrationForm")
    public ModelAndView abbyyLicenceRegistrationForm(ModelAndView mav
         , @RequestParam(value="seq", defaultValue = "0") Integer seq )
    {
        if(seq != null && seq != 0) {
            ComAbbyy abbyy = comAbbyyMapper.findByAbbyyLicense(seq);
            mav.addObject("abbyy", abbyy);
        }

        mav.setViewName("abbyy/registration");
        return mav;
    }

    // ABBYY 라이선스 등록 처리
    @PostMapping(value = "/abbyy/registration")
    public Object abbyyLicenceRegistration(ComAbbyy abbyy,
            BindingResult bindingResult)
    {
        Map<String,Object> result = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"실패");
        }


        try{

            SimpleDateFormat sdt = new SimpleDateFormat("yyyyy-MM-dd");
            Date startDate = sdt.parse(abbyy.getStartDateStr());
            SimpleDateFormat edt = new SimpleDateFormat("yyyyy-MM-dd");
            Date endDate = edt.parse(abbyy.getEndDateStr());

            abbyy.setCreateDatetime(new Date());
            abbyy.setStartDate(startDate);
            abbyy.setEndDate(endDate);
            abbyy.setStatus(0);
            comAbbyyRepository.save(abbyy);
            comAbbyyRepository.flush();

//            transactionManager.commit(status);
//            result.put("seq", abbyy.getSeq());
            return responseService.getSingleResult(abbyy);
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"실패");
        }
    }

    // ABBYY 라이선스 수정 처리
    @PostMapping(value = "/abbyy/licenseModify")
    public Object licenseModify(
            ComAbbyy abbyy, BindingResult bindingResult
    ){
        Map<String,Object> result = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"실패");
        }



        try{
            // C/R
            ComAbbyy old = comAbbyyRepository.findOne(abbyy.getSeq());

            SimpleDateFormat sdt = new SimpleDateFormat("yyyyy-MM-dd");
            Date startDate = sdt.parse(abbyy.getStartDateStr());
            SimpleDateFormat edt = new SimpleDateFormat("yyyyy-MM-dd");
            Date endDate = edt.parse(abbyy.getEndDateStr());
            old.setUpdateDatetime(new Date());
            old.setStartDate(startDate);
            old.setEndDate(endDate);
            old.setAbbyyLicenseKey(abbyy.getAbbyyLicenseKey());
            old.setComSeq(abbyy.getComSeq());

            comAbbyyRepository.save(old);
            comAbbyyRepository.flush();

//            transactionManager.commit(status);
            return responseService.getSingleResult(abbyy);
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"실패");
        }
    }

    // ABBYY 라이선스 삭제 처리
    @RequestMapping(value = "/abbyy/licenseDelete", method = RequestMethod.POST)
    public Object licenseDelete(ComAbbyy abbyy, BindingResult bindingResult) {

        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"실패");
        }



        try{
            String deleteArray = abbyy.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
                abbyy = comAbbyyRepository.findOne(Integer.parseInt(seq));
                abbyy.setDeleteDatetime(new java.util.Date());
                comAbbyyRepository.save(abbyy);
            }
            comAbbyyRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"실패");
        }
    }

    // ABBYY 라이선스 상세보기 화면 호출
    @GetMapping(value = "/abbyy/detail")
    public ModelAndView abbyyLicenceDetail(ModelAndView mav
         , @RequestParam(value="seq") Integer seq )
    {
        ComAbbyy abbyy = comAbbyyMapper.findByAbbyyLicense(seq);
        mav.addObject("abbyy", abbyy);
        mav.setViewName("abbyy/detail");

        return mav;
    }

    // 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/abbyy/execlDownList")
    public Object getExeclDownList(ComAbbyy abbyy) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = abbyy.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> abbyyList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            abbyyList.add(Integer.parseInt(seq));
        }
        params.put("abbyyList", abbyyList);

        List<ComAbbyy> execlDownList = comAbbyyMapper.getExeclDownList(params);

        return responseService.getListResult(execlDownList.size(),execlDownList);
    }

    @GetMapping(value = "/abbyy/ajax_list")
    public Object abbyyAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "aby.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate

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
//            params.put("startDate",startDate);
            //params.put("startDate", Date.valueOf(startDate));
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
//            params.put("endDate", Date.valueOf(endDate));
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = comAbbyyMapper.count(params);
//        result.put("total",totalCount);

        List<ComLicense> results = comAbbyyMapper.find(params);
//        result.put("list",results);
        return responseService.getListResult(totalCount,results);

    }
}
