package com.laidback.controller;

import com.amazonaws.services.s3.model.S3Object;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.laidback.mapper.*;
import com.laidback.model.*;
import com.laidback.repository.*;
import com.laidback.response.ResponseService;
import com.laidback.service.AmazonClient;
import com.laidback.service.CustomEncode;
import com.laidback.service.EmailService;
import com.laidback.service.SecureService;
import com.laidback.util.DateUtil;
import com.laidback.util.JwtUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.ibatis.jdbc.Null;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.msgpack.util.json.JSON;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class MypageController extends RootController{
    @Autowired
    AmazonClient amazonClient;

    @Autowired
    private SecureService secureService;

    @Autowired
    BbsOnetooneRepository bbsOnetooneRepository;

    @Autowired
    BbsOnetooneMapper bbsOnetooneMapper;

    @Autowired
    UserRepository userRepository;

    @Autowired
    RepositoryDownloadMapper repositoryDownloadMapper;

    @Autowired
    ComLicenseRepository comLicenseRepository;

    @Autowired
    ComLicenseMapper comLicenseMapper;

    @Autowired
    ComLicenseUseRepository comLicenseUseRepository;

    @Autowired
    CompanyMapper companyMapper;

    @Autowired
    ComContractMapper comContractMapper;

    @Autowired
    ComAbbyyMapper comAbbyyMapper;

    @Autowired
    ComAbbyyRepository comAbbyyRepository;

    @Autowired
    VersionManageMapper versionManageMapper;

    @Autowired
    protected Configuration configuration;

    @Autowired
    protected EmailService emailService;

    @Autowired
    ComContractRepository comContractRepository;

    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    ComLicenseUseMapper comLicenseUseMapper;

    @Autowired
    private CustomEncode customEncode;

    @Autowired
    protected ResponseService responseService;

    @Autowired
    private BbsFileMapper bbsFileMapper;

    @GetMapping(value = "/mypage/user_modify")
    public ModelAndView userModify(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");
        User user = userRepository.findOne(userSeq);
        mav.addObject("user", user);
        mav.setViewName("mypage/user_modify");
        return mav;
    }

    @GetMapping(value = "/mypage/contract_management")
    public ModelAndView contractManagement(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");
        mav.setViewName("mypage/contract_management");
        return mav;
    }

    @GetMapping(value = "/mypage/qna_list")
    public ModelAndView qnaList(
            @RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "5") Integer row
            ,ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");

        mav.setViewName("mypage/qna_list");
        return mav;
    }

    @GetMapping(value = "/mypage/ajax_qna")
    public Object ajaxLicense(
            @RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "5") Integer row
            , HttpServletRequest httpServletRequest
    ){
        Map<String,Object> result = new HashMap<>();
//        Object sessionUser = getSessionUser();
        Object s_user = super.getSessionUser(httpServletRequest);
        ObjectMapper oMapper = new ObjectMapper();


        // object -> Map
        Map<String, Object> map = oMapper.convertValue(s_user, Map.class);

        User user = userRepository.findOne((int) map.get("s_seq"));


        User finalUser = user;
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("order", 1);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("userSeq", finalUser.getSeq());

        int totalCount = bbsOnetooneMapper.onetooneByCount(params);


        List<BbsOnetoone> results = bbsOnetooneMapper.repoByOnetoone(params);
        for(BbsOnetoone bbsOnetoone: results){
            Map<String, Object> cparams = new HashMap<>();
            cparams.put("bbsCode","onetoone");
            cparams.put("bbsSeq",bbsOnetoone.getSeq());
            List<BbsFile> bbsFilesQ = bbsFileMapper.findByFilesQ(cparams);
            bbsOnetoone.setBbsFilesQ(bbsFilesQ);

            List<BbsFile> bbsFilesA = bbsFileMapper.findByFilesA(cparams);
            bbsOnetoone.setBbsFilesA(bbsFilesA);
        }
        return responseService.getListResult(totalCount,results);
    }

    @GetMapping(value = "/mypage/contract_management_info")
    public ModelAndView contractManagementInfo(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "contractStatus", required = false) Integer contractStatus
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,@RequestParam(value = "comSeq",required = false) Integer comSeq
            ,@RequestParam(value="licenseType", required = false) Integer licenseType
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");


        // company 검색



        mav.setViewName("mypage/contract_management_info");
        return mav;
    }

    @GetMapping(value="/mypage/contract_management_info_detail")
    public ModelAndView contracatDetail(
            @RequestParam(value="seq") Integer seq
            ,ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");
        ComContract comContract = comContractRepository.findOne(seq);
        mav.addObject("comContract", comContract);
        Map<String, Object> params = new HashMap<>();
        params.put("contractSeq", seq);
        List<ComLicense> comLicense = comLicenseMapper.find(params);
        mav.addObject("comLicense",comLicense);


        mav.setViewName("mypage/contract_management_info_detail");
        return mav;
    }

    @GetMapping(value = "/mypage/contract_management_license")
    public ModelAndView contractManagementLicense(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            , @RequestParam(value = "row", defaultValue = "10") Integer row
            , ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
//        Object sessionUser = getSessionUser();
        String s_seq = JwtUtil.getSubject(httpServletRequest,COOKIENAME,SIGNKEY);

        mav.addObject("page",page);
        mav.addObject("row",row);
        mav.setViewName("mypage/contract_management_license");
        return mav;
    }

    @GetMapping(value = "/mypage/contract_management_abbyy")
    public ModelAndView contractManagementAbbyy(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "aby.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");
        Map<String, Object> userParams = new HashMap<>();
        userParams.put("userSeq", userSeq);
        // company 검색
        Company company = companyMapper.findByCompanySeq(userParams);
        int comSeq = company.getSeq();

        Map<String, Object> params = new HashMap<>();
        params.put("comSeq", comSeq);
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }
        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
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
        mav.addObject("searchType", searchType);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.setViewName("mypage/contract_management_abbyy");
        return mav;
    }

    @PostMapping(value = "/mypage/license_apply")
    public Object licenseApply(
            @RequestParam(value="licenseSeq") Integer licenseSeq
            ,@RequestParam(value="comUuid", required = false) String comUuid
            ,@RequestParam(value="countUnattended", defaultValue="0") Integer countUnattended
            ,@RequestParam(value="countAttended" , defaultValue="0") Integer countAttended
            ,@RequestParam(value="countDeveloper", defaultValue="0") Integer countStudio
            ,@RequestParam(value="countWorkcenter", defaultValue="0") Integer countWorkcenter
            ,@RequestParam(value="licenseName") String licenseName
    ){
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        ComLicenseUse comLicenseUse = new ComLicenseUse();
        Map<String,Object> result = new HashMap<>();
        Map<String,Object> cparams = new HashMap<>();
        ComLicense comLicense = comLicenseMapper.getComLicense(licenseSeq);

        ComContract comContract = comContractRepository.findOne(comLicense.getComContractSeq());
        Company company = companyRepository.findOne(comContract.getCompany().getSeq());

        cparams.put("comContractSeq",comContract.getSeq());
        cparams.put("licenseName",licenseName);
        int dupleName = comLicenseUseMapper.dupleName(cparams);
        if(dupleName == 0) {
            Integer total1 = comLicense.getCountAttendedUse() + countAttended;
            Integer total2 = comLicense.getCountUnAttendedUse() + countUnattended;
            Integer total3 = comLicense.getCountStudioUse() + countStudio;
            Integer total4 = comLicense.getCountWorkcenterUse() + countWorkcenter;
            Boolean insertYn = true;
            String over[] = new String[4];
            over[0] = "";
            over[1] = "";
            over[2] = "";
            over[3] = "";
            if (countAttended > 0 && total1 > comLicense.getCountAttended()) {
                insertYn = false;
                //            result.put("type","Attended");
                over[0] = "Attended";
            }

            if (countUnattended > 0 && total2 > comLicense.getCountUnattended()) {
                insertYn = false;
                //            result.put("type","UnAttended");
                over[1] = "UnAttended";
            }

            if (countStudio > 0 && total3 > comLicense.getCountStudio()) {
                insertYn = false;
                //            result.put("type","Studio");
                over[2] = "Studio";
            }

            if (countWorkcenter > 0 && total4 > comLicense.getCountWorkcenter()) {
                insertYn = false;
                //            result.put("type","Studio");
                over[3] = "Workcenter";
            }
            if (insertYn) {
                try {
                    String licenseCode = UUID.randomUUID().toString();
                    comLicenseUse.setCreateDatetime(new java.util.Date());
                    comLicenseUse.setLicenseCode(licenseCode);
                    comLicenseUse.setStatus(0);

                    comLicenseUse.setComLicense(comLicense);
                    String comUuidStr = "";
                    if (comUuid != null && !comUuid.equals("")) {
                        //                comLicenseUse.setComUuid(comUuid);
                        // 파일 분석
                        String decodeData = secureService.decode(comUuid);
                        System.out.println(decodeData);
                        JSONParser parser = new JSONParser();

                        try {
                            Object obj = parser.parse(decodeData);

                            JSONObject jsonObj = (JSONObject) obj;
                            comLicenseUse.setComUuid(jsonObj.get("subscriptor").toString());
                            comUuidStr = jsonObj.get("subscriptor").toString();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                    } else {
                        comLicenseUse.setComUuid(company.getComUuid());
                        comUuidStr = company.getComUuid();
                    }
                    comLicenseUse.setComSeq(company.getSeq());
                    comLicenseUse.setComContractSeq(comContract.getSeq());

                    comLicenseUse.setCountUnattended(countUnattended);
                    comLicenseUse.setCountAttended(countAttended);
                    comLicenseUse.setCountDeveloper(countStudio);
                    comLicenseUse.setCountWorkcenter(countWorkcenter);
                    comLicenseUse.setLicenseName(licenseName);
                    comLicenseUseRepository.save(comLicenseUse);
                    comLicenseUseRepository.flush();
                    transactionManager.commit(status);
                    String tariff = "";
                    if (comLicense.getSubscribeType() == 1) {
                        tariff = "Hour";
                    } else if (comLicense.getSubscribeType() == 2) {
                        tariff = "Month";
                    } else {
                        tariff = "Annual";
                    }

                    String license = secureService.encode("{\n" +
                            " \"type\" : \"Organization\",\n" +
                            " \"tariff\" : \"" + tariff + "\",\n" +
                            " \"licenseKey\" : \"" + licenseCode + "\",\n" +
                            " \"subscriptor\" : \"" + comUuidStr + "\",\n" +
                            " \"name\" : \"" + licenseName + "\",\n" +
                            " \"issuedDatetime\" : " + comContract.getCreateDatetime().getTime() + ",\n" +
                            " \"licenseStartedDatetime\" : " + comContract.getContractStart().getTime() + ",\n" +
                            " \"licenseFinishedDatetime\" : " + (comContract.getContractEnd().getTime() + 86400000 - 1000) + ",\n" +
                            " \"countUnattended\" : " + countUnattended + ",\n" +
                            " \"countAttended\" : " + countAttended + ",\n" +
                            " \"countStudio\" : " + countStudio + ",\n" +
                            " \"priceUnattended\" : " + comLicense.getUnattendedLicenseListPrice() + ",\n" +
                            " \"priceAttended\" : " + comLicense.getAttendedLicenseListPrice() + ",\n" +
                            " \"priceStudio\" : " + comLicense.getStudioLicenseListPrice() + "\n" +
                            "}");

//                    result.put("result", true);
//                    result.put("license", license);
                    return responseService.getSingleResult(license);
                } catch (Exception e) {
                    transactionManager.rollback(status);
                    log.error(e.getMessage(), e);
//                    result.put("result", false);
                    return responseService.getFailResult(0,"실패");
                }
            } else {
                transactionManager.rollback(status);
//                result.put("result", false);
                String overStr = String.join(",", over);
                return responseService.getFailResult(0,overStr);
            }
        }else{
            transactionManager.rollback(status);
            result.put("result", false);
            result.put("errorCode","-1");
            return responseService.getFailResult(-1,"실패");
        }
    }

    @PostMapping(value = "/mypage/license_apply_old")
    public Object licenseApplyOld(
            @RequestParam(value="licenseSeq") Integer licenseSeq
            ,@RequestParam(value="comUuid", required = false) String comUuid
            ,@RequestParam(value="countUnattended", defaultValue="0") Integer countUnattended
            ,@RequestParam(value="countAttended" , defaultValue="0") Integer countAttended
            ,@RequestParam(value="countDeveloper", defaultValue="0") Integer countStudio
            ,@RequestParam(value="licenseName") String licenseName
    ){
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        ComLicenseUse comLicenseUse = new ComLicenseUse();
        Map<String,Object> result = new HashMap<>();
        ComLicense comLicense = comLicenseMapper.getComLicense(licenseSeq);

        ComContract comContract = comContractRepository.findOne(comLicense.getComContractSeq());
        Company company = companyRepository.findOne(comContract.getCompany().getSeq());

        Integer total1 = comLicense.getCountAttendedUse()+countAttended;
        Integer total2 = comLicense.getCountUnAttendedUse()+countUnattended;
        Integer total3 = comLicense.getCountStudioUse()+countStudio;
        Boolean insertYn = true;
        String over[] = new String[3];
        over[0] = "";
        over[1] = "";
        over[2] = "";
        if(countAttended > 0 && total1 > comLicense.getCountAttended()){
            insertYn = false;
//            result.put("type","Attended");
            over[0] = "Attended";
        }

        if(countUnattended > 0 && total2 > comLicense.getCountUnattended()){
            insertYn = false;
//            result.put("type","UnAttended");
            over[1] = "UnAttended";
        }

        if(countStudio > 0 && total3 > comLicense.getCountStudio()){
            insertYn = false;
//            result.put("type","Studio");
            over[2] = "Studio";
        }
        if(insertYn) {
            try {
                String licenseCode = UUID.randomUUID().toString();
                comLicenseUse.setCreateDatetime(new java.util.Date());
                comLicenseUse.setLicenseCode(licenseCode);
                comLicenseUse.setStatus(0);

                comLicenseUse.setComLicense(comLicense);
                String comUuidStr = "";
                if (comUuid != null && !comUuid.equals("")) {
                    //                comLicenseUse.setComUuid(comUuid);
                    // 파일 분석
                    String decodeData = secureService.decode(comUuid);
                    System.out.println(decodeData);
                    JSONParser parser = new JSONParser();

                    try {
                        Object obj = parser.parse(decodeData);

                        JSONObject jsonObj = (JSONObject) obj;
                        System.out.println(jsonObj.get("subscriptor").toString());
                        comLicenseUse.setComUuid(jsonObj.get("subscriptor").toString());
                        comUuidStr = jsonObj.get("subscriptor").toString();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                } else {
                    comLicenseUse.setComUuid(company.getComUuid());
                    comUuidStr = company.getComUuid();
                }
                comLicenseUse.setCountUnattended(countUnattended);
                comLicenseUse.setCountAttended(countAttended);
                comLicenseUse.setCountDeveloper(countStudio);
                comLicenseUse.setLicenseName(licenseName);
                comLicenseUseRepository.save(comLicenseUse);
                comLicenseUseRepository.flush();
                transactionManager.commit(status);
                String tariff = "";
                if(comLicense.getSubscribeType() == 1){
                    tariff = "Hour";
                }else if(comLicense.getSubscribeType() == 2){
                    tariff = "Month";
                }else{
                    tariff = "Annual";
                }

                String license = secureService.encode("{\n" +
                        " \"type\" : \"Organization\",\n" +
                        " \"tariff\" : \""+tariff+"\",\n" +
                        " \"licenseKey\" : \""+licenseCode+"\",\n" +
                        " \"subscriptor\" : \""+comUuidStr+"\",\n" +
                        " \"name\" : \""+licenseName+"\",\n" +
                        " \"issuedDatetime\" : "+comContract.getCreateDatetime().getTime()+",\n" +
                        " \"licenseStartedDatetime\" : "+comContract.getContractStart().getTime()+",\n" +
                        " \"licenseFinishedDatetime\" : "+(comContract.getContractEnd().getTime()+86400000-1000)+",\n" +
                        " \"countUnattended\" : "+countUnattended+",\n" +
                        " \"countAttended\" : "+countAttended+",\n" +
                        " \"countDeveloper\" : "+countStudio+",\n" +
                        " \"priceUnattended\" : "+comLicense.getUnattendedLicenseListPrice()+",\n" +
                        " \"priceAttended\" : "+comLicense.getAttendedLicenseListPrice()+",\n" +
                        " \"priceDeveloper\" : "+comLicense.getStudioLicenseListPrice()+"\n" +
                        "}");

                return responseService.getSingleResult(license);
            } catch (Exception e) {
                transactionManager.rollback(status);
                log.error(e.getMessage(), e);
                return responseService.getFailResult(0,"실패");
            }
        }else{
            transactionManager.rollback(status);
            String overStr = String.join(",",over);
            return responseService.getFailResult(0,overStr);
        }
    }

    @PostMapping(value = "/mypage/license_serial_make")
    public Object licenseSerialMake(
            @RequestParam(value="macAddress") String macAddress
            ,@RequestParam(value="botType") String botType
            ,@RequestParam(value="licenseType") Integer licenseType
            ,@RequestParam(value="licenseSeq", required = false) Integer licenseSeq
            ,@RequestParam(value="licenseName") String licenseName
            ,HttpServletRequest httpServletRequest
    ){
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        ComLicenseUse comLicenseUse = new ComLicenseUse();
        Map<String,Object> result = new HashMap<>();
        Map<String,Object> params = new HashMap<>();
        Map<String,Object> cparams = new HashMap<>();

        String searchMacAddress[] = {};
        if(macAddress.toLowerCase().contains(":")) {
            searchMacAddress = macAddress.toLowerCase().split(":");
        }else if(macAddress.toLowerCase().contains("-")){
            searchMacAddress = macAddress.toLowerCase().split("-");
        }
        params.put("macAddress",String.join(":",searchMacAddress));
        params.put("macAddress2",String.join("-",searchMacAddress));

        SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd" , Locale.KOREA );
        String sEndDate = sdf.format( new Date() );
        params.put("endDate",sEndDate);
        Integer totalMac = comLicenseUseMapper.getMacAddress(params);

        ComLicense comLicense = comLicenseRepository.findOne(licenseSeq);
        ComContract comContract = comContractRepository.findOne(comLicense.getComContract().getSeq());
        cparams.put("comContractSeq",comContract.getSeq());
        cparams.put("licenseName",licenseName);
        int dupleName = comLicenseUseMapper.dupleName(cparams);
        if(dupleName == 0) {

            if (totalMac == 0) {
                try {
                    //            comLicense.setMacAddress(macAddress);

                    comLicenseUse.setCountAttended(1);
                    comLicenseUse.setCountDeveloper(1);


                    comLicenseUse.setCreateDatetime(new java.util.Date());
                    comLicenseUse.setMacAddress(macAddress.toLowerCase());
                    //            ComLicense comLicense = new ComLicense();

                    System.out.println(">>" + comLicense.getComContract().getSeq());
                    String mac[] = {};
                    comLicenseUse.setComLicense(comLicense);
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
                        f_macAddress += stringChange(arr1.charAt(0)).toString() + stringChange(arr2.charAt(0)).toString();
                        macAsciiSum += getAscii(arr1.charAt(0));
                        macAsciiSum += getAscii(arr2.charAt(0));
                    }



                    String endDate = comContract.getContractEnd().toString();
                    //                System.out.println(endDate);
                    String[] endDateArray1 = endDate.split(" ");

                    String[] endDateArray = endDateArray1[0].split("-");
                    String time = endDateArray[0].substring(2, 4) + endDateArray[1] + endDateArray[2];
                    System.out.println(time);
                    String f_endDate = "";
                    Integer endDateAsciiSum = 0;
                    for (int i = 0; i < time.length(); i++) {
                        f_endDate += numberChange(time.substring(i, (i + 1)).charAt(0));
                        endDateAsciiSum += getAscii(time.substring(i, (i + 1)).charAt(0));
                    }
                    Integer acsiiSum = macAsciiSum + endDateAsciiSum;
                    String num1 = String.valueOf(acsiiSum);
                    num1 = num1.substring(num1.length() - 2, num1.length());

                    Integer fnum1 = Integer.parseInt(num1);
                    Integer fnum2 = Integer.parseInt(endDateArray[2]);

                    Integer fnum = fnum1 * fnum2;
                    String fnumStr = String.valueOf(fnum).substring(String.valueOf(fnum).length() - 2, String.valueOf(fnum).length());
                    String LicenseString = f_macAddress.substring(0, 2) + time.substring(0, 1) + f_macAddress.substring(2, 3) + f_endDate.substring(1, 2) + "-" + f_macAddress.substring(3, 5) + f_endDate.substring(2, 3) + f_macAddress.substring(5, 6) + f_endDate.substring(3, 4) + "-" + f_macAddress.substring(6, 8) + f_endDate.substring(4, 5) + f_macAddress.substring(8, 9) + f_endDate.substring(5, 6) + "-" + f_macAddress.substring(9, 11) + fnumStr.substring(1, 2) + f_macAddress.substring(11, 12) + fnumStr.substring(0, 1);

                    comLicenseUse.setComSeq(comContract.getCompany().getSeq());
                    comLicenseUse.setComContractSeq(comContract.getSeq());

                    comLicenseUse.setLicenseCode(LicenseString);
                    comLicenseUse.setLicenseName(licenseName);
                    comLicenseUse.setStatus(0);
                    comLicenseUseRepository.save(comLicenseUse);
                    comLicenseUseRepository.flush();
                    transactionManager.commit(status);

                    return responseService.getSingleResult(LicenseString);
                } catch (Exception e) {
                    transactionManager.rollback(status);
                    log.error(e.getMessage(), e);
                    return responseService.getFailResult(0,"실패");
                }
            } else {
                transactionManager.rollback(status);
                return responseService.getFailResult(0,"duple");
            }
        }else{
            return responseService.getFailResult(-1,"실패");
        }
    }

    // 유저정보 get
    @GetMapping(value = "/mypage/info")
    public Object info(
            @RequestParam(value = "loginId") String loginId
            ,HttpServletRequest httpServletRequest
    ){
        try {
            Long userSeq = userRepository.findByLoginId(loginId);
            User user = userRepository.findOne(Math.toIntExact(userSeq));

            return responseService.getSingleResult(user);
        }catch (Exception e){
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"실패");
        }
    }

    // 정보수정
    @PostMapping(value = "/mypage/edit")
    public Object edit(
            @RequestParam(value = "profileId") String loginId
            ,@RequestParam(value = "profileName") String name
            ,@RequestParam(value = "profileContact", required = false) String phone
            ,@RequestParam(value = "profileCompany", required = false) String company
            ,@RequestParam(value = "profilePosition", required = false) String position
            ,@RequestParam(value = "profileImg", required = false) String profileImg
            ,HttpServletRequest httpServletRequest
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            Long userSeq = userRepository.findByLoginId(loginId);
            User user = userRepository.findOne(Math.toIntExact(userSeq));
            user.setName(removeTag(name));
            user.setPhone(phone);
            user.setComName(removeTag(company));
            user.setPosition(removeTag(position));
            user.setUpdateDatetime(new java.util.Date());
            if(!profileImg.equals("") && profileImg != null){
                String fileUrl = amazonClient.uploadFileBase64(profileImg);
                user.setProfileImg(fileUrl);
            }
            userRepository.save(user);
            userRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"실패");
        }
    }
    // 비밀번호수정
    @PostMapping(value = "/mypage/pwModify")
    public Object pwModify(
            @RequestParam(value = "changePwId") String id
            ,@RequestParam(value = "originPw") String oldPw
            ,@RequestParam(value = "newPw") String newPw
            ,HttpServletRequest httpServletRequest
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            Long userSeq = userRepository.findByLoginId(id);
            User user = userRepository.findOne(Math.toIntExact(userSeq));
            BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
            String asisPw = user.getLoginPw();
            if(!pe.matches(oldPw,asisPw)){
                return responseService.getFailResult(0,"실패");
            }else{
                user.setLoginPw(pe.encode(newPw));
                userRepository.save(user);
                userRepository.flush();
                transactionManager.commit(status);
                return responseService.getSuccessResult();
            }
        }catch (Exception e){
            log.error(e.getMessage(),e);
            transactionManager.rollback(status);
            return responseService.getFailResult(0,"실패");
        }
    }

    @GetMapping(value = "/mypage/contract_management_download")
    public ModelAndView contractManagementDownload(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));

