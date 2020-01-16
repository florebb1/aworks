package com.laidback.controller;

import com.laidback.mapper.PartnerMapper;
import com.laidback.model.ComLicense;
import com.laidback.model.Partner;
import com.laidback.model.User;
import com.laidback.repository.PartnerRepository;
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

import javax.xml.ws.Response;
import java.util.*;

@RestController
public class PartnerController extends RootController {
    @Autowired
    PartnerMapper partnerMapper;

    @Autowired
    AmazonClient amazonClient;

    @Autowired
    PartnerRepository partnerRepository;

    @Autowired
    protected ResponseService responseService;

    @GetMapping(value = "/partner/list")
    public ModelAndView noticeList(
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

        int totalCount = partnerMapper.count(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<Partner> results = partnerMapper.find(params);
        mav.addObject("results",results);


        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("sort", sort);
        mav.addObject("page",page);

        mav.setViewName("partner/list");
        return mav;
    }

    // 파트너 상세 정보 페이지 호출
    @GetMapping(value = "/partner/partnerView")
    public ModelAndView view(ModelAndView mav,
            @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        params.put("seq", seq);
        Partner partner = partnerMapper.findByPartner(params);
        mav.addObject("partner", partner);

        mav.setViewName("partner/view");
        return mav;
    }

    // 파트너 등록, 수정 모달 호출
    @GetMapping(value = "/partner/partnerModalView")
    public ModelAndView modalView(ModelAndView mav,
            @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            Partner partner = partnerMapper.findByPartner(params);
            mav.addObject("partner", partner);
        }

        mav.setViewName("partner/partnerModal");
        return mav;
    }

    @PostMapping(value = "/partner/save")
    public Object save(Partner partner, BindingResult bindingResult)
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
        BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
        try{
            // 수정
            if(partner.getSeq() != null){
                Partner old = partnerRepository.findOne(partner.getSeq());
                old.setName(partner.getName());
                old.setTel(partner.getTel());
                old.setAddress(partner.getAddress());
                old.setBusinessNumber(partner.getBusinessNumber());
                old.setMemo(partner.getMemo());
                old.setUpdateDatetime(new Date());
                if(partner.getLogoImgFile() != null && !"".equals(partner.getLogoImgFile().getOriginalFilename())){
                    String fileUrl = amazonClient.uploadFile(partner.getLogoImgFile());
                    old.setLogo(fileUrl);
                }
                partnerRepository.save(old);
            }
            // 등록
            else {
                partner.setCreateDatetime(new Date());
                if(partner.getLogoImgFile() != null && !"".equals(partner.getLogoImgFile().getOriginalFilename())){
                    String fileUrl = amazonClient.uploadFile(partner.getLogoImgFile());
                    partner.setLogo(fileUrl);
                }
                partnerRepository.save(partner);
            }

            partnerRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    // 파트너 삭제 처리
    @RequestMapping(value = "/partner/partnerDelete", method = RequestMethod.POST)
    public Object partnerDelete(Partner partner, BindingResult bindingResult) {

        Map<String,Object> params = new HashMap<>();
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
            String deleteArray = partner.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
                params.put("seq", Integer.parseInt(seq));
                partner = partnerMapper.findByPartner(params);
                partner.setSeq(Integer.parseInt(seq));
                partner.setDeleteDatetime(new java.util.Date());
                partnerRepository.save(partner);
            }
            partnerRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    @GetMapping(value = "/partner/ajax_list")
    public Object partnerAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
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


        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
//            params.put("startDate",startDate);
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = partnerMapper.count(params);


        List<Partner> results = partnerMapper.find(params);


        return responseService.getListResult(totalCount,results);
    }

    // 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/partner/execlDownList")
    public Object getExeclDownList(Partner partner) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = partner.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> partnerList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            partnerList.add(Integer.parseInt(seq));
        }
        params.put("partnerList", partnerList);

        List<Partner> execlDownList = partnerMapper.getExeclDownList(params);


        return responseService.getListResult(execlDownList.size(),execlDownList);
    }
}
