package com.laidback.controller;

import com.laidback.mapper.ComContractMapper;
import com.laidback.mapper.CompanyMapper;
import com.laidback.model.ComContract;
import com.laidback.model.Company;
import com.laidback.repository.ComContractRepository;
import com.laidback.repository.CompanyRepository;
import com.laidback.response.ResponseService;
import com.laidback.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.*;

@RestController
public class CompanyController  extends RootController{
    @Autowired
    CompanyMapper companyMapper;

    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    ComContractMapper comContractMapper;

    @Autowired
    ComContractRepository comContractRepository;

    @Autowired
    protected ResponseService responseService;

    @GetMapping(value = "/company/list")
    public ModelAndView contractList(
            ModelAndView mav
    ) {
        // Order value Change

        mav.setViewName("company/list");
        return mav;
    }

    @GetMapping(value = "/company/view")
    public ModelAndView contractView(
            @RequestParam(value="seq") Integer seq
            ,ModelAndView mav
    ) {
        // Order value Change
        Company company = companyRepository.findOne(seq);
        mav.addObject("company",company);

        List<ComContract> comContract = comContractRepository.findByCompany(company);
        mav.addObject("comContract",comContract);
        mav.setViewName("company/view");
        return mav;
    }

    @PostMapping(value="/company/write")
    public Object companyWrite(
            @RequestParam(value="comName") String comName
            ,@RequestParam(value="comPhone") String comPhone
            ,@RequestParam(value="comEmail") String comEmail
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            int count = companyMapper.dupleName(comName);
            if(count == 0) {
                Company company = new Company();
                company.setComName(removeTag(comName));
                company.setComPhone(removeTag(comPhone));
                company.setComEmail(comEmail);
                company.setStatus(0);
                company.setCreateDatetime(new java.util.Date());

                companyRepository.save(company);
                companyRepository.flush();
                transactionManager.commit(status);
                return responseService.getSuccessResult();
            }else{
                transactionManager.rollback(status);
                result.put("result",false);
                result.put("errorCode","-1"); // 중복
                return responseService.getFailResult(-1,"중복");
            }



        }catch(Exception e){
            return responseService.getFailResult(0,"실패");
        }
    }

    @PutMapping(value="/company/update")
    public Object companyUpdate(
            @RequestParam(value="seq") Integer seq
            ,@RequestParam(value="comName") String comName
            ,@RequestParam(value="bComName") String bComName
            ,@RequestParam(value="comPhone") String comPhone
            ,@RequestParam(value="comEmail") String comEmail
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            if(!bComName.equals(comName)){
                int count = companyMapper.dupleName(comName);
                if(count == 0) {
                    Company company = companyRepository.findOne(seq);
                    company.setComName(removeTag(comName));
                    company.setComPhone(removeTag(comPhone));
                    company.setComEmail(comEmail);
//                    company.setStatus(comStatus);
                    company.setUpdateDatetime(new java.util.Date());

                    companyRepository.save(company);
                    companyRepository.flush();
                    transactionManager.commit(status);
                    return responseService.getSuccessResult();
                }else{
                    transactionManager.rollback(status);
                    return responseService.getFailResult(-1,"중복");
                }
            }else{
                Company company = companyRepository.findOne(seq);
                company.setComName(removeTag(comName));
                company.setComPhone(removeTag(comPhone));
                company.setComEmail(comEmail);
//                company.setStatus(comStatus);
                company.setUpdateDatetime(new java.util.Date());

                companyRepository.save(company);
                companyRepository.flush();
                transactionManager.commit(status);
                return responseService.getSuccessResult();
            }


        }catch(Exception e){
            transactionManager.rollback(status);
            return responseService.getFailResult(0,"실패");
        }
    }

    @PostMapping(value="/company/delete")
    public Object companyDelete(
            @RequestParam(value="deleteArray") String deleteArray
    ){
        Map<String,Object> result = new HashMap<>();
        String[] seq = deleteArray.split("\\|");
        Integer deleteY = 0;
        Integer deleteN = 0;
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        for(int i = 0 ;i < seq.length;i++) {
//            int count = companyMapper.getAllUse(Integer.parseInt(seq[i]));
//            if(count == 0){
//                ++deleteY;
            Company company = companyRepository.findOne(Integer.parseInt(seq[i]));
            company.setDeleteDatetime(new java.util.Date());
            companyRepository.save(company);
            companyRepository.flush();
//            }else{
//                ++deleteN;
//            }



        }
        transactionManager.commit(status);


        result.put("deleteY",deleteY);
        result.put("deleteN",deleteN);
        return responseService.getSingleResult(result);
    }



    @GetMapping(value="/company/ajax_list")
    public Object companyAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "1") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
    ) {
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("order",order);

        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
//            params.put("startDate",startDate);
            //params.put("startDate", Date.valueOf(startDate));
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
//            params.put("endDate", Date.valueOf(endDate));
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = companyMapper.count(params);
//        result.put("total",totalCount);

        List<Company> results = companyMapper.find(params);
//        result.put("list",results);
//        return result;
        return responseService.getListResult(totalCount,results);
    }

    public String removeTag(String html) throws Exception {
        return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
    }

    // 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/company/execlDownList")
    public Object getExeclDownList(
            @RequestParam(value="chkValueArr") String checkSeq
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
    ) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = checkSeq;
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> companyList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            companyList.add(Integer.parseInt(seq));
        }
        params.put("companyList", companyList);
        params.put("sort",sort);
        params.put("order",order);

        List<Company> execlDownList = companyMapper.getExeclDownList(params);

        return responseService.getListResult(execlDownList.size(),execlDownList);

    }
}