//        int vm32Count = versionManageMapper.get32Count(params32);
//        if(vm32Count > 0) {
        VersionManage studio32 = versionManageMapper.getStudio32();
        if(studio32 != null) {
            String[] sArray32 = studio32.getFilePath().split("\\/");
            studio32.setFilePathStr(sArray32[sArray32.length - 1]);
        }

        VersionManage mini32 = versionManageMapper.getMini32();
        if(mini32 != null) {
            String[] mArray32 = mini32.getFilePath().split("\\/");
            mini32.setFilePathStr(mArray32[mArray32.length - 1]);
        }

        VersionManage studio64 = versionManageMapper.getStudio64();
        if(studio64 != null){
            String[] sArray64 = studio64.getFilePath().split("\\/");
            studio64.setFilePathStr(sArray64[sArray64.length-1]);
        }


        VersionManage mini64 = versionManageMapper.getMini64();
        if(mini64 != null) {
            String[] mArray64 = mini64.getFilePath().split("\\/");
            mini64.setFilePathStr(mArray64[mArray64.length - 1]);
        }
//            mav.addObject("file32Path", vm32.getFilePath());
//        }

//        int vm64Count = versionManageMapper.get64Count(params64);
//        if(vm64Count > 0) {


//        }
        mav.addObject("studio32",studio32);
        mav.addObject("mini32",mini32);
        mav.addObject("studio64",studio64);
        mav.addObject("mini64",mini64);
        mav.setViewName("mypage/contract_management_download");
        return mav;
    }

    @GetMapping(value = "/mypage/wc_download")
    public ModelAndView wcDownload(
            ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));

