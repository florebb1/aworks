package com.laidback.controller;
import com.laidback.mapper.*;
import com.laidback.model.*;
import com.laidback.repository.*;
import com.laidback.response.ResponseService;
import com.laidback.service.AmazonClient;
import com.laidback.service.CustomEncode;
import com.laidback.service.EmailService;
import com.laidback.util.CookieUtil;
import com.laidback.util.JwtUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.RedirectView;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

import static org.aspectj.runtime.internal.Conversions.intValue;

@RestController
public class ApiController extends RootController{

    @Autowired
    AmazonClient amazonClient;

    @Autowired
    UserMapper userMapper;

    @Autowired
    RepositoryRatingMapper repositoryRatingMapper;

    @Autowired
    RepositoryLikeMapper repositoryLikeMapper;

    @Autowired
    RepositoryDownloadMapper repositoryDownloadMapper;

    @Autowired
    UserRepository userRepository;

    @Autowired
    RepositoryRepository repositoryRepository;

    @Autowired
    RepositoryRatingRepository repositoryRatingRepository;

    @Autowired
    RepositoryLikeRepository repositoryLikeRepository;

    @Autowired
    RepositoryReviewRepository repositoryReviewRepository;

    @Autowired
    RepositoryDownloadRepository repositoryDownloadRepository;

    @Autowired
    BbsOnetooneRepository bbsOnetooneRepository;

    @Autowired
    RepositoryQnaRepository repositoryQnaRepository;

    @Autowired
    RepositoryQnaAnswerRepository repositoryQnaAnswerRepository;

    @Autowired
    protected EmailService emailService;

    @Autowired
    protected Configuration configuration;

    @Autowired
    TrialUserRepository trialUserRepository;

    @Autowired
    TrialUserMapper trialUserMapper;

    @Autowired
    TrialLicenseMapper trialLicenseMapper;

    @Autowired
    TrialLicenseRepository trialLicenseRepository;

    @Autowired
    CompanyRepository companyRepository;

    @Autowired
    ComContractRepository comContractRepository;

    @Autowired
    ComAbbyyMapper comAbbyyMapper;

    @Autowired
    ComLicenseMapper comLicenseMapper;

    @Autowired
    ComContractMapper comContractMapper;

    @Value("${gethost.host}")
    public String HOSTNAME;

    @Autowired
    BbsFileRepository bbsFileRepository;

    @Autowired
    ContactusRepository contactusRepository;

    @Autowired
    TrialMacMapper trialMacMapper;

    @Autowired
    private CustomEncode customEncode;

    @Autowired
    protected ResponseService responseService;

    @Autowired
    private DivOneMapper divOneMapper;

    // 회원가입
    @PostMapping(value = "/api/signup")
    public Object signup(
            @RequestParam(value = "loginId") String loginId
            ,@RequestParam(value = "loginPw") String loginPw
            ,@RequestParam(value="name") String name
            ,@RequestParam(value="phone") String phone
    ){
        BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
        Map<String, Object> params = new HashMap<>();
        params.put("id", loginId);

//        try {
        User user = new User();
        user.setLoginId(loginId);
        user.setLoginPw(pe.encode(loginPw));
        user.setName(removeTag2(name));
        user.setPhone(phone.replaceAll("-",""));
        user.setLevel(1);
        user.setCreateDatetime(new java.util.Date());
        userRepository.save(user);
        userRepository.flush();
//            transactionManager.commit(status);
        int userChk = userMapper.loginIdChk(params);
        if(userChk > 0) {
            return responseService.getSuccessResult();
        }else {
            return responseService.getFailResult(0,"실패");
        }
    }
    // 회원가입 아이디 중복확인
    @PostMapping(value = "/api/idChk")
    public Object idChk(
            @RequestParam(value = "loginId") String loginId
    ){
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("id", loginId);
        int idCount = userMapper.loginIdChk(params);
        if(idCount > 0) {

            return responseService.getFailResult(0,"실패");
        }else {
            return responseService.getSuccessResult();
        }
    }

