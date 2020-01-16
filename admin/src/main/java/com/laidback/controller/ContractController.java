package com.laidback.controller;

import com.amazonaws.services.dynamodbv2.xspec.S;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.text.ExceptionConverter;
import com.laidback.mapper.*;
import com.laidback.model.*;
import com.laidback.repository.*;
import com.laidback.response.ResponseService;
import com.laidback.util.DateUtil;
import org.apache.commons.lang3.StringUtils;
import org.apache.http.protocol.ResponseConnControl;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.*;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.*;

import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.ModelAndView;

import java.io.IOException;
import java.math.BigInteger;
import java.net.URI;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@RestController
public class ContractController extends RootController{

    @Autowired
    CompanyMapper companyMapper;

    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    UserMapper userMapper;

    @Autowired
    ComContractMapper comContractMapper;

    @Autowired
    ComContractRepository comContractRepository;

    @Autowired
    ComLicenseMapper comLicenseMapper;

    @Autowired
    ComContractPaymentRepository comContractPaymentRepository;

    @Autowired
    ComContractPaymentMapper comContractPaymentMapper;

    @Autowired
    ComContractAccruedPaymentMapper comContractAccruedPaymentMapper;

    @Autowired
    ComContractAccruedPaymentRepository comContractAccruedPaymentRepository;

    @Autowired
    UserRepository userRepository;

    @Autowired
    ComLicenseRepository comLicenseRepository;

    @Autowired
    ComContractListRepository comContractListRepository;

    @Value("${workcenter.url}")
    public String WC_URL;

    @Value("${workcenter.clientId}")
    public String WC_CLIENT_ID;

    @Value("${workcenter.clientSecret}")
    public String WC_CLIENT_SECRET;

    @Value("${workcenter.grantType}")
    public String WC_GRANT_TYPE;

    @Value("${workcenter.userName}")
    public String WC_USER_NAME;

    @Value("${workcenter.password}")
    public String WC_PASSWORD;

    @Autowired
    protected ResponseService responseService;

    // 계약회사 등록 처리
    @PostMapping(value = "/contract/companyRegistration")
    public Object companyRegistration(Company company, BindingResult bindingResult) {
        Map<String,Object> result = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"실패");
        }