//        int vm32Count = versionManageMapper.get32Count(params32);
//        if(vm32Count > 0) {
        VersionManage linux = versionManageMapper.getLinux();
        if(linux != null) {
            String[] sArray32 = linux.getFilePath().split("\\/");
            linux.setFilePathStr(sArray32[sArray32.length - 1]);
        }

        VersionManage windows = versionManageMapper.getWindows();
        if(windows != null){
            String[] sArray64 = windows.getFilePath().split("\\/");
            windows.setFilePathStr(sArray64[sArray64.length-1]);
        }

        mav.addObject("linux",linux);
        mav.addObject("windows",windows);
        mav.setViewName("mypage/wc_download");
        return mav;
    }

    public Object stringChange(char str){
        String str2 = Character.toString(str);

        switch(str2){
            case "a":
                str = "c".charAt(0);
                break;
            case "b":
                str = "f".charAt(0);
                break;
            case "c":
                str = "e".charAt(0);
                break;
            case "d":
                str = "h".charAt(0);
                break;
            case "e":
                str = "g".charAt(0);
                break;
            case "f":
                str = "j".charAt(0);
                break;
            case "0":
                str = "2".charAt(0);
                break;
            case "1":
                str = "5".charAt(0);
                break;
            case "2":
                str = "4".charAt(0);
                break;
            case "3":
                str = "7".charAt(0);
                break;
            case "4":
                str = "6".charAt(0);
                break;
            case "5":
                str = "9".charAt(0);
                break;
            case "6":
                str = "8".charAt(0);
                break;
            case "7":
                str = "1".charAt(0);
                break;
            case "8":
                str = "0".charAt(0);
                break;
            case "9":
                str = "3".charAt(0);
                break;
            default:
                break;
        }

        return str;
    }


    public Object numberChange(char str) {
        String str2 = Character.toString(str);
        switch(str2){
            case "0":
                str = "d".charAt(0);
                break;
            case "1":
                str = "1".charAt(0);
                break;
            case "2":
                str = "f".charAt(0);
                break;
            case "3":
                str = "g".charAt(0);
                break;
            case "4":
                str = "4".charAt(0);
                break;
            case "5":
                str = "i".charAt(0);
                break;
            case "6":
                str = "j".charAt(0);
                break;
            case "7":
                str = "7".charAt(0);
                break;
            case "8":
                str = "l".charAt(0);
                break;
            case "9":
                str = "m".charAt(0);
                break;
            default:
                break;
        }
        return str;
    }

    public Integer getAscii(char str){
        Integer num = (int) str;
        return num;
    }


    // ABBYY 라이선스 삭제 처리
    @RequestMapping(value = "/mypage/abbyyDelete", method = RequestMethod.POST)
    public Object licenseDelete(ComAbbyy abbyy, BindingResult bindingResult) {


        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"실패");
        }