    // 임시비밀번호 발송
    @PostMapping(value = "/api/searchPw")
    public Object searchPw(
            @RequestParam(value = "findPwEmail") String loginId){

//        Map<String, Object> result = new HashMap<>();

        try {
            Long userSeq = userRepository.findByLoginId(loginId);
            if (userSeq == null) {
                return responseService.getFailResult(1,"회원값없음");
            } else {
                User user = userRepository.findOne(intValue(userSeq));

                BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
                String characters1 = "ABCDEFGHIJKLMNOPQRSTUVSXYZabcdefghijklmnopqrstuvwxyz";
                final String newPassword1 = RandomStringUtils.random(4, 0, characters1.length(), false, false, characters1.toCharArray());
                String characters2 = "0123456789";
                final String newPassword2 = RandomStringUtils.random(4, 0, characters2.length(), false, false, characters2.toCharArray());
                String characters3 = "!@$%^&*";
                final String newPassword3 = RandomStringUtils.random(1, 0, characters3.length(), false, false, characters3.toCharArray());
                final String newPassword = newPassword1 + newPassword2 + newPassword3;
                user.setLoginPw(pe.encode(newPassword));
                userRepository.save(user);
                userRepository.flush();
//                transactionManager.commit(status);
                // 이메일 발송 로직 추가
                final Template t = configuration.getTemplate("mail/password.ftl");
                Map<String, Object> params = new HashMap<>();
                params.put("loginId", loginId);
                params.put("newPassword", newPassword);
                String content = FreeMarkerTemplateUtils.processTemplateIntoString(t, params);
                emailService.sendmail("noreply@aworksrpa.com", "[a.works] 임시비밀번호 발송 메일입니다.", content, loginId, null,null);
                return responseService.getSuccessResult();
            }
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"exception 오류");
        }
//        return result;
    }

    // 평가하기
    @PostMapping(value = "/api/rating")
    public Object rating(
            @RequestParam(value = "userSeq") Long userSeq
            ,@RequestParam(value = "repositorySeq") Long repositorySeq
            ,@RequestParam(value = "rating") Double rating
    ){

        Map<String, Object> params = new HashMap<>();
        params.put("userSeq", userSeq);
        params.put("repositorySeq", repositorySeq);

        RepositoryRating duple = repositoryRatingMapper.getDuple(params);
        if(duple.getSeq() == null) {

            User user = userRepository.findOne(intValue(userSeq));
            Repository repository = repositoryRepository.findOne(intValue(repositorySeq));
            RepositoryRating repositoryRating = new RepositoryRating();
            repositoryRating.setRating(rating);
            repositoryRating.setUser(user);
            repositoryRating.setRepository(repository);

            repositoryRatingRepository.save(repositoryRating);

            repositoryRatingRepository.flush();

            return responseService.getSuccessResult();
        }else{
            return responseService.getFailResult(0,"exception 오류");
        }

    }

    // 추천하기
    @PostMapping(value = "/api/recomm")
    public Object recomm(
            @RequestParam(value = "userSeq") Long userSeq
            ,@RequestParam(value = "repositorySeq") Long repositorySeq
    ){

        Map<String, Object> params = new HashMap<>();
        params.put("userSeq", userSeq);
        params.put("repositorySeq", repositorySeq);

        RepositoryLike duple = repositoryLikeMapper.getDuple(params);
        if(duple.getSeq() == null) {

            User user = userRepository.findOne(intValue(userSeq));
            Repository repository = repositoryRepository.findOne(intValue(repositorySeq));
            RepositoryLike repositoryLike = new RepositoryLike();
            repositoryLike.setUser(user);
            repositoryLike.setRepository(repository);

            repositoryLikeRepository.save(repositoryLike);

            repositoryLikeRepository.flush();

            return responseService.getSuccessResult();
        }else{
            return responseService.getFailResult(0,"오류");
        }
    }

    // 다운로드
    @PostMapping(value = "/api/download")
    public Object download(
            @RequestParam(value = "userSeq") Long userSeq
            ,@RequestParam(value = "repositorySeq") Long repositorySeq
    ){
        Map<String, Object> params = new HashMap<>();
        params.put("userSeq", userSeq);
        params.put("repositorySeq", repositorySeq);

        RepositoryDownload duple = repositoryDownloadMapper.getDuple(params);
        if(duple.getSeq() == null) {

            User user = userRepository.findOne(intValue(userSeq));
            Repository repository = repositoryRepository.findOne(intValue(repositorySeq));
            RepositoryDownload repositoryDownload = new RepositoryDownload();
            repositoryDownload.setUser(user);
            repositoryDownload.setRepository(repository);

            repositoryDownloadRepository.save(repositoryDownload);

            repositoryDownloadRepository.flush();
            return responseService.getSuccessResult();
        }else{
            return responseService.getFailResult(0,"exception 오류");
        }

    }

    // 트라이얼 다운로드
    @GetMapping(value = "/api/trialSubmission")
    public Object trialSubmission(
            @RequestParam(value = "trialEmail") String email
            ,@RequestParam(value = "trialPhone") String phone
            ,@RequestParam(value = "trialCompany") String company
            ,@RequestParam(value = "trialPosition") String position
            ,@RequestParam(value="trialName") String name

    ) throws ParseException {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        Calendar cl = new GregorianCalendar(Locale.KOREA);
        Date date = new Date();
        cl.setTime(date);
        String now = sdf.format(cl.getTime());
        Date now2 = sdf.parse(now);
        cl.add(cl.DATE, 60);
        String dt = sdf.format(cl.getTime());
        Date dt2 = sdf.parse(dt);

        try{

            int trialUserCount = trialUserMapper.count(email.toLowerCase());
            //신청내역이 존재한다면 라이센스 유효성 검사
            if(trialUserCount > 0) {
                // 신청내역이 있으면 신규 신청 안됨
                return responseService.getFailResult(0,"이미 신청한 이메일 입니다. ");
            }else {
                // TrialUser 저장
                // 미리 정의된 30개의 가짜 맥주소중 한개를 get
                TrialMac trialMac = trialMacMapper.findRand();
                TrialUser trialU = new TrialUser();
                trialU.setEmail(email.toLowerCase());
                trialU.setPhone(phone);
                trialU.setCompany(company);
                trialU.setPosition(position);
                trialU.setName(name);

                trialUserRepository.save(trialU);
                // TrialLicense 저장
                TrialLicense trialL = new TrialLicense();
                TrialUser tu = new TrialUser();
                tu.setSeq(trialU.getSeq());
                trialL.setEndDate(dt2);
                trialL.setStartDate(now2);
                trialL.setExtension(0);
                trialL.setStatus(1);
                trialL.setTrialSeq(tu);
                String macAddress = trialMac.getMacAddress();
                String mac[] = {};
                if (macAddress.toLowerCase().contains(":")) {
                    mac = macAddress.toLowerCase().split(":");
                } else if (macAddress.toLowerCase().contains("-")) {
                    mac = macAddress.toLowerCase().split("-");
                }

                String f_macAddress = "";
                Integer macAsciiSum = 0;
                for (int i = 0; i < mac.length; i++) {
                    String arr1 = mac[i].substring(0, 1);
                    String arr2 = mac[i].substring(1, 2);
                    f_macAddress += customEncode.stringChange(arr1.charAt(0)).toString() + customEncode.stringChange(arr2.charAt(0)).toString();
                    macAsciiSum += customEncode.getAscii(arr1.charAt(0));
                    macAsciiSum += customEncode.getAscii(arr2.charAt(0));
                }

                String endDate = dt;
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

                trialL.setLicenseKey(LicenseString);
                trialLicenseRepository.save(trialL);
                trialUserRepository.flush();
                trialLicenseRepository.flush();
                // 다운로드 로직 추가



                try{

                    final Template t = configuration.getTemplate("mail/license_pc.ftl");
                    final Map<String, Object> params = new HashMap<>();
                    params.put("license", LicenseString);
                    File file = new File("./uploads/license_"+email+".license") ;
                    // 파일 객체 생성

                    try(FileWriter fw = new FileWriter(file, false)){
//                        fw = new FileWriter(file, false) ;
                        // 파일안에 문자열 쓰기
                        fw.write(LicenseString);
                        fw.flush();

                    }catch(Exception e){
                        e.printStackTrace();
                        System.out.println(e);
                    }
                    final String content = FreeMarkerTemplateUtils.processTemplateIntoString(t, params);

                    emailService.sendmail("noreply@aworksrpa.com", "[a.works] 라이센스 발급 메일.", content, email, null,"license_"+email+".license");
                    return responseService.getSuccessResult();

                }catch (Exception e){

                    log.error(e.getMessage(),e);
                    return responseService.getFailResult(0,"Exception 오류");
                }
            }
        }catch (Exception e){
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"Exception 오류");
        }
    }

    // QNA 작성
    @PostMapping(value = "/api/qna")
    public Object qna(
            @RequestParam(value = "userId") Integer userSeq
            ,@RequestParam(value = "qnaType") Integer qnaType
            , @RequestParam(value = "title") String title
            , @RequestParam(value = "content") String content
            ,@RequestParam(value = "directFile" , required = false) MultipartFile[] directFile
    ) {
        Map<String, Object> result = new HashMap<>();
        BbsOnetoone onetoone = new BbsOnetoone();
        User u = new User();
        u.setSeq(userSeq);
        try {
            onetoone.setQnaType(qnaType);
            onetoone.setUser(u);
            onetoone.setAnswerYn(0);
            onetoone.setTitle(title);
            onetoone.setContent(content);
            onetoone.setCreateDatetime(new java.util.Date());
            bbsOnetooneRepository.save(onetoone);
            if(directFile != null) {
                if (directFile.length > 0) {
                    for (MultipartFile file : directFile) {
                        if (!file.isEmpty()) {
                            String fileName = file.getOriginalFilename();
                            int startIndex = fileName.replaceAll("\\\\", "/").lastIndexOf("/");
                            fileName = fileName.substring(startIndex + 1);
                            System.out.println(fileName);
                            BbsFile bbsFile = new BbsFile();
                            String fileUrl = amazonClient.uploadFile(file);
                            bbsFile.setBbsSeq(onetoone.getSeq());
                            bbsFile.setFileName(fileUrl);
                            bbsFile.setCreateDatetime(new java.util.Date());
                            bbsFile.setFileType(0);
                            bbsFile.setOriginalFileName(fileName);
                            bbsFile.setBbsCode("onetoone");
                            bbsFileRepository.save(bbsFile);
                            bbsFileRepository.flush();
                        }
                    }
                }
            }
            bbsOnetooneRepository.flush();
            Map<String, Object> params = new HashMap<>();
            List<DivOne> divOnes = null;
            if(qnaType == 1){
//                params.put("divName","교육문의");
                params.put("divSeq","2121");
//                System.out.println(params.toString());
                divOnes = divOneMapper.sendFind(params);
            }else if(qnaType == 2){
//                params.put("divName","기능문의");
                params.put("divSeq","2122");

                divOnes = divOneMapper.sendFind(params);
            }else if(qnaType == 3){
//                params.put("divName","제안 및 사업문의");
                params.put("divSeq","1973");

                divOnes = divOneMapper.sendFind(params);
            }else if(qnaType == 4){
//                params.put("divName","기타문의");
                params.put("divSeq","1975");
//
                divOnes = divOneMapper.sendFind(params);
            }

            for(DivOne divOne: divOnes){
                emailService.sendmail("noreply@aworksrpa.com", "[a.works] 1:1문의 입니다.", nl2br(content), divOne.getChargerEmail(), null,null);
            }
            return responseService.getSuccessResult();
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            return responseService.getFailResult(0,"Exception 오류");
        }

    }

    // QNA답변 작성
    @PostMapping(value = "/api/qna_answer")
    public Object qnaAnswer(
            RepositoryQnaAnswer repositoryQnaAnswer, BindingResult bindingResult
    ){

//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            RepositoryQna repositoryQna = repositoryQnaRepository.findOne(repositoryQnaAnswer.getRepositoryQnaSeq());

            repositoryQnaAnswer.setRepositoryQna(repositoryQna);
            repositoryQnaAnswerRepository.save(repositoryQnaAnswer);

            repositoryQnaAnswerRepository.flush();
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"Exception 오류");
        }

    }

    // 프로필 업데이트
    @PutMapping(value = "/api/photo_update")
    public Object photo(
            @RequestParam(value = "file") MultipartFile file
            ,@RequestParam(value = "userSeq") Integer userSeq
    ){
//        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//        TransactionStatus status = transactionManager.getTransaction(def);

        if(file != null){
            try {
                String profileFile = fileStorageService.storeFile(file);
                User user = userRepository.findOne(userSeq);
                user.setProfileImg(profileFile);
                userRepository.save(user);
                userRepository.flush();
//                transactionManager.commit(status);
                return responseService.getSuccessResult();
            }catch (Exception e){
//                transactionManager.rollback(status);
                log.error(e.getMessage(),e);
                return responseService.getFailResult(0,"Exception 오류");
            }

        }else{
            return responseService.getFailResult(0,"Exception 오류");
        }
    }

    // 1:1문의 등록
    @PostMapping(value = "/api/onetoone")
    public Object onetoone(BbsOnetoone bbsOnetoone, BindingResult bindingResult){

        try{

            User user = userRepository.findOne(bbsOnetoone.getUserSeq());
            bbsOnetoone.setUser(user);
            bbsOnetoone.setQnaType(0);

            bbsOnetooneRepository.save(bbsOnetoone);

            bbsOnetooneRepository.flush();
            return responseService.getSuccessResult();
        }catch (Exception e){
//            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"Exception 오류");
        }

    }

    // 로그인
    @PostMapping(value = "/api/login")
    public Object login(
            @RequestParam(value = "loginId") String id
            ,@RequestParam(value = "loginPw") String pw
            ,HttpServletResponse httpServletResponse
            ,HttpServletRequest httpServletRequest
    ){

        BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
        Map<String, Object> params = new HashMap<>();
        params.put("id", id);
        int userCtn = userMapper.loginIdChk(params);
        if(userCtn > 0) {
            User user = userMapper.findPw(params);
            String findPw = user.getLoginPw();
            if(pe.matches(pw, findPw)) {
                String token = JwtUtil.generateToken(SIGNKEY, user.getSeq().toString());
                String hostname = httpServletRequest.getServerName();
                System.out.println(hostname);
                if(hostname.contains(".com") || hostname.contains(".net")){
                    String domains[] = hostname.split("\\.");
                    System.out.println(domains.length);
                    if(domains.length > 2){
                        hostname = "."+domains[1]+"."+domains[2];
                    }else{
                        hostname = "."+domains[0]+"."+domains[1];
                    }
                }else if(hostname.contains(".co.kr")){
                    String domains[] = hostname.split("\\.");
                    if(domains.length > 3){
                        hostname = "."+domains[1]+"."+domains[2]+"."+domains[3];
                    }else{
                        hostname = "."+domains[0]+"."+domains[1]+"."+domains[2];
                    }
                }
                CookieUtil.create(httpServletResponse, COOKIENAME, token, false, -1, hostname);

                return responseService.getSingleResult(user);
            }else {
                return responseService.getFailResult(0,"Exception 오류");
            }
        }else {
            return responseService.getFailResult(0,"Exception 오류");
        }
    }

    @GetMapping(value = "/api/logout")
    public Object logout(
            HttpServletResponse httpServletResponse,
            HttpServletRequest httpServletRequest
    ){
        String hostname = httpServletRequest.getServerName();
        if(hostname.contains(".com") || hostname.contains(".net")){
            String domains[] = hostname.split("\\.");
            System.out.println(domains.length);
            if(domains.length > 2){
                hostname = "."+domains[1]+"."+domains[2];
            }else{
                hostname = "."+domains[0]+"."+domains[1];
            }
        }else if(hostname.contains(".co.kr")){
            String domains[] = hostname.split("\\.");
            if(domains.length > 3){
                hostname = "."+domains[1]+"."+domains[2]+"."+domains[3];
            }else{
                hostname = "."+domains[0]+"."+domains[1]+"."+domains[2];
            }
        }
        CookieUtil.clear(httpServletResponse, COOKIENAME,hostname);
        System.out.println(JwtUtil.getSubject(httpServletRequest,COOKIENAME,SIGNKEY));
        return new RedirectView("/");
    }

    @GetMapping(value = "/api/contractEdit")
    public Object contractEdit(
            @RequestParam(value = "companySeq") Integer companySeq
            ,@RequestParam(value = "companyName") String companyName
            ,@RequestParam(value = "serviceName") String serviceName
            ,@RequestParam(value = "servicePhone") String servicePhone
            ,@RequestParam(value = "serviceEmail") String serviceEmail
    ){
        try {
            Company company = companyRepository.findOne(companySeq);
            company.setComName(companyName);
            company.setServiceName(serviceName);
            company.setServicePhone(servicePhone);
            company.setServiceEmail(serviceEmail);
            companyRepository.save(company);
            companyRepository.flush();
            return responseService.getSuccessResult();
        }catch (Exception e) {
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"Exception 오류");
        }

    }

    @PostMapping(value = "/api/execlDownList")
    public Object getExeclDownList(ComAbbyy abbyy) {
//        Map<String, Object> result = new HashMap<>();
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

    @PostMapping(value = "/api/licenseExeclDownList")
    public Object getLicenseExeclDownList(
            @RequestParam(value="checkSeq") String checkSeq
    ) {

        Map<String, Object> params = new HashMap<>();

        String chkValueArr = checkSeq;
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> licenseList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            licenseList.add(Integer.parseInt(seq));
        }
        params.put("licenseList", licenseList);
        params.put("sort","create_datetime");
        params.put("order",1);

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

    @PostMapping(value = "/api/contractExeclDownList")
    public Object getContractExeclDownList(
            @RequestParam(value="checkSeq") String checkSeq
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "1") Integer order
    ) {

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

        return responseService.getListResult(execlDownList.size(),execlDownList);

    }

    @PostMapping(value = "/api/contactus")
    public Object contactus(
            Contactus contactus
    ){
        try {
            contactus.setCreateDatetime(new java.util.Date());
            contactusRepository.save(contactus);
            contactusRepository.flush();
            return responseService.getSuccessResult();
        }catch (Exception e) {
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"Exception 오류");
        }
    }


    private String removeTag2(String html) {
        return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
    }

    private String nl2br(String str) {
        str = str.replaceAll("\r\n", "<br>");
        str = str.replaceAll("\r", "<br>");
        str = str.replaceAll("\n", "<br>");

        return str;
    }
}