//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            // 계약 담당자 정보
//            User contractPerson = userMapper.findByContractPerson(company.getUserSeq());

            // 수정
            if(company.getSeq() != null && !"".equals(company.getSeq())) {
                // 계약회사 정보
                Company beforeCom = companyRepository.findOne(company.getSeq());
                beforeCom.setComName(company.getComName());
                beforeCom.setServiceName(company.getServiceName());
                beforeCom.setServicePhone(company.getServicePhone());
                beforeCom.setServiceEmail(company.getServiceEmail());
//                if(contractPerson != null) {
//                    beforeCom.setUserSeq(contractPerson.getSeq());
//                    beforeCom.setContractType(0);
//                } else {
//                    beforeCom.setContractType(1);
//                }
                beforeCom.setStatus(company.getStatus());
                beforeCom.setUpdateDatetime(new java.util.Date());
                beforeCom.setContractReason(company.getContractReason());
                // 업데이트 처리
                companyRepository.save(beforeCom);
            }
            // 등록
            else {
                String[] locationInfo = new String[3];
                try {
                    // wc 에 전송
                    final String CLIENT_ID = WC_CLIENT_ID;
                    final String CLIENT_SECRET = WC_CLIENT_SECRET;
                    final String GRANT_TYPE = WC_GRANT_TYPE;
                    final String SERVER_URL = WC_URL;
                    final String USER_NAME = WC_USER_NAME;
                    final String USER_PASSWORD = WC_PASSWORD;
                    final String API_OAUTH_TOKEN = "/oauth/token";

                    String clientCredentials = CLIENT_ID + ":" + CLIENT_SECRET;
                    Base64.Encoder encoder = Base64.getEncoder();
                    String base64ClientCredentials = new String(encoder.encode(clientCredentials.getBytes()));

                    HttpHeaders headers = new HttpHeaders();
                    headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
                    headers.add("Authorization", "Basic " + base64ClientCredentials);

                    MultiValueMap<String, String> parameters = new LinkedMultiValueMap<>();
                    parameters.add("grant_type", GRANT_TYPE);
                    parameters.add("username", USER_NAME);
                    parameters.add("password", USER_PASSWORD);

                    HttpEntity<MultiValueMap<String, String>> request = new HttpEntity<>(parameters, headers);

                    @SuppressWarnings("rawtypes")
                    ResponseEntity<Map> response;

                    URI uri = URI.create(SERVER_URL + API_OAUTH_TOKEN);
                    RestTemplate restTemplate = new RestTemplate();
                    response = restTemplate.postForEntity(uri, request, Map.class);
                    String accessToken = (String) response.getBody().get("access_token");
                    System.out.println(accessToken);
                    final String REQUEST_URL = WC_URL;
                    final String REUQEST_API_URL = "/organizations";
                    headers = new HttpHeaders();
                    headers.setContentType(MediaType.APPLICATION_JSON);
                    headers.add("Authorization", "Bearer " + accessToken);

//                    User user = userRepository.findOne(company.getUserSeq());
//                    parameters = new LinkedMultiValueMap<>();
//                    parameters.add("name", company.getComName());
//                    parameters.add("managerEmail", user.getLoginId());
//                    parameters.add("managerName", user.getName());
//                    parameters.add("managerTel", user.getPhone());
//
//                    Map<String, Object> params = new HashMap<>();
//                    params.put("name", company.getComName());
//                    params.put("managerEmail", user.getLoginId());
//                    params.put("managerName", user.getName());
//                    params.put("managerTel", user.getPhone());

                    //                request = new HttpEntity<>(parameters,headers);

                    uri = URI.create(REQUEST_URL + REUQEST_API_URL);
                    restTemplate = new RestTemplate();
                    //                HttpEntity<MultiValueMap<Object, String>> requestEntity = new HttpEntity<MultiValueMap<String, String>>(params, headers);
                    //                response = restTemplate.postForEntity(uri, request, Map.class);
                    String body = null;
                    ObjectMapper objectMapper = new ObjectMapper();
//                    try {
//                        body = objectMapper.writeValueAsString(params);
//                    } catch (IOException e) {
//                        throw new RuntimeException(e);
//                    }
                    HttpEntity entity = new HttpEntity(body, headers);
                    ResponseEntity<Map> response2 = restTemplate.postForEntity(uri, entity, Map.class);
                    System.out.println(response2.getHeaders().getLocation().getPath());

                    String locationUrl = response2.getHeaders().getLocation().getPath();
                    locationInfo = locationUrl.split("/");

                    final String DELETE_API_URL = "/oauth/revoke";
                    headers = new HttpHeaders();
                    //                headers.setContentType(MediaType.APPLICATION_JSON);
                    headers.add("Authorization", "Bearer " + accessToken);
                    uri = URI.create(REQUEST_URL + DELETE_API_URL);
                    entity = new HttpEntity(headers);
                    restTemplate = new RestTemplate();
                    ResponseEntity<String> responseEntity = restTemplate.exchange(uri, HttpMethod.DELETE, entity, String.class);
                }catch(Exception e){
                    System.out.println("WC와 통신이 불가능합니다.");
                }

//                if(contractPerson != null) {
//                    company.setUserSeq(contractPerson.getSeq());
//                    company.setContractType(0);
//                } else {
//                    company.setContractType(1);
//                }
                System.out.println(locationInfo[2]);
                company.setStatus(0);
                company.setCreateDatetime(new java.util.Date());
                company.setComUuid(locationInfo[2]);
                Company saveCompany = companyRepository.save(company);

//                ComContract contractDate = new ComContract();
////                contractDate.setComSeq(saveCompany.getSeq());
//                contractDate.setContractStart(Date.valueOf(company.getContractStart()));
//                contractDate.setContractEnd(Date.valueOf(company.getContractEnd()));
//                contractDate.setContractCount(0);
//                contractDate.setStatus(2);
//                contractDate.setCreateDatetime(new java.util.Date());
//                comContractRepository.save(contractDate);

//                contractPerson.setComSeq(saveCompany.getSeq());
//                contractPerson.setLevel(2);
//                userRepository.save(contractPerson);
            }

            companyRepository.flush();
