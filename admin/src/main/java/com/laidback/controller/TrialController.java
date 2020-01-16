package com.laidback.controller;

import com.laidback.mapper.*;
import com.laidback.model.*;
import com.laidback.repository.*;
import com.laidback.response.ResponseService;
import com.laidback.service.CustomEncode;
import com.laidback.util.DateUtil;
import freemarker.template.Template;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.io.File;
import java.io.FileWriter;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class TrialController extends RootController {

    @Autowired
    TrialUserMapper trialUserMapper;

    @Autowired
    TrialUserRepository trialUserRepository;

    @Autowired
    TrialLicenseMapper trialLicenseMapper;

    @Autowired
    TrialLicenseRepository trialLicenseRepository;


    @Autowired
    private CustomEncode customEncode;

    @Autowired
    TrialMacMapper trialMacMapper;

    @Autowired
    protected ResponseService responseService;

    // Trial 리스트 조회
    @GetMapping(value = "/trial/list")
    public ModelAndView trialList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "tl.start_date") String sort
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

        int totalCount = trialUserMapper.countBySuper(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<TrialUser> results = trialUserMapper.findBySuper(params);
        mav.addObject("results",results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);

        mav.setViewName("trial/list");
        return mav;
    }

    // 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/trial/execlDownList")
    public Object getExeclDownList(TrialUser trialUser) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = trialUser.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> trialList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            trialList.add(Integer.parseInt(seq));
        }
        params.put("trialList", trialList);

        List<TrialUser> execlDownList = trialUserMapper.getExeclDownList(params);
        return responseService.getListResult(execlDownList.size(),execlDownList);

    }

    // 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/trial/execlDownListAll")
    public Object getExeclDownListAll() {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();


        List<TrialUser> execlDownList = trialUserMapper.getExeclDownList(params);
        result.put("execlDownList", execlDownList);

        return result;
    }

    @GetMapping(value = "/trial/ajax_list")
    public Object trialAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "tl.start_date") String sort
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

        int totalCount = trialUserMapper.countBySuper(params);

        List<TrialUser> results = trialUserMapper.findBySuper(params);

        return responseService.getListResult(totalCount,results);
    }

    @GetMapping(value="/trial/trial_tmp")
    public Object trialTml(
    ){
        Map<String, Object> result = new HashMap<>();
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            Calendar cl = new GregorianCalendar(Locale.KOREA);
            Date date = new Date();
            cl.setTime(date);
            String now = sdf.format(cl.getTime());
            Date now2 = sdf.parse(now);
            cl.add(cl.DATE, 60);
            String dt = sdf.format(cl.getTime());
            Date dt2 = sdf.parse(dt);

            TrialMac trialMac = trialMacMapper.findRand();
            String macAddress = trialMac.getMacAddress();
            String mac[] = {};
            //        String macAddress = comLicenseUse.getMacAddress();
            if (macAddress.toLowerCase().contains(":")) {
                mac = macAddress.toLowerCase().split(":");
            } else if (macAddress.toLowerCase().contains("-")) {
                mac = macAddress.toLowerCase().split("-");
            }

            String f_macAddress = "";
            Integer macAsciiSum = 0;
            for (int i = 0; i < mac.length; i++) {
                //            System.out.println(getHexToDec(mac[i]));
                String arr1 = mac[i].substring(0, 1);
                String arr2 = mac[i].substring(1, 2);
                f_macAddress += customEncode.stringChange(arr1.charAt(0)).toString() + customEncode.stringChange(arr2.charAt(0)).toString();
                macAsciiSum += customEncode.getAscii(arr1.charAt(0));
                macAsciiSum += customEncode.getAscii(arr2.charAt(0));
            }

            String endDate = dt;
            //            SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" , Locale.KOREA );
            //            String endDate = sdf.format( endDateTime );

            //        String[] endDateArray1 = endDate.split(" ");


            String[] endDateArray = endDate.split("-");
            String time = endDateArray[0].substring(2, 4) + endDateArray[1] + endDateArray[2];

            String f_endDate = "";
            Integer endDateAsciiSum = 0;
            for (int i = 0; i < time.length(); i++) {
                f_endDate += customEncode.numberChange(time.substring(i, (i + 1)).charAt(0));
                endDateAsciiSum += customEncode.getAscii(time.substring(i, (i + 1)).charAt(0));
            }
            Integer acsiiSum = macAsciiSum + endDateAsciiSum;
            String num1 = String.valueOf(acsiiSum);
            num1 = num1.substring(num1.length() - 2, num1.length());

            Integer fnum1 = Integer.parseInt(num1);
            Integer fnum2 = Integer.parseInt(endDateArray[2]);

            Integer fnum = fnum1 * fnum2;
            String fnumStr = String.valueOf(fnum).substring(String.valueOf(fnum).length() - 2, String.valueOf(fnum).length());
            String license = f_macAddress.substring(0, 2) + time.substring(0, 1) + f_macAddress.substring(2, 3) + f_endDate.substring(1, 2) + "-" + f_macAddress.substring(3, 5) + f_endDate.substring(2, 3) + f_macAddress.substring(5, 6) + f_endDate.substring(3, 4) + "-" + f_macAddress.substring(6, 8) + f_endDate.substring(4, 5) + f_macAddress.substring(8, 9) + f_endDate.substring(5, 6) + "-" + f_macAddress.substring(9, 11) + fnumStr.substring(1, 2) + f_macAddress.substring(11, 12) + fnumStr.substring(0, 1);
            return responseService.getSingleResult(license);
        }catch(Exception e){
            return responseService.getFailResult(0,"");
        }
    }

    @GetMapping(value="/trial/re_emailsend")
    public Object trialEmail(
            @RequestParam(value="seq") Integer seq
    ){
        TrialUser trialUser = trialUserRepository.findOne(seq);
        Map<String, Object> params2 = new HashMap<>();
        params2.put("trialUserSeq",trialUser.getSeq());
        TrialLicense trialLicense = trialLicenseMapper.findByLicense(params2);

        String license = trialLicense.getLicenseKey();
        String email = trialUser.getEmail();

        Map<String, Object> result = new HashMap<>();
        try {
            Template t = configuration.getTemplate("mail/license_pc.ftl");


            final Map<String, Object> params = new HashMap<>();

            params.put("license", license);
            File file = new File("./uploads/license_"+email+".license") ;

            // true 지정시 파일의 기존 내용에 이어서 작성
//            FileWriter fw = null;
            try(FileWriter fw = new FileWriter(file, false)) {
                // 파일 객체 생성

                // 파일안에 문자열 쓰기
                fw.write(license);
                fw.flush();
//                fw.close();
                // 객체 닫기
            }
//            }catch(Exception e){
//                e.printStackTrace();
//                System.out.println(e);
//            }

            //params.put("loginUrl", "www.google.com");
            final String content = FreeMarkerTemplateUtils.processTemplateIntoString(t, params);

            emailService.sendmail("noreply@aworksrpa.com", "[a.works] 라이센스 발급 메일.", content, email, null,"license_"+email+".license");
            return responseService.getSuccessResult();
        }catch (Exception e){

            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    @GetMapping(value="/trial/re_download")
    public Object trialDownload(
            @RequestParam(value="seq") Integer seq
    ){
        TrialUser trialUser = trialUserRepository.findOne(seq);
        Map<String, Object> params2 = new HashMap<>();
        params2.put("trialUserSeq",trialUser.getSeq());
        TrialLicense trialLicense = trialLicenseMapper.findByLicense(params2);

        String license = trialLicense.getLicenseKey();
        String email = trialUser.getEmail();

        Map<String, Object> result = new HashMap<>();
        final Map<String, Object> params = new HashMap<>();

        return responseService.getSingleResult(license);

    }


}