//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);

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

    @RequestMapping(value = "/mypage/profileDelete", method = RequestMethod.POST)
    public Object repositoryDelete(
            @RequestParam(value="seq") Integer seq
    ) {


        Map<String,Object> result = new HashMap<>();
        User old = userRepository.findOne(seq);

        amazonClient.deleteFileFromS3BucketAsync(old.getProfileImg());
        old.setProfileImg("");
        userRepository.save(old);
        return responseService.getSuccessResult();

    }

    @GetMapping(value = "/mypage/ajax_license")
    public Object ajaxLicense(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            , @RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "licenseType", required = false) Integer licenseType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            , HttpServletRequest httpServletRequest
    ){
        Map<String,Object> result = new HashMap<>();
//        Object sessionUser = getSessionUser();
        Object s_user = super.getSessionUser(httpServletRequest);
        ObjectMapper oMapper = new ObjectMapper();


        // object -> Map
        Map<String, Object> map = oMapper.convertValue(s_user, Map.class);

        User user = userRepository.findOne((int) map.get("s_seq"));


        User finalUser = user;
        Map<String, Object> params = new HashMap<>();
        params.put("sort", "cl.seq");
        params.put("order", 1);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("userSeq",finalUser.getSeq());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar c1 = Calendar.getInstance();

        String strToday = sdf.format(c1.getTime());
        params.put("today",strToday);

        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
//            params.put("startDate",startDate);
            params.put("startDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }

        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
//            params.put("startDate",startDate);
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
        }
        if(licenseType != null){
            params.put("licenseType", licenseType);
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
        }

        int totalCount = comLicenseMapper.count(params);


        List<ComLicense> results = comLicenseMapper.find(params);
        return responseService.getListResult(totalCount,results);
    }

    @GetMapping(value = "/mypage/ajax_abbyy")
    public Object ajaxAbbyy(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "aby.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,HttpServletRequest httpServletRequest
    ){

        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");
        Map<String, Object> userParams = new HashMap<>();
        userParams.put("userSeq", userSeq);
        // company 검색
        Company company = companyMapper.findByCompanySeq(userParams);
        int comSeq = company.getSeq();

        Map<String, Object> params = new HashMap<>();
        params.put("comSeq", comSeq);
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        if(StringUtils.isEmpty(startDate)){
            String sd = null;
            params.put("startDate", sd);
        }else{
            params.put("startDate", DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"), Calendar.DATE,0),"yyyy-MM-dd HH:mm:ss"));
        }
        if(StringUtils.isEmpty(endDate)){
            String ed = null;
            params.put("endDate", ed);
        }else{
            params.put("endDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(endDate,"yyyy-MM-dd"),Calendar.DATE,1),"yyyy-MM-dd HH:mm:ss"));
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = comAbbyyMapper.count(params);


        List<ComLicense> results = comAbbyyMapper.find(params);
        return responseService.getListResult(totalCount,results);
    }

    @GetMapping(value="/mypage/license_detail")
    public Object licenseDetail(
            @RequestParam(value = "seq") Integer seq
            ,@RequestParam(value="page") Integer page
    ){
        Map<String,Object> result = new HashMap<>();
        Map<String,Object> params = new HashMap<>();
        params.put("row",5);
        params.put("start",page*5);
        params.put("seq",seq);
        int totalCount = comLicenseMapper.getComLicenseUsesCount(seq);
        List<ComLicenseUse> comLicenseUses = comLicenseMapper.getComLicenseUses(params);
        result.put("total",totalCount);
        result.put("list",comLicenseUses);
        return responseService.getListResult(totalCount,comLicenseUses);
    }

    @GetMapping(value="/mypage/abbyy_detail")
    public Object abbyyDetail(
            @RequestParam(value = "seq") Integer seq
    ){
        ComAbbyy comAbbyy = comAbbyyRepository.findOne(seq);

        return responseService.getSingleResult(comAbbyy);
    }

    @GetMapping(value = "/mypage/re_download")
    public Object reDownload(
            @RequestParam(value="seq") Integer seq
    ){
        ComLicenseUse comLicenseUse = comLicenseUseRepository.findOne(seq);
        ComLicense comLicense = comLicenseMapper.getComLicense(comLicenseUse.getComLicense().getSeq());
        ComContract comContract = comContractRepository.findOne(comLicense.getComContractSeq());

        Map<String,Object> result = new HashMap<>();
        if(comLicense.getLicenseType() != 1){ //wc
            String tariff = "";
            if(comLicense.getSubscribeType() == 1){
                tariff = "Hour";
            }else if(comLicense.getSubscribeType() == 2){
                tariff = "Month";
            }else{
                tariff = "Annual";
            }

            String license = secureService.encode("{\n" +
                    " \"type\" : \"Organization\",\n" +
                    " \"tariff\" : \""+tariff+"\",\n" +
                    " \"licenseKey\" : \""+comLicenseUse.getLicenseCode()+"\",\n" +
                    " \"subscriptor\" : \""+comLicenseUse.getComUuid()+"\",\n" +
                    " \"name\" : \""+comLicenseUse.getLicenseName()+"\",\n" +
                    " \"issuedDatetime\" : "+comContract.getCreateDatetime().getTime()+",\n" +
                    " \"licenseStartedDatetime\" : "+comContract.getContractStart().getTime()+",\n" +
                    " \"licenseFinishedDatetime\" : "+(comContract.getContractEnd().getTime()+86400000-1000)+",\n" +
                    " \"countUnattended\" : "+comLicenseUse.getCountUnattended()+",\n" +
                    " \"countAttended\" : "+comLicenseUse.getCountAttended()+",\n" +
                    " \"countStudio\" : "+comLicenseUse.getCountDeveloper()+",\n" +
                    " \"priceUnattended\" : "+comLicense.getUnattendedLicenseListPrice()+",\n" +
                    " \"priceAttended\" : "+comLicense.getAttendedLicenseListPrice()+",\n" +
                    " \"priceStudio\" : "+comLicense.getStudioLicenseListPrice()+"\n" +
                    "}");
            result.put("license",license);
            result.put("licenseName",comLicenseUse.getLicenseName());
            return responseService.getSingleResult(result);

        }else{
            String mac[] = {};
            String macAddress = comLicenseUse.getMacAddress();
            if(macAddress.toLowerCase().contains(":")) {
                mac = macAddress.toLowerCase().split(":");
            }else if(macAddress.toLowerCase().contains("-")){
                mac = macAddress.toLowerCase().split("-");
            }

            String f_macAddress = "";
            Integer macAsciiSum = 0;
            for (int i = 0; i < mac.length; i++) {
                //            System.out.println(getHexToDec(mac[i]));
                String arr1 = mac[i].substring(0, 1);
                String arr2 = mac[i].substring(1, 2);
                f_macAddress += stringChange(arr1.charAt(0)).toString() + stringChange(arr2.charAt(0)).toString();
                macAsciiSum += getAscii(arr1.charAt(0));
                macAsciiSum += getAscii(arr2.charAt(0));
            }


            String endDate = comContract.getContractEnd().toString();
//            SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" , Locale.KOREA );
//            String endDate = sdf.format( endDateTime );

            String[] endDateArray1 = endDate.split(" ");

            String[] endDateArray = endDateArray1[0].split("-");
            String time = endDateArray[0].substring(2, 4) + endDateArray[1] + endDateArray[2];
            System.out.println(time);
            String f_endDate = "";
            Integer endDateAsciiSum = 0;
            for (int i = 0; i < time.length(); i++) {
                f_endDate += numberChange(time.substring(i, (i+1)).charAt(0));
                endDateAsciiSum += getAscii(time.substring(i, (i+1)).charAt(0));
            }
            Integer acsiiSum = macAsciiSum+endDateAsciiSum;
            String num1 = String.valueOf(acsiiSum);
            num1 = num1.substring(num1.length()-2, num1.length());

            Integer fnum1 = Integer.parseInt(num1);
            Integer fnum2 = Integer.parseInt(endDateArray[2]);

            Integer fnum = fnum1*fnum2;
            String fnumStr = String.valueOf(fnum).substring(String.valueOf(fnum).length()-2, String.valueOf(fnum).length());
//
//            String[] endDate1 = endDate.split(" ");
//            String[] endDateArray = endDate1[0].split("-");
//            String time = endDateArray[0].substring(2,4)+endDateArray[1]+endDateArray[2];

            String LicenseString = f_macAddress.substring(0, 2) + time.substring(0, 1) + f_macAddress.substring(2, 3) + f_endDate.substring(1, 2) + "-" + f_macAddress.substring(3, 5) + f_endDate.substring(2, 3) + f_macAddress.substring(5, 6) + f_endDate.substring(3, 4) + "-" + f_macAddress.substring(6, 8) + f_endDate.substring(4, 5) + f_macAddress.substring(8, 9) + f_endDate.substring(5, 6) + "-" + f_macAddress.substring(9, 11) + fnumStr.substring(1, 2) + f_macAddress.substring(11, 12) + fnumStr.substring(0, 1);


            result.put("license",LicenseString);
            result.put("licenseName",comLicenseUse.getLicenseName());
            return responseService.getSingleResult(result);
        }

    }

    @GetMapping(value = "/mypage/re_download_old")
    public Object reDownloadOld(
            @RequestParam(value="seq") Integer seq
    ){
        ComLicenseUse comLicenseUse = comLicenseUseRepository.findOne(seq);
        ComLicense comLicense = comLicenseRepository.findOne(comLicenseUse.getComLicense().getSeq());
//        ComLicense comLicense = comLicenseMapper.getComLicense(comLicenseUse.getComLicense().getSeq());
        ComContract comContract = comContractRepository.findOne(comLicense.getComContract().getSeq());

        Map<String,Object> result = new HashMap<>();
        if(comLicense.getLicenseType() != 1){ //wc
            String tariff = "";
            if(comLicense.getSubscribeType() == 1){
                tariff = "Hour";
            }else if(comLicense.getSubscribeType() == 2){
                tariff = "Month";
            }else{
                tariff = "Annual";
            }

            String license = secureService.encode("{\n" +
                    " \"type\" : \"Organization\",\n" +
                    " \"tariff\" : \""+tariff+"\",\n" +
                    " \"licenseKey\" : \""+comLicenseUse.getLicenseCode()+"\",\n" +
                    " \"subscriptor\" : \""+comLicenseUse.getComUuid()+"\",\n" +
                    " \"name\" : \""+comLicenseUse.getLicenseName()+"\",\n" +
                    " \"issuedDatetime\" : "+comContract.getCreateDatetime().getTime()+",\n" +
                    " \"licenseStartedDatetime\" : "+comContract.getContractStart().getTime()+",\n" +
                    " \"licenseFinishedDatetime\" : "+(comContract.getContractEnd().getTime()+86400000-1000)+",\n" +
                    " \"countUnattended\" : "+comLicenseUse.getCountUnattended()+",\n" +
                    " \"countAttended\" : "+comLicenseUse.getCountAttended()+",\n" +
                    " \"countDeveloper\" : "+comLicenseUse.getCountDeveloper()+",\n" +
                    " \"priceUnattended\" : "+comLicense.getUnattendedLicenseListPrice()+",\n" +
                    " \"priceAttended\" : "+comLicense.getAttendedLicenseListPrice()+",\n" +
                    " \"priceDeveloper\" : "+comLicense.getStudioLicenseListPrice()+"\n" +
                    "}");
            return responseService.getSingleResult(license);
        }else{
            String mac[] = {};
            String macAddress = comLicenseUse.getMacAddress();
            if(macAddress.toLowerCase().contains(":")) {
                mac = macAddress.toLowerCase().split(":");
            }else if(macAddress.toLowerCase().contains("-")){
                mac = macAddress.toLowerCase().split("-");
            }

            String f_macAddress = "";
            Integer macAsciiSum = 0;
            for (int i = 0; i < mac.length; i++) {

                String arr1 = mac[i].substring(0, 1);
                String arr2 = mac[i].substring(1, 2);
                f_macAddress += stringChange(arr1.charAt(0)).toString() + stringChange(arr2.charAt(0)).toString();
                macAsciiSum += getAscii(arr1.charAt(0));
                macAsciiSum += getAscii(arr2.charAt(0));
            }



            String endDate = comContract.getContractEnd().toString();

            String[] endDateArray1 = endDate.split(" ");

            String[] endDateArray = endDateArray1[0].split("-");
            String time = endDateArray[0].substring(2, 4) + endDateArray[1] + endDateArray[2];
            System.out.println(time);
            String f_endDate = "";
            Integer endDateAsciiSum = 0;
            for (int i = 0; i < time.length(); i++) {
                f_endDate += numberChange(time.substring(i, (i+1)).charAt(0));
                endDateAsciiSum += getAscii(time.substring(i, (i+1)).charAt(0));
            }
            Integer acsiiSum = macAsciiSum+endDateAsciiSum;
            String num1 = String.valueOf(acsiiSum);
            num1 = num1.substring(num1.length()-2, num1.length());

            Integer fnum1 = Integer.parseInt(num1);
            Integer fnum2 = Integer.parseInt(endDateArray[2]);

            Integer fnum = fnum1*fnum2;
            String fnumStr = String.valueOf(fnum).substring(String.valueOf(fnum).length()-2, String.valueOf(fnum).length());

            String LicenseString = f_macAddress.substring(0, 2) + time.substring(0, 1) + f_macAddress.substring(2, 3) + f_endDate.substring(1, 2) + "-" + f_macAddress.substring(3, 5) + f_endDate.substring(2, 3) + f_macAddress.substring(5, 6) + f_endDate.substring(3, 4) + "-" + f_macAddress.substring(6, 8) + f_endDate.substring(4, 5) + f_macAddress.substring(8, 9) + f_endDate.substring(5, 6) + "-" + f_macAddress.substring(9, 11) + fnumStr.substring(1, 2) + f_macAddress.substring(11, 12) + fnumStr.substring(0, 1);


            return responseService.getSingleResult(LicenseString);
        }
    }

    @GetMapping(value="/mypage/re_emailsend")
    public Object reEmail(
            @RequestParam(value="seq") Integer seq
            ,@RequestParam(value="email") String email
    ){
        ComLicenseUse comLicenseUse = comLicenseUseRepository.findOne(seq);
//        ComLicense comLicense = comLicenseMapper.getComLicense(comLicenseUse.getComLicense().getSeq());
        ComLicense comLicense = comLicenseRepository.findOne(comLicenseUse.getComLicense().getSeq());
        ComContract comContract = comContractRepository.findOne(comLicense.getComContract().getSeq());
        Map<String,Object> result = new HashMap<>();
        String license = "";
        if(comLicense.getLicenseType() != 1){ //wc
            String tariff = "";
            if(comLicense.getSubscribeType() == 1){
                tariff = "Hour";
            }else if(comLicense.getSubscribeType() == 2){
                tariff = "Month";
            }else{
                tariff = "Annual";
            }
            license = secureService.encode("{\n" +
                    " \"type\" : \"Organization\",\n" +
                    " \"tariff\" : \""+tariff+"\",\n" +
                    " \"licenseKey\" : \""+comLicenseUse.getLicenseCode()+"\",\n" +
                    " \"subscriptor\" : \""+comLicenseUse.getComUuid()+"\",\n" +
                    " \"name\" : \""+comLicenseUse.getLicenseName()+"\",\n" +
                    " \"issuedDatetime\" : "+comContract.getCreateDatetime().getTime()+",\n" +
                    " \"licenseStartedDatetime\" : "+comContract.getContractStart().getTime()+",\n" +
                    " \"licenseFinishedDatetime\" : "+(comContract.getContractEnd().getTime()+86400000-1000)+",\n" +
                    " \"countUnattended\" : "+comLicenseUse.getCountUnattended()+",\n" +
                    " \"countAttended\" : "+comLicenseUse.getCountAttended()+",\n" +
                    " \"countStudio\" : "+comLicenseUse.getCountDeveloper()+",\n" +
                    " \"priceUnattended\" : "+comLicense.getUnattendedLicenseListPrice()+",\n" +
                    " \"priceAttended\" : "+comLicense.getAttendedLicenseListPrice()+",\n" +
                    " \"priceStudio\" : "+comLicense.getStudioLicenseListPrice()+"\n" +
                    "}");
        }else{
            String mac[] = {};
            String macAddress = comLicenseUse.getMacAddress();
            if(macAddress.toLowerCase().contains(":")) {
                mac = macAddress.toLowerCase().split(":");
            }else if(macAddress.toLowerCase().contains("-")){
                mac = macAddress.toLowerCase().split("-");
            }

            String f_macAddress = "";
            Integer macAsciiSum = 0;
            for (int i = 0; i < mac.length; i++) {
                //            System.out.println(getHexToDec(mac[i]));
                String arr1 = mac[i].substring(0, 1);
                String arr2 = mac[i].substring(1, 2);
                f_macAddress += stringChange(arr1.charAt(0)).toString() + stringChange(arr2.charAt(0)).toString();
                macAsciiSum += getAscii(arr1.charAt(0));
                macAsciiSum += getAscii(arr2.charAt(0));
            }

            String endDate = comContract.getContractEnd().toString();
            String[] endDateArray1 = endDate.split(" ");


            String[] endDateArray = endDateArray1[0].split("-");
            String time = endDateArray[0].substring(2, 4) + endDateArray[1] + endDateArray[2];

            String f_endDate = "";
            Integer endDateAsciiSum = 0;
            for (int i = 0; i < time.length(); i++) {
                f_endDate += numberChange(time.substring(i, (i+1)).charAt(0));
                endDateAsciiSum += getAscii(time.substring(i, (i+1)).charAt(0));
            }
            Integer acsiiSum = macAsciiSum+endDateAsciiSum;
            String num1 = String.valueOf(acsiiSum);
            num1 = num1.substring(num1.length()-2, num1.length());

            Integer fnum1 = Integer.parseInt(num1);
            Integer fnum2 = Integer.parseInt(endDateArray[2]);

            Integer fnum = fnum1*fnum2;
            String fnumStr = String.valueOf(fnum).substring(String.valueOf(fnum).length()-2, String.valueOf(fnum).length());
            license = f_macAddress.substring(0, 2) + time.substring(0, 1) + f_macAddress.substring(2, 3) + f_endDate.substring(1, 2) + "-" + f_macAddress.substring(3, 5) + f_endDate.substring(2, 3) + f_macAddress.substring(5, 6) + f_endDate.substring(3, 4) + "-" + f_macAddress.substring(6, 8) + f_endDate.substring(4, 5) + f_macAddress.substring(8, 9) + f_endDate.substring(5, 6) + "-" + f_macAddress.substring(9, 11) + fnumStr.substring(1, 2) + f_macAddress.substring(11, 12) + fnumStr.substring(0, 1);



        }

        try {
            Template t = configuration.getTemplate("mail/license.ftl");
            if(comLicense.getLicenseType() != 1) {
                t = configuration.getTemplate("mail/license.ftl");
            }else{
                t = configuration.getTemplate("mail/license_pc.ftl");
            }
            final Map<String, Object> params = new HashMap<>();

            params.put("license", license);
            // 파일 객체 생성
            File file = new File("./uploads/license_"+comLicenseUse.getLicenseName()+".license") ;
            // true 지정시 파일의 기존 내용에 이어서 작성

            try(FileWriter fw = new FileWriter(file, false)){

                // 파일안에 문자열 쓰기
                fw.write(license);
                fw.flush();

            }catch(Exception e){
                e.printStackTrace();
                System.out.println(e);
            }
            //params.put("loginUrl", "www.google.com");
            final String content = FreeMarkerTemplateUtils.processTemplateIntoString(t, params);

            emailService.sendmail("noreply@aworksrpa.com", "[a.works] 라이센스 발급 메일.", content, email, null,"license_"+comLicenseUse.getLicenseName()+".license");
            return responseService.getSuccessResult();
        }catch (Exception e){

            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"실패");
        }

    }

    @GetMapping(value = "/mypage/ajax_list")
    public Object ajaxList(
            HttpServletRequest httpServletRequest
            ,@RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "contractStatus", required = false) Integer contractStatus
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,@RequestParam(value = "comSeq",required = false) Integer comSeq
            ,@RequestParam(value="licenseType", required = false) Integer licenseType
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "com.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "1") Integer order
    ){
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");
        Map<String, Object> params = new HashMap<>();
        params.put("userSeq", userSeq);
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("order",order);
        Map<String,Object> result = new HashMap<>();
        if( (Integer) map.get("s_level") == 2){


            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            Calendar c1 = Calendar.getInstance();

            String strToday = sdf.format(c1.getTime());
            params.put("today",strToday);

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

            if(contractStatus != null && contractStatus > 0){
                params.put("contractStatus",contractStatus);
            }

            if(licenseType != null){
                params.put("licenseType",licenseType);
            }
            if(comSeq != null){
                params.put("comSeq",comSeq);
            }
//            Company company = companyMapper.findByCompanySeq(params);
//            int comSeq = company.getSeq();
//
//            Map<String, Object> contractParams = new HashMap<String, Object>() {{
//                put("comSeq", comSeq);
//            }};
//            ComContract comContract = comContractMapper.findByContractCompanyInfo(contractParams);
//            mav.addObject("company
//            ", company);
            User user = userRepository.findOne(userSeq);
            int count = comContractMapper.count(params);

            List<ComContract> results = comContractMapper.find(params);
            return responseService.getListResult(count,results);
        }
        // company 검색




        return result;
    }

    private String removeTag(String html) throws Exception {
        return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
    }

    @RequestMapping(value="/mypage/fileDownload")
    public void fileDownload(HttpServletRequest request, HttpServletResponse response,
                             @RequestParam(value = "fileUrl", required = false) String fileUrl,
                             @RequestParam(value = "seq", required = false) Integer seq,
                             ModelMap model) throws Exception
    {
        Map<String, Object> params = new HashMap<>();
        params.put("seq", seq);
        BbsFile fileInfo = bbsFileMapper.findByFile(params);
        String originalFileName = fileInfo.getOriginalFileName();
        String filePath = fileUrl;

        S3Object s3Object = amazonClient.downloadFile(filePath);
        String realFileName = fileStorageService.storeFile(s3Object, originalFileName);
        String realPath = String.valueOf(Paths.get("./temp").toAbsolutePath().normalize());

        File file = new File(realPath, realFileName);
        String userAgent = request.getHeader("User-Agent");
        boolean ie = userAgent.indexOf("MSIE") > -1 || userAgent.indexOf("rv:11") > -1;
        String fileName = null;

        if (ie) {
            fileName = URLEncoder.encode(file.getName(), "utf-8");
        } else {
            fileName = new String(file.getName().getBytes("utf-8"),"iso-8859-1");
        }

        response.setContentType("application/octet-stream");
        response.setHeader("Content-Disposition","attachment;filename=\"" +fileName+"\";");

//        FileInputStream fis = new FileInputStream(file);
//        BufferedInputStream bis = new BufferedInputStream(fis);


        try(FileInputStream fis = new FileInputStream(file)){
            try(BufferedInputStream bis = new BufferedInputStream(fis)){
                ServletOutputStream so = response.getOutputStream();
                try(BufferedOutputStream bos = new BufferedOutputStream(so)){
                    byte[] data = new byte[2048];
                    int input = 0;
                    while ((input = bis.read(data)) != -1) {
                        bos.write(data, 0, input);
                        bos.flush();
                    }
                    file.delete();
                }
            }
        }
    }
}