//            comContractRepository.flush();
//            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"실페");
        }

    }

    // 계약 등록, 수정 모달 호출
    @GetMapping(value = "/contract/companyModalView")
    public ModelAndView list(ModelAndView mav,
            @RequestParam(value = "comSeq", defaultValue = "0") Integer comSeq)
    {
        Map<String, Object> params = new HashMap<>();
        System.out.println(comSeq);
        if(comSeq != 0) {
            params.put("comSeq", comSeq);
//            Company company = companyMapper.findByCompany(params);
//            mav.addObject("company", company);

            ComContract comContract = comContractMapper.findByContractCompanyInfo(params);
            mav.addObject("comContract", comContract);
        }

        List<User> userList = userMapper.getUserList();
        mav.addObject("userList", userList);

        mav.setViewName("contract/contractComModal");
        return mav;
    }

    // 계약 수정폼 - 계약 수정, 연장 히스토리 리스트 호출
    @GetMapping(value = "/contract/companyHistory")
    public Object list(@RequestParam(value = "comSeq", defaultValue = "0") Integer comSeq) {
        Map<String, Object> params = new HashMap<>();
        Map<String, Object> result = new HashMap<>();
        if(comSeq != 0) {
            params.put("comSeq", comSeq);
            List<Company> contHistoryList = comContractMapper.searchForContHistory(params);
            result.put("contHistoryList", contHistoryList);
        }
        return result;
    }

    // 계약일 수정, 연장 처리
    @PostMapping(value = "/contract/statusChange")
    public Object statusChange(ComContract comContract, BindingResult bindingResult) {
        Map<String,Object> result = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"실패");
        }

//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            ComContract saveContractInfo = new ComContract();
//            saveContractInfo.setComSeq(comContract.getComSeq());
            saveContractInfo.setContractStart(comContract.getContractStart());
            saveContractInfo.setContractEnd(comContract.getContractEnd());

            // 계약 연장 횟수 조회 및 저장 값 세팅
            Map<String, Object> params = new HashMap<>();
//            params.put("comSeq", comContract.getComSeq());
            ComContract companyInfo = comContractMapper.findByContractCompanyInfo(params);
//            int contCount = companyInfo.getContractCount();
//            if(comContract.getStatus() == 0) saveContractInfo.setContractCount(contCount);
//            else saveContractInfo.setContractCount(contCount + 1);
//            saveContractInfo.setCreateDatetime(new java.util.Date());
//            saveContractInfo.setStatus(comContract.getStatus());

            comContractRepository.save(saveContractInfo);
            comContractRepository.flush();
