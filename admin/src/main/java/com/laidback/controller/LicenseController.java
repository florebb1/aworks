package com.laidback.controller;

import com.google.common.hash.HashCode;
import com.google.common.hash.HashFunction;
import com.google.common.hash.Hashing;
import com.laidback.mapper.ComLicenseMapper;
import com.laidback.mapper.ComLicenseUseMapper;
import com.laidback.mapper.CompanyMapper;
import com.laidback.mapper.TrialMacMapper;
import com.laidback.model.*;
import com.laidback.repository.*;
import com.laidback.response.ResponseService;
import com.laidback.service.CustomEncode;
import com.laidback.service.SecureService;
import com.laidback.util.DateUtil;
import freemarker.template.Template;
import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileWriter;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class LicenseController extends RootController {

    @Autowired
    CompanyMapper companyMapper;

    @Autowired
    ComLicenseMapper comLicenseMapper;

    @Autowired
    ComLicenseRepository comLicenseRepository;

    @Autowired
    ComLicenseUseRepository comLicenseUseRepository;

    @Autowired
    private SecureService secureService;

    @Autowired
    UserRepository userRepository;

    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    ComContractRepository comContractRepository;

    @Autowired
    ComLicenseUseMapper comLicenseUseMapper;

    @Autowired
    private CustomEncode customEncode;

    @Autowired
    TrialMacMapper trialMacMapper;

    @Autowired
    protected ResponseService responseService;
    // 라이센스 리스트 조회
    @GetMapping(value = "/license/list")
    public ModelAndView licenseList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "cl.seq") String sort
            ,@RequestParam(value = "order", defaultValue = "1") Integer order
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
//        setOrderValueChange(mav, params, order);

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

        int totalCount = comLicenseMapper.count(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<ComLicense> results = comLicenseMapper.find(params);

        mav.addObject("results",results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);

        mav.setViewName("license/list");
        return mav;
    }

    // 라이센스 등록 화면 호출
    @GetMapping(value = "/license/write")
    public ModelAndView licenceWrite(
            ModelAndView mav
    ){
        mav.setViewName("license/write");
        return mav;
    }

    // 라이센스 상세보기 화면 호출
    @GetMapping(value = "/license/detail")
    public ModelAndView licenceDetail(ModelAndView mav
         , @RequestParam(value="seq") Integer seq )
    {
        ComLicense comLicense = comLicenseMapper.getComLicense(seq);
        ComContract comContract = comContractRepository.findOne(comLicense.getComContractSeq());
//        Company company = companyRepository.findOne(comLicense.getComSeq());
//        if(company.getUserSeq() != null){
//            User user = userRepository.findOne(company.getUserSeq());
//            mav.addObject("email",user.getLoginId());
//        }

        mav.addObject("license",comLicense);
//        if(comLicense.getSubscribeType() == 1){
//            mav.addObject("tariff","Hour");
//        }else{
//            mav.addObject("tariff","Year");
//        }
//        System.out.println(comLicense.getSettingConfig());

        List<ComLicenseUse> comLicenseUses = comLicenseMapper.getComLicenseUsesTotal(comLicense.getSeq());
        mav.addObject("comLicenseTotal",comLicenseUses.size());
        mav.addObject("comLicenseUses",comLicenseUses);
        mav.addObject("email",comContract.getContractChargerEmail());
        mav.addObject("comContract",comContract);
        mav.setViewName("license/detail");
        return mav;
    }

    // 라이센스 상세보기 화면 호출
    @GetMapping(value = "/license/licenseModify")
    public ModelAndView licenseModify(ModelAndView mav
            , @RequestParam(value="seq") Integer seq )
    {
        ComLicense comLicense = comLicenseMapper.getComLicense(seq);
        mav.addObject("license", comLicense);
//        if(comLicense.getSubscribeType() == 1){
//            mav.addObject("tariff","Hour");
//        }else{
//            mav.addObject("tariff","Year");
//        }

        mav.setViewName("license/modify");
        return mav;
    }

    @GetMapping(value = "/license/test")
    public Object licenseCrypt(
    ){
        Map<String,Object> result = new HashMap<>();
//        result.put("license",secureService.decode("e2572d7510eecdf3d99e5181d66c55811abd2d87a37f9bb20998327481520345257d143653f083aa627620c20cc093be4ffcb11ed709b8b4ee58fba18cfa3dde701ce06035c6ddc0c94d64ed244c8c5e6321cda97bb248d5221330e868a78a4e6dbe614a1d14d5c4bc1925fc07ff1010d8a4ac595920c7ea415df8862d1eea49fd9d4322f938789b755784b848758c9c89bee7a8698876a3f2b1e2d92af5db102c4e967e9e18a0135215430498f73f4bc11ae32b4dab50cb543317e01bac055eca5145eefa4deff445354a87275ba0045f7c523f43c4b7a33f9ba743af1904efe645dd4ce0017f44a6321a7e7cc21bc642251a509776109c779a0c755e56b7ca6a1b10acd7bd85fe5c822cd5e4a00d6594d24a8204f098f43a0fb154fd3070747eb6878ca5eec9aa494efc3071d8535124f9abaf4859d52876752cfcc83aaa17c2dd07a7f93651e96281fd14f292d04fe4b4c07a797edcbed090a2a2997b4b76cde4f6e1e9c4e9ae93c9444841c5d514306ea509b6240785abd1e15330c83c157ffb651fbfb32c6eafabc95ce4413f0498b9022652a7af54169a6c9338650e1b6a74992e3ada9e7a8723998e1d50cac8"));
        return secureService.decode("dbcbeb90019d2eb7b68a2ebda01f4085974bd28abef38be04f33f104fcdbf63788928b44112da440136e0c699cdaa3e58e2eccf6c51998fe9abdeb820a5b0dcf1c3b05a2eb5d38952f917927e3ca151dc9800c49e3cc7e126c3fee4808cf58a801f3114d2277fb908651907077d89ad96bc3828f72f25b822d291d5d375ec36c8a05459affd8906223cfe96ab748fcabedc8ef2408f92d516ece9c1acc6e7359a7cd1c1ab3332fd57601a2d96ba6e29159b1c18bb1994fc8bc82484e85d8ab466a3796506546303eeba33b807c92dd8e9fcc1c71339582cf2398ebca6d9d6f0a658c76bed7dfde65ea06733e8d3e8cbb9e757ae1aab380f0f8a552b59e80a503071598df5665355fdd93c065b5524546b473d555e2d5273490e4014f1cfb7dbb5252ba83f1a132f8088de4a84a89bbb570f4283361812298e345537617b097a4ccb0719a5b3155d00b1ff4266f86581597cfdbe7e557188be9a65f4e831c7b0d1b6c4649950b2b596b74eeb03b40ae2ebfb87557a4cc8f6717f77c893c313b5c78d24081afb23d23f15a8ed683ec56619d83d50e83466d9bbfabffdcf58b3ca19d7c41ef8cb9c87b67bf34a9ec76c7f9eabfdd3e376ed44df447ee087dc36c7d77b5f43e95ae1ec0a28239f1ecaee5a5");
    }



    @PostMapping(value = "/license/searchForCompany")
    public Object searchForCompanyList(
            @RequestParam(value = "searchCom") String searchCom)
    {
        Map<String, Object> params = new HashMap<>();
        Map<String, Object> result = new HashMap<>();
        if(searchCom != null ) {
            params.put("searchCom", searchCom);
            /*List<Company> companyList = companyMapper.searchForCompanyList(params);*/
//            result.put("companyList", companyMapper.searchForCompanyList(params));
            return responseService.getSuccessResult();
        } else {
            return responseService.getFailResult(0,"");
        }

    }

    // 라이센스 삭제 처리
    @RequestMapping(value = "/license/licenseDelete", method = RequestMethod.POST)
    public Object licenseDelete(
            @RequestParam(value = "deleteArray") String checkSeq
    ) {

        Map<String,Object> result = new HashMap<>();

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{

            String[] deleteArrayList = checkSeq.split("\\|");
            Integer deleteY = 0;
            Integer deleteN = 0;
            for(String seq : deleteArrayList) {
                int useCount = comLicenseMapper.getComLicenseUsesCount(Integer.parseInt(seq));
                if(useCount == 0) {
                    ++deleteY;
                    ComLicense comLicense = comLicenseRepository.findOne(Integer.parseInt(seq));
//                    comLicense.setSeq(Integer.parseInt(seq));
                    comLicense.setDeleteDatetime(new java.util.Date());
                    comLicenseRepository.save(comLicense);
                    comLicenseRepository.flush();
                }else{
                    ++deleteN;
                }
            }

            transactionManager.commit(status);

            result.put("deleteY",deleteY);
            result.put("deleteN",deleteN);
            return responseService.getSingleResult(result);
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    private String getHexToDec(String hex) {
        long v = Long.parseLong(hex, 16);
        return String.valueOf(v);
    }

    // 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/license/execlDownList")
    public Object getExeclDownList(
            @RequestParam(value = "checkSeq") String checkSeq
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "1") Integer order
    ) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();


        String[] chkValueArrList = checkSeq.split("\\|");
        ArrayList<Integer> licenseList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            licenseList.add(Integer.parseInt(seq));
        }
        params.put("licenseList", licenseList);
        params.put("sort",sort);
        params.put("order",order);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar c1 = Calendar.getInstance();

        String strToday = sdf.format(c1.getTime());
        params.put("today",strToday);

        List<ComLicense> execlDownList = comLicenseMapper.getExeclDownList(params);
        for(ComLicense license: execlDownList){
            ComContract comContract = comContractRepository.findOne(license.getComContractSeq());
            license.setComContract(comContract);
        }
        return responseService.getListResult(execlDownList.size(),execlDownList);
    }

    @GetMapping(value = "/license/ajax_list")
    public Object licenseAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "cl.seq") String sort
            ,@RequestParam(value = "order", defaultValue = "1") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,@RequestParam(value = "contractSeq", required = false) Integer contractSeq
            ,@RequestParam(value="contractStatus", required = false) Integer contractStatus
            ,@RequestParam(value="licenseType",required = false) Integer licenseType
            ,@RequestParam(value= "licenseStatus", required = false) Integer licenseStatus
    ){
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("order",order);
        params.put("contractSeq",contractSeq);

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

        if(contractStatus != null){
            params.put("contractStatus",contractStatus);
        }

        if(licenseType != null){
            params.put("licenseType",licenseType);
        }

        if(licenseStatus != null){
            params.put("licenseStatus",licenseStatus);
        }

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }

        int totalCount = comLicenseMapper.count(params);


        List<ComLicense> results = comLicenseMapper.find(params);


        return responseService.getListResult(totalCount,results);
    }
    // workcenter 발급
    @PostMapping(value = "/license/license_apply")
    public Object licenseApply(
            @RequestParam(value="licenseSeq") Integer licenseSeq
            ,@RequestParam(value="comUuid", required = false) String comUuid
            ,@RequestParam(value="countUnattended") Integer countUnattended
            ,@RequestParam(value="countAttended") Integer countAttended
            ,@RequestParam(value="countDeveloper") Integer countDeveloper
            ,@RequestParam(value="countWorkcenter") Integer countWorkcenter
            ,@RequestParam(value="licenseName") String licenseName
    ){
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        ComLicenseUse comLicenseUse = new ComLicenseUse();
        Map<String,Object> result = new HashMap<>();
        Map<String,Object> params = new HashMap<>();
        try{

            String licenseCode = UUID.randomUUID().toString();
            comLicenseUse.setCreateDatetime(new java.util.Date());
            comLicenseUse.setLicenseCode(licenseCode);

            ComLicense comLicense = comLicenseMapper.getComLicense(licenseSeq);

            comLicenseUse.setComLicense(comLicense);
            comLicenseUse.setStatus(0);
            ComContract comContract = comContractRepository.findOne(comLicense.getComContractSeq());
            params.put("comContractSeq",comContract.getSeq());
            params.put("licenseName",licenseName);
            int dupleName = comLicenseUseMapper.dupleName(params);
            if(dupleName == 0) {
                Company company = companyRepository.findOne(comContract.getCompany().getSeq());
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
                    if (company.getComUuid() != null) {
                        comLicenseUse.setComUuid(company.getComUuid());
                        comUuidStr = company.getComUuid();
                    } else {
                        comLicenseUse.setComUuid("17c0ba0c-33ea-43f8-877f-6c8aa5b37676");
                        comUuidStr = "17c0ba0c-33ea-43f8-877f-6c8aa5b37676";
                    }
                }
                comLicenseUse.setComSeq(company.getSeq());
                comLicenseUse.setComContractSeq(comContract.getSeq());

                comLicenseUse.setCountUnattended(countUnattended);
                comLicenseUse.setCountAttended(countAttended);
                comLicenseUse.setCountDeveloper(countDeveloper);
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
                        " \"countStudio\" : " + countDeveloper + ",\n" +
                        " \"priceUnattended\" : " + comLicense.getUnattendedLicenseListPrice() + ",\n" +
                        " \"priceAttended\" : " + comLicense.getAttendedLicenseListPrice() + ",\n" +
                        " \"priceStudio\" : " + comLicense.getStudioLicenseListPrice() + "\n" +
                        "}");

                return responseService.getSingleResult(license);
            }else{
                transactionManager.rollback(status);
                return responseService.getFailResult(-1,"");
            }
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);

            return responseService.getFailResult(0,"");
        }

    }

    @PostMapping(value = "/license/license_apply_old")
    public Object licenseApplyOld(
            @RequestParam(value="licenseSeq") Integer licenseSeq
            ,@RequestParam(value="comUuid", required = false) String comUuid
            ,@RequestParam(value="countUnattended") Integer countUnattended
            ,@RequestParam(value="countAttended") Integer countAttended
            ,@RequestParam(value="countDeveloper") Integer countDeveloper
            ,@RequestParam(value="licenseName") String licenseName
    ){
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        ComLicenseUse comLicenseUse = new ComLicenseUse();
        Map<String,Object> result = new HashMap<>();
        try{
            String licenseCode = UUID.randomUUID().toString();
            comLicenseUse.setCreateDatetime(new java.util.Date());
            comLicenseUse.setLicenseCode(licenseCode);

            ComLicense comLicense = comLicenseMapper.getComLicense(licenseSeq);

            comLicenseUse.setComLicense(comLicense);
            comLicenseUse.setStatus(0);
            ComContract comContract = comContractRepository.findOne(comLicense.getComContractSeq());
            Company company = companyRepository.findOne(comContract.getCompany().getSeq());
            String comUuidStr = "";
            if(comUuid != null && !comUuid.equals("")){
//                comLicenseUse.setComUuid(comUuid);
                // 파일 분석
                String decodeData = secureService.decode(comUuid);
                System.out.println(decodeData);
                JSONParser parser = new JSONParser();

                try{
                    Object obj = parser.parse(decodeData);
                    JSONObject jsonObj = (JSONObject) obj;
                    System.out.println(jsonObj.get("subscriptor").toString());
                    comLicenseUse.setComUuid(jsonObj.get("subscriptor").toString());
                    comUuidStr = jsonObj.get("subscriptor").toString();
                }catch(Exception e){
                    e.printStackTrace();
                }

            }else{
                if(company.getComUuid() != null) {
                    comLicenseUse.setComUuid(company.getComUuid());
                    comUuidStr = company.getComUuid();
                }else{
                    comLicenseUse.setComUuid("17c0ba0c-33ea-43f8-877f-6c8aa5b37676");
                    comUuidStr = "17c0ba0c-33ea-43f8-877f-6c8aa5b37676";
                }
            }
            comLicenseUse.setCountUnattended(countUnattended);
            comLicenseUse.setCountAttended(countAttended);
            comLicenseUse.setCountDeveloper(countDeveloper);
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
                    " \"countDeveloper\" : "+countDeveloper+",\n" +
                    " \"priceUnattended\" : "+comLicense.getUnattendedLicenseListPrice()+",\n" +
                    " \"priceAttended\" : "+comLicense.getAttendedLicenseListPrice()+",\n" +
                    " \"priceDeveloper\" : "+comLicense.getStudioLicenseListPrice()+"\n" +
                    "}");

            return responseService.getSingleResult(license);
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    @PostMapping(value = "/license/license_serial_make")
    public Object licenseSerialMake(
            @RequestParam(value="macAddress") String macAddress
            , @RequestParam(value="botType") String botType
            , @RequestParam(value="licenseSeq", required = false) Integer licenseSeq
            , @RequestParam(value="licenseName") String licenseName
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
        System.out.println(totalMac);
        if(totalMac == 0) {
            try {
                //            comLicense.setMacAddress(macAddress);

                comLicenseUse.setCountAttended(1);
                comLicenseUse.setCountDeveloper(1);


                comLicenseUse.setCreateDatetime(new java.util.Date());
                comLicenseUse.setMacAddress(macAddress.toLowerCase());
                comLicenseUse.setStatus(0);


                ComLicense comLicense = comLicenseRepository.findOne(licenseSeq);

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
                    f_macAddress += customEncode.stringChange(arr1.charAt(0)).toString() + customEncode.stringChange(arr2.charAt(0)).toString();
                    macAsciiSum += customEncode.getAscii(arr1.charAt(0));
                    macAsciiSum += customEncode.getAscii(arr2.charAt(0));
                }


                ComContract comContract = comContractRepository.findOne(comLicense.getComContract().getSeq());

                cparams.put("comContractSeq",comContract.getSeq());
                cparams.put("licenseName",licenseName);
                int dupleName = comLicenseUseMapper.dupleName(cparams);
                if(dupleName == 0) {

                    String endDate = comContract.getContractEnd().toString();
                    //                System.out.println(endDate);
                    String[] endDateArray1 = endDate.split(" ");

                    String[] endDateArray = endDateArray1[0].split("-");
                    String time = endDateArray[0].substring(2, 4) + endDateArray[1] + endDateArray[2];
                    System.out.println(time);
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
                    String LicenseString = f_macAddress.substring(0, 2) + time.substring(0, 1) + f_macAddress.substring(2, 3) + f_endDate.substring(1, 2) + "-" + f_macAddress.substring(3, 5) + f_endDate.substring(2, 3) + f_macAddress.substring(5, 6) + f_endDate.substring(3, 4) + "-" + f_macAddress.substring(6, 8) + f_endDate.substring(4, 5) + f_macAddress.substring(8, 9) + f_endDate.substring(5, 6) + "-" + f_macAddress.substring(9, 11) + fnumStr.substring(1, 2) + f_macAddress.substring(11, 12) + fnumStr.substring(0, 1);

                    comLicenseUse.setComSeq(comContract.getCompany().getSeq());
                    comLicenseUse.setComContractSeq(comContract.getSeq());
                    comLicenseUse.setLicenseCode(LicenseString);
                    comLicenseUse.setLicenseName(licenseName);
                    comLicenseUseRepository.save(comLicenseUse);
                    comLicenseUseRepository.flush();
                    transactionManager.commit(status);

                    return responseService.getSingleResult(LicenseString);
                }else{
                    transactionManager.rollback(status);

                    return responseService.getFailResult(-1,"");
                }
            } catch (Exception e) {
                transactionManager.rollback(status);
                log.error(e.getMessage(), e);
                result.put("result", false);
                return responseService.getFailResult(0,"");
            }
        }else{
            transactionManager.rollback(status);

            return responseService.getFailResult(0,"duple");
        }

    }

    @PutMapping(value="/license/change_status_use")
    public Object changeStatusUse(
            @RequestParam(value="seq") Integer seq
            ,@RequestParam(value="status") Integer licenseStatus
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        ComLicenseUse comLicenseUse = comLicenseUseRepository.findOne(seq);
        comLicenseUse.setStatus(licenseStatus);
        comLicenseUseRepository.save(comLicenseUse);
        comLicenseUseRepository.flush();
        transactionManager.commit(status);
        return responseService.getSuccessResult();
    }

    @PutMapping(value="/license/change_status")
    public Object changeStatus(
            @RequestParam(value="seq") Integer seq
            ,@RequestParam(value="status") Integer licenseStatus
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        ComLicense comLicense = comLicenseRepository.findOne(seq);
        comLicense.setLicenseStatus(licenseStatus);
//        comLicense.(status);
        comLicenseRepository.save(comLicense);
        comLicenseRepository.flush();
        transactionManager.commit(status);
        return responseService.getSuccessResult();
    }

    @GetMapping(value = "/license/re_download")
    public Object reDownload(
        @RequestParam(value="seq") Integer seq
    ){
        ComLicenseUse comLicenseUse = comLicenseUseRepository.findOne(seq);
        ComLicense comLicense = comLicenseMapper.getComLicense(comLicenseUse.getComLicense().getSeq());
        ComContract comContract = comContractRepository.findOne(comLicense.getComContractSeq());
        Company company = companyRepository.findOne(comContract.getCompany().getSeq());

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
                f_macAddress += customEncode.stringChange(arr1.charAt(0)).toString() + customEncode.stringChange(arr2.charAt(0)).toString();
                macAsciiSum += customEncode.getAscii(arr1.charAt(0));
                macAsciiSum += customEncode.getAscii(arr2.charAt(0));
            }


            String endDate = comContract.getContractEnd().toString();
            String[] endDateArray1 = endDate.split(" ");


            String[] endDateArray = endDateArray1[0].split("-");
            String time = endDateArray[0].substring(2, 4) + endDateArray[1] + endDateArray[2];
            System.out.println(time);
            String f_endDate = "";
            Integer endDateAsciiSum = 0;
            for (int i = 0; i < time.length(); i++) {
                f_endDate += customEncode.numberChange(time.substring(i, (i+1)).charAt(0));
                endDateAsciiSum += customEncode.getAscii(time.substring(i, (i+1)).charAt(0));
            }
            Integer acsiiSum = macAsciiSum+endDateAsciiSum;
            String num1 = String.valueOf(acsiiSum);
            num1 = num1.substring(num1.length()-2, num1.length());

            Integer fnum1 = Integer.parseInt(num1);
            Integer fnum2 = Integer.parseInt(endDateArray[2]);

            Integer fnum = fnum1*fnum2;
            String fnumStr = String.valueOf(fnum).substring(String.valueOf(fnum).length()-2, String.valueOf(fnum).length());


            String LicenseString = f_macAddress.substring(0, 2) + time.substring(0, 1) + f_macAddress.substring(2, 3) + f_endDate.substring(1, 2) + "-" + f_macAddress.substring(3, 5) + f_endDate.substring(2, 3) + f_macAddress.substring(5, 6) + f_endDate.substring(3, 4) + "-" + f_macAddress.substring(6, 8) + f_endDate.substring(4, 5) + f_macAddress.substring(8, 9) + f_endDate.substring(5, 6) + "-" + f_macAddress.substring(9, 11) + fnumStr.substring(1, 2) + f_macAddress.substring(11, 12) + fnumStr.substring(0, 1);


            result.put("license",LicenseString);
            result.put("licenseName",comLicenseUse.getLicenseName());
            return responseService.getSingleResult(result);
        }
    }

    @GetMapping(value = "/license/re_download_old")
    public Object reDownloadOld(
            @RequestParam(value="seq") Integer seq
    ){
        ComLicenseUse comLicenseUse = comLicenseUseRepository.findOne(seq);
        ComLicense comLicense = comLicenseMapper.getComLicense(comLicenseUse.getComLicense().getSeq());
        ComContract comContract = comContractRepository.findOne(comLicense.getComContractSeq());
        Company company = companyRepository.findOne(comContract.getCompany().getSeq());

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

            result.put("license",license);
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
                f_macAddress += customEncode.stringChange(arr1.charAt(0)).toString() + customEncode.stringChange(arr2.charAt(0)).toString();
                macAsciiSum += customEncode.getAscii(arr1.charAt(0));
                macAsciiSum += customEncode.getAscii(arr2.charAt(0));
            }

            String endDate = comContract.getContractEnd().toString();

            String[] endDateArray1 = endDate.split(" ");


            String[] endDateArray = endDateArray1[0].split("-");
            String time = endDateArray[0].substring(2, 4) + endDateArray[1] + endDateArray[2];
            System.out.println(time);
            String f_endDate = "";
            Integer endDateAsciiSum = 0;
            for (int i = 0; i < time.length(); i++) {
                f_endDate += customEncode.numberChange(time.substring(i, (i+1)).charAt(0));
                endDateAsciiSum += customEncode.getAscii(time.substring(i, (i+1)).charAt(0));
            }
            Integer acsiiSum = macAsciiSum+endDateAsciiSum;
            String num1 = String.valueOf(acsiiSum);
            num1 = num1.substring(num1.length()-2, num1.length());

            Integer fnum1 = Integer.parseInt(num1);
            Integer fnum2 = Integer.parseInt(endDateArray[2]);

            Integer fnum = fnum1*fnum2;
            String fnumStr = String.valueOf(fnum).substring(String.valueOf(fnum).length()-2, String.valueOf(fnum).length());

            String LicenseString = f_macAddress.substring(0, 2) + time.substring(0, 1) + f_macAddress.substring(2, 3) + f_endDate.substring(1, 2) + "-" + f_macAddress.substring(3, 5) + f_endDate.substring(2, 3) + f_macAddress.substring(5, 6) + f_endDate.substring(3, 4) + "-" + f_macAddress.substring(6, 8) + f_endDate.substring(4, 5) + f_macAddress.substring(8, 9) + f_endDate.substring(5, 6) + "-" + f_macAddress.substring(9, 11) + fnumStr.substring(1, 2) + f_macAddress.substring(11, 12) + fnumStr.substring(0, 1);



            result.put("license",LicenseString);
        }

        return responseService.getSingleResult(result);
    }

    @GetMapping(value="/license/re_emailsend")
    public Object reEmail(
            @RequestParam(value="seq") Integer seq,
            @RequestParam(value="email") String email
    ){
        ComLicenseUse comLicenseUse = comLicenseUseRepository.findOne(seq);
        ComLicense comLicense = comLicenseMapper.getComLicense(comLicenseUse.getComLicense().getSeq());
        ComContract comContract = comContractRepository.findOne(comLicense.getComContractSeq());
        Company company = companyRepository.findOne(comContract.getCompany().getSeq());

        Map<String,Object> result = new HashMap<>();
        String license = "";
//        String licenseType = "";
        if(comLicense.getLicenseType() != 1){ //wc
            String tariff = "";
            if(comLicense.getSubscribeType() == 1){
                tariff = "Hour";
            }else if(comLicense.getSubscribeType() == 2){
                tariff = "Month";
            }else{
                tariff = "Annual";
            }

            JSONObject jsonObject = new JSONObject();
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
                f_macAddress += customEncode.stringChange(arr1.charAt(0)).toString() + customEncode.stringChange(arr2.charAt(0)).toString();
                macAsciiSum += customEncode.getAscii(arr1.charAt(0));
                macAsciiSum += customEncode.getAscii(arr2.charAt(0));
            }

            String endDate = comContract.getContractEnd().toString();
//            SimpleDateFormat sdf = new SimpleDateFormat( "yyyy-MM-dd HH:mm:ss" , Locale.KOREA );
//            String endDate = sdf.format( endDateTime );

            String[] endDateArray1 = endDate.split(" ");


            String[] endDateArray = endDateArray1[0].split("-");
            String time = endDateArray[0].substring(2, 4) + endDateArray[1] + endDateArray[2];

            String f_endDate = "";
            Integer endDateAsciiSum = 0;
            for (int i = 0; i < time.length(); i++) {
                f_endDate += customEncode.numberChange(time.substring(i, (i+1)).charAt(0));
                endDateAsciiSum += customEncode.getAscii(time.substring(i, (i+1)).charAt(0));
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

            try(FileWriter fw = new FileWriter(file, false)){


                // true 지정시 파일의 기존 내용에 이어서 작성

                // 파일안에 문자열 쓰기
                fw.write(license);
                fw.flush();
            }

            //params.put("loginUrl", "www.google.com");
            final String content = FreeMarkerTemplateUtils.processTemplateIntoString(t, params);

            emailService.sendmail("noreply@aworksrpa.com", "[a.works] 라이센스 발급 메일.", content, email, null,"license_"+comLicenseUse.getLicenseName()+".license");
            return responseService.getSuccessResult();
        }catch (Exception e){

            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }
    }

    // 계약 리스트
    @GetMapping(value="/license/new_list")
    public ModelAndView licenseNewList(
            ModelAndView mav
    ){
        mav.setViewName("license/new_list");
        return mav;
    }


}