//            transactionManager.commit(status);

            // 갱신된 계약일 히스토리 리스트 조회
            List<Company> contHistoryList = comContractMapper.searchForContHistory(params);

            return responseService.getListResult(contHistoryList.size(),contHistoryList);
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    // 계약회사 상세 정보 페이지 호출
    @GetMapping(value = "/contract/companyView")
    public ModelAndView view(ModelAndView mav,
            @RequestParam(value = "comSeq", defaultValue = "0") Integer comSeq)
    {
        Map<String, Object> params = new HashMap<>();
        if(comSeq != 0) {
            params.put("comSeq", comSeq);
//            Company company = companyMapper.findByCompany(params);
//            mav.addObject("company", company);

            ComContract comContract = comContractMapper.findByContractCompanyInfo(params);
            mav.addObject("comContract", comContract);
        }

        List<User> userList = userMapper.getUserList();
        mav.addObject("userList", userList);

        mav.setViewName("contract/view");
        return mav;
    }

    // 계약 삭제 처리
    @RequestMapping(value = "/contract/contractDelete", method = RequestMethod.POST)
    public Object companyDelete(
            @RequestParam(value="deleteArray") String deleteArray
    ) {

        Map<String,Object> params = new HashMap<>();
        Map<String,Object> result = new HashMap<>();


        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        try{
            Integer deleteY = 0;
            Integer deleteN = 0;
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String contractSeq : deleteArrayList) {
//                ComLicense comLicense = comLicenseRepository.findOne(Integer.parseInt(contractSeq));
                int count = comContractMapper.getAllUse(Integer.parseInt(contractSeq));
                if(count == 0){
                    ++deleteY;
                    ComContract comContract = comContractRepository.findOne(Integer.parseInt(contractSeq));
                    comContract.setDeleteDatetime(new java.util.Date());
                    comContractRepository.save(comContract);
                    Integer userSeq = comContract.getUser().getSeq();
                    comContractRepository.flush();
                    Integer contractCount = comContractMapper.userCount(userSeq);
                    if(contractCount == 0){
                        User user = userRepository.findOne(userSeq);
                        user.setLevel(1);
                        userRepository.save(user);
                        userRepository.flush();
                    }
                }else{
                    ++deleteN;
//                params.put("comSeq", Integer.parseInt(contractSeq))
                }

//                company = companyMapper.findByCompany(params);
//                company.setSeq(Integer.parseInt(comSeq));
//                company.setDeleteDatetime(new java.util.Date());
//                companyRepository.save(company);
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

    // 계약회사 ajax 자동완성
    @GetMapping(value = "/contract/get_contract")
    public Object getObjectName(@RequestParam(value = "phrase", required = false) String companyName){
        Map<String, Object> params = new HashMap<>();
        params.put("companyName", companyName);
//        List<Company> companyList = companyMapper.companyNameSearch(params);
//        return companyList;
        return true;
    }


    // 계약회사 라이센스 목록
    @RequestMapping(value = "/contract/comLicenseList", method = RequestMethod.POST)
    public Object comLicenseList(
            Company comp,
            @RequestParam(value="contractSeq") Integer contractSeq,
            @RequestParam(value="clContractType") Integer clContractType,
            @RequestParam(value = "clLicenseType") Integer clLicenseType,
            @RequestParam(value="clSubscribeType") Integer clSubscribeType,
            @RequestParam(value = "clLicenseStatus") Integer clLicenseStatus,
            BindingResult bindingResult
    ) {

        Map<String, Object> params = new HashMap<>();
        params.put("sort", comp.getClSort());
        params.put("offset", (comp.getClPage() - 1) * comp.getClRow());
        params.put("count", comp.getClRow());

        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            result.put("result",false);
            return result;
        }

        // Order value Change
        setOrderValueChangeModal(result, params, comp.getClOrder());

        if(clContractType != null){
            params.put("contractType",clContractType);
        }

        if(clLicenseType != null){
            params.put("licenseType",clLicenseType);
        }

        if(clSubscribeType != null){
            params.put("subscribeType",clSubscribeType);
        }

        if(clLicenseStatus != null){
            params.put("licenseStatus",clLicenseStatus);
        }

        params.put("contractSeq", contractSeq);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar c1 = Calendar.getInstance();

        String strToday = sdf.format(c1.getTime());
        params.put("today",strToday);

        int totalCount = comLicenseMapper.count(params);
        result.put("no", (int) Math.ceil((double) totalCount / comp.getClRow()));
        result.put("row", comp.getClRow());

        List<ComLicense> results = comLicenseMapper.find(params);
        result.put("resultsList", results);
        result.put("total", totalCount);
        result.put("sort", comp.getClSort());
        result.put("clSeq", comp.getSeq());

        return result;
    }

    // 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/contract/execlDownList")
    public Object getExeclDownList(
            @RequestParam(value="checkSeq") String checkSeq
            ,@RequestParam(value = "sort", defaultValue = "com.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "1") Integer order
    ) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = checkSeq;
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> contractList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            contractList.add(Integer.parseInt(seq));
        }
        params.put("contractList", contractList);
        params.put("sort",sort);
        params.put("order",order);

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        Calendar c1 = Calendar.getInstance();

        String strToday = sdf.format(c1.getTime());
        params.put("today",strToday);

        List<ComLicense> execlDownList = comContractMapper.getExeclDownList(params);
//        for(ComLicense license: execlDownList){
//            ComContract comContract = comContractRepository.findOne(license.getComContractSeq());
//            license.setComContract(comContract);
//        }

        return responseService.getListResult(execlDownList.size(),execlDownList);

    }

    @GetMapping(value = "/contract/ajax_list")
    public Object contractAjaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "com.create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "1") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "contractStatus", required = false) Integer contractStatus
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
            ,@RequestParam(value = "comSeq",required = false) Integer comSeq
    ) {
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("order",order);
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

        if(comSeq != null){
            params.put("comSeq",comSeq);
        }

        int totalCount = comContractMapper.count(params);


        List<ComContract> results = comContractMapper.find(params);



        return responseService.getListResult(totalCount,results);
    }
    // 계약 리스트
    @GetMapping(value="/contract/new_list")
    public ModelAndView contractNewList(
            @RequestParam(value="comSeq", required = false) Integer comSeq
            ,ModelAndView mav
    ){
        if(comSeq != null) {
            Company company = companyRepository.findOne(comSeq);
            mav.addObject("company", company);
        }
        mav.setViewName("contract/new_list");
        return mav;
    }

    // 계약 신규 등록
    @GetMapping(value="/contract/new_write")
    public ModelAndView contractNewWrite(
            @RequestParam(value="comSeq", required = false) Integer comSeq
            ,ModelAndView mav
    ){

            List<Company> companies = companyMapper.findAll();
            mav.addObject("companies", companies);

        System.out.println(new java.util.Date().toString());
        SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyyMMdd", Locale.KOREA );
        java.util.Date currentTime = new java.util.Date();
        String mTime = mSimpleDateFormat.format ( currentTime );

        Integer numberCount = comContractMapper.getLast(mTime);
        String contractNumber = "";
        if(numberCount == 0){
            contractNumber = mTime+"-"+"0001";
        }else{
            if(numberCount >= 999){
                String lastNumber = String.valueOf(numberCount+1);
                contractNumber = mTime+"-"+ lastNumber;
            }else if(numberCount >= 99){
                String lastNumber = String.valueOf(numberCount+1);
                contractNumber = mTime+"-0"+ lastNumber;
            }else if(numberCount >= 9){
                String lastNumber = String.valueOf(numberCount+1);
                contractNumber = mTime+"-00"+ lastNumber;
            }else{
                String lastNumber = String.valueOf(numberCount+1);
                contractNumber = mTime+"-000"+ lastNumber;
            }

        }
        mav.addObject("selectComSeq",comSeq);
        mav.addObject("contractNumber",contractNumber);
        mav.setViewName("contract/new_write");
        return mav;
    }

    @GetMapping(value="/contract/new_update")
    public ModelAndView contractNewUpdate(
            @RequestParam(value="comContractSeq", required = false) Integer comContractSeq
            ,ModelAndView mav
    ){
        List<Company> companies = companyMapper.findAll();
        mav.addObject("companies", companies);
        Map<String, Object> params = new HashMap<>();
        params.put("contractSeq", comContractSeq);

        ComContract comContract = comContractMapper.findOne(params);
        mav.addObject("comContract", comContract);

        List<ComLicense> comLicenses = comLicenseRepository.findByContract(comContract);
        mav.addObject("count",comLicenses.size());
        mav.addObject("comLicenses", comLicenses);
        mav.setViewName("contract/new_update");
        return mav;
    }

    @PostMapping(value="/contract/make")
    public Object contractMake(
            @RequestParam(value = "contractNumber") String contractNumber
            ,@RequestParam(value = "contractName") String contractName
            ,@RequestParam(value= "contractStart") String contractStart
            ,@RequestParam(value="contractEnd") String contractEnd
            ,@RequestParam(value="contractChargerName") String contractChargerName
            ,@RequestParam(value="contractChargerEmail") String contractChargerEmail
            ,@RequestParam(value="contractChargerPhone") String contractChargerPhone
            ,@RequestParam(value="contractIctName") String contractIctName
            ,@RequestParam(value="contractType") Integer[] contractType
            ,@RequestParam(value="licenseType", required = false) Integer[] licenseTypes
            ,@RequestParam(value="subscribeType", required = false) Integer[] subscribeTypes
            ,@RequestParam(value="userSeq") Integer userSeq
            ,@RequestParam(value="comSeq") Integer comSeq
            ,@RequestParam(value="unattendedLicensePrice", required = false) Long[] unattendedLicensePrice
            ,@RequestParam(value="unattendedLicenseListPrice", required = false) Long[] unattendedLicenseListPrice
            ,@RequestParam(value="attendedLicensePrice", required = false) Long[] attendedLicensePrice
            ,@RequestParam(value="attendedLicenseListPrice", required = false) Long[] attendedLicenseListPrice
            ,@RequestParam(value="studioLicensePrice", required = false) Long[] studioLicensePrice
            ,@RequestParam(value="studioLicenseListPrice", required = false) Long[] studioLicenseListPrice
            ,@RequestParam(value="workcenterLicensePrice", required = false) Long[] workcenterLicensePrice
            ,@RequestParam(value="workcenterLicenseListPrice", required = false) Long[] workcenterLicenseListPrice
            ,@RequestParam(value="unAttendedCount", required = false) Integer[] unAttendedCount
            ,@RequestParam(value="attendedCount", required = false) Integer[] attendedCount
            ,@RequestParam(value="studioCount", required = false) Integer[] studioCount
            ,@RequestParam(value="workcenterCount", required = false) Integer[] workcenterCount

    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        Integer dupleNumber = comContractMapper.findByContractNumber(contractNumber);
        if(dupleNumber == 0) {
            try {
                ComContract comContract = new ComContract();

                comContract.setContractNumber(removeTag(contractNumber));
                comContract.setContractName(removeTag(contractName));
                comContract.setContractChargerEmail(contractChargerEmail);
                comContract.setContractChargerName(removeTag(contractChargerName));
                comContract.setContractChargerPhone(contractChargerPhone);
                comContract.setContractIctName(removeTag(contractIctName));
                comContract.setContractStatus(1);
                comContract.setCreateDatetime(new java.util.Date());
                User user = userRepository.findOne(userSeq);
                user.setLevel(2);
                userRepository.save(user);
                userRepository.flush();
                comContract.setUser(user);
                Company company = companyRepository.findOne(comSeq);
                comContract.setCompany(company);
                try {
                    SimpleDateFormat sdt = new SimpleDateFormat("yyyyy-MM-dd");
//                    sdt.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
                    java.util.Date startDate = sdt.parse(contractStart);

                    java.util.Date endDate = sdt.parse(contractEnd);
                    comContract.setContractStart(startDate);
                    comContract.setContractEnd(endDate);
                } catch (Exception e) {

                }

                comContractRepository.save(comContract);
                comContractRepository.flush();
                if (licenseTypes != null) {
                    if (licenseTypes.length > 0) {
                        for (int i = 0; i < licenseTypes.length; i++) {
                            ComLicense comLicense = new ComLicense();
                            comLicense.setComContract(comContract);
                            comLicense.setContractType(contractType[i]);
                            comLicense.setUnattendedLicenseListPrice(unattendedLicenseListPrice[i]);
                            comLicense.setUnattendedLicensePrice(unattendedLicensePrice[i]);
                            comLicense.setAttendedLicenseListPrice(attendedLicenseListPrice[i]);
                            comLicense.setAttendedLicensePrice(attendedLicensePrice[i]);
                            comLicense.setStudioLicenseListPrice(studioLicenseListPrice[i]);
                            comLicense.setStudioLicensePrice(studioLicensePrice[i]);
                            comLicense.setWorkcenterLicenseListPrice(workcenterLicenseListPrice[i]);
                            comLicense.setWorkcenterLicensePrice(workcenterLicensePrice[i]);
                            comLicense.setLicenseType(licenseTypes[i]);
                            comLicense.setSubscribeType(subscribeTypes[i]);
                            comLicense.setCountUnattended(unAttendedCount[i]);
                            comLicense.setCountAttended(attendedCount[i]);
                            comLicense.setCountStudio(studioCount[i]);
                            comLicense.setCountWorkcenter(workcenterCount[i]);
                            comLicense.setLicenseStatus(0);
                            comLicenseRepository.save(comLicense);
                            comContractListRepository.flush();
                        }

                    }
                }

                transactionManager.commit(status);
                return responseService.getSuccessResult();
            }catch(Exception e){
                transactionManager.rollback(status);
                return responseService.getFailResult(-2,"");
            }
        }else{
            transactionManager.rollback(status);
            return responseService.getFailResult(-1,"");
        }
    }

    @PutMapping(value = "/contract/contract_update")
    public Object updateContract(
            @RequestParam(value="seq") Integer seq
            ,@RequestParam(value = "contractNumber") String contractNumber
            ,@RequestParam(value = "contractName") String contractName
            ,@RequestParam(value= "contractStart") String contractStart
            ,@RequestParam(value="contractEnd") String contractEnd
            ,@RequestParam(value="contractChargerName") String contractChargerName
            ,@RequestParam(value="contractChargerEmail") String contractChargerEmail
            ,@RequestParam(value="contractChargerPhone") String contractChargerPhone
            ,@RequestParam(value="userSeq") Integer userSeq
            ,@RequestParam(value="comSeq") Integer comSeq
            ,@RequestParam(value="contractIctName") String contractIctName

    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
//        Integer dupleNumber = comContractMapper.findByContractNumber(contractNumber);
//        if(dupleNumber == 0) {
        try {
            ComContract comContract = comContractRepository.findOne(seq);
            Integer oldUser = comContract.getUser().getSeq();

            comContract.setContractNumber(removeTag(contractNumber));
            comContract.setContractName(removeTag(contractName));
            comContract.setContractChargerEmail(contractChargerEmail);
            comContract.setContractChargerName(removeTag(contractChargerName));
            comContract.setContractChargerPhone(contractChargerPhone);
            comContract.setContractIctName(removeTag(contractIctName));
            //        comContract.setContractIctName(contractIctName);
            comContract.setCreateDatetime(new java.util.Date());
            User user = userRepository.findOne(userSeq);
            user.setLevel(2);
            userRepository.save(user);
            userRepository.flush();
            comContract.setUser(user);
            Company company = companyRepository.findOne(comSeq);
            comContract.setCompany(company);
            try {
                SimpleDateFormat sdt = new SimpleDateFormat("yyyyy-MM-dd");
//                sdt.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
                java.util.Date startDate = sdt.parse(contractStart);

                java.util.Date endDate = sdt.parse(contractEnd);
                comContract.setContractStart(startDate);
                comContract.setContractEnd(endDate);
            } catch (Exception e) {

            }

            comContractRepository.save(comContract);
            comContractRepository.flush();

            Integer contractCount = comContractMapper.userCount(oldUser);
            if(contractCount == 0){
                User old = userRepository.findOne(oldUser);
                old.setLevel(1);
                userRepository.save(old);
                userRepository.flush();
            }
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch(Exception e){
            transactionManager.rollback(status);
            return responseService.getFailResult(0,"");
        }

    }
    @PutMapping(value="/contract/update_save")
    public Object contractMake2(
            @RequestParam(value="contractType", required = false) Integer[] contractType
            ,@RequestParam(value="licenseType", required = false) Integer[] licenseTypes
            ,@RequestParam(value="subscribeType", required = false) Integer[] subscribeTypes
            ,@RequestParam(value="seq", required = false) String[] seq
            ,@RequestParam(value="unattendedLicensePrice", required = false) Long[] unattendedLicensePrice
            ,@RequestParam(value="unattendedLicenseListPrice", required = false) Long[] unattendedLicenseListPrice
            ,@RequestParam(value="attendedLicensePrice", required = false) Long[] attendedLicensePrice
            ,@RequestParam(value="attendedLicenseListPrice", required = false) Long[] attendedLicenseListPrice
            ,@RequestParam(value="studioLicensePrice", required = false) Long[] studioLicensePrice
            ,@RequestParam(value="studioLicenseListPrice", required = false) Long[] studioLicenseListPrice
            ,@RequestParam(value="workcenterLicensePrice", required = false) Long[] workcenterLicensePrice
            ,@RequestParam(value="workcenterLicenseListPrice", required = false) Long[] workcenterLicenseListPrice
            ,@RequestParam(value="unAttendedCount", required = false) Integer[] unAttendedCount
            ,@RequestParam(value="attendedCount", required = false) Integer[] attendedCount
            ,@RequestParam(value="studioCount", required = false) Integer[] studioCount
            ,@RequestParam(value="workcenterCount", required = false) Integer[] workcenterCount
            ,@RequestParam(value="comContractSeq", required = false) Integer comContractSeq
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
//        comContract.setUpdateDatetime(new java.util.Date());
        if(licenseTypes != null){
            if(licenseTypes.length > 0){
                for (int i = 0; i < licenseTypes.length; i++) {
                    ComLicense comLicense = new ComLicense();
                    if(seq[i].equals("")){

                    }else{
                        comLicense = comLicenseRepository.findOne(Integer.parseInt(seq[i]));

                    }
                    ComContract comContract = comContractRepository.findOne(comContractSeq);
                    comLicense.setComContract(comContract);
                    comLicense.setContractType(contractType[i]);
                    comLicense.setUnattendedLicenseListPrice(unattendedLicenseListPrice[i]);
                    comLicense.setUnattendedLicensePrice(unattendedLicensePrice[i]);
                    comLicense.setAttendedLicenseListPrice(attendedLicenseListPrice[i]);
                    comLicense.setAttendedLicensePrice(attendedLicensePrice[i]);
                    comLicense.setStudioLicenseListPrice(studioLicenseListPrice[i]);
                    comLicense.setStudioLicensePrice(studioLicensePrice[i]);
                    comLicense.setWorkcenterLicenseListPrice(workcenterLicenseListPrice[i]);
                    comLicense.setWorkcenterLicensePrice(workcenterLicensePrice[i]);
                    comLicense.setLicenseType(licenseTypes[i]);
                    comLicense.setSubscribeType(subscribeTypes[i]);
                    comLicense.setCountUnattended(unAttendedCount[i]);
                    comLicense.setCountAttended(attendedCount[i]);
                    comLicense.setCountStudio(studioCount[i]);
                    comLicense.setCountWorkcenter(workcenterCount[i]);
                    comLicense.setLicenseStatus(0);
                    comLicenseRepository.save(comLicense);
                    comContractListRepository.flush();
                }

            }
        }
        transactionManager.commit(status);
        return responseService.getSuccessResult();
    }

    @GetMapping(value = "/contract/contractView")
    public ModelAndView contractView(ModelAndView mav, @RequestParam(value = "contractSeq", defaultValue = "0") Integer contractSeq)
    {

        if(contractSeq != 0) {

            Map<String, Object> params = new HashMap<>();
            params.put("contractSeq", contractSeq);
            ComContract comContract = comContractMapper.findOne(params);
            mav.addObject("comContract", comContract);

            List<ComLicense> comLicense = comLicenseMapper.find(params);
            mav.addObject("comLicense",comLicense);
        }

        mav.setViewName("contract/new_view");
        return mav;
    }

    public String removeTag(String html) throws Exception {
        return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
    }
}
