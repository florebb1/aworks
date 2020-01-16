package com.laidback.controller;
import com.amazonaws.services.s3.model.S3Object;
import com.laidback.mapper.RepositoryDownloadMapper;
import com.laidback.mapper.RepositoryLikeMapper;
import com.laidback.mapper.RepositoryRatingMapper;
import com.laidback.mapper.UserMapper;
import com.laidback.model.*;
import com.laidback.repository.*;
import com.laidback.service.AmazonClient;
import com.laidback.service.EmailService;
import com.laidback.util.CookieUtil;
import com.laidback.util.JwtUtil;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.ModelMap;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.net.URLEncoder;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.Map;

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
    BbsFileRepository bbsFileRepository;

    @Value("${gethost.host}")
    public String HOSTNAME;

    // 회원가입
    @PostMapping(value = "/api/signup")
    public Object signup(
            @RequestParam(value = "loginId") String loginId
            ,@RequestParam(value = "loginPw") String loginPw
    ){
        Map<String,Object> result = new HashMap<>();
        BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
        Map<String, Object> params = new HashMap<>();
        params.put("id", loginId);
        User user = new User();
        user.setLoginId(loginId);
        user.setLoginPw(pe.encode(loginPw));
        user.setLevel(1);
        user.setCreateDatetime(new java.util.Date());
        userRepository.save(user);
        userRepository.flush();
        int userChk = userMapper.loginIdChk(params);
        if(userChk > 0) {
            result.put("result", true);
        }else {
            result.put("result", false);
        }
        return result;
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
            result.put("result", false);
        }else {
            result.put("result", true);
        }
        return result;
    }

    // 임시비밀번호 발송
    @PostMapping(value = "/api/searchPw")
    public Object searchPw(
            @RequestParam(value = "findPwEmail") String loginId){

        Map<String, Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            Long userSeq = userRepository.findByLoginId(loginId);
            if (userSeq == null) {
                result.put("result", false);
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
                transactionManager.commit(status);
                // 이메일 발송 로직 추가
                final Template t = configuration.getTemplate("layout/password.ftl");
                Map<String, Object> params = new HashMap<>();
                params.put("loginId", loginId);
                params.put("newPassword", newPassword);
                String content = FreeMarkerTemplateUtils.processTemplateIntoString(t, params);
                emailService.sendmail("noreply@poscoict.com", "[a.works] 임시비밀번호 발송 메일입니다.", content, loginId, null,null);
                result.put("result", true);
            }
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            result.put("result",false);
        }
        return result;
    }

    // 평가하기
    @PostMapping(value = "/api/rating")
    public Object rating(
            @RequestParam(value = "userSeq") Long userSeq
            ,@RequestParam(value = "repositorySeq") Long repositorySeq
            ,@RequestParam(value = "rating") Double rating
    ){
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("userSeq", userSeq);
        params.put("repositorySeq", repositorySeq);

        RepositoryRating duple = repositoryRatingMapper.getDuple(params);
        if(duple.getSeq() == null) {
            DefaultTransactionDefinition def = new DefaultTransactionDefinition();
            TransactionStatus status = transactionManager.getTransaction(def);

            User user = userRepository.findOne(intValue(userSeq));
            Repository repository = repositoryRepository.findOne(intValue(repositorySeq));
            RepositoryRating repositoryRating = new RepositoryRating();
            repositoryRating.setRating(rating);
            repositoryRating.setUser(user);
            repositoryRating.setRepository(repository);

            repositoryRatingRepository.save(repositoryRating);

            repositoryRatingRepository.flush();

            transactionManager.commit(status);
            result.put("result", true);
        }else{
            result.put("result", false);
        }

        return result;
    }

    // 추천하기
    @PostMapping(value = "/api/recomm")
    public Object recomm(
            @RequestParam(value = "userSeq") Long userSeq
            ,@RequestParam(value = "repositorySeq") Long repositorySeq
    ){
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("userSeq", userSeq);
        params.put("repositorySeq", repositorySeq);

        RepositoryLike duple = repositoryLikeMapper.getDuple(params);
        if(duple.getSeq() == null) {
            DefaultTransactionDefinition def = new DefaultTransactionDefinition();
            TransactionStatus status = transactionManager.getTransaction(def);

            User user = userRepository.findOne(intValue(userSeq));
            Repository repository = repositoryRepository.findOne(intValue(repositorySeq));
            RepositoryLike repositoryLike = new RepositoryLike();
            repositoryLike.setUser(user);
            repositoryLike.setRepository(repository);

            repositoryLikeRepository.save(repositoryLike);

            repositoryLikeRepository.flush();

            transactionManager.commit(status);
            result.put("result", true);
        }else{
            result.put("result", false);
        }

        return result;
    }

    // 다운로드
    @PostMapping(value = "/api/download")
    public Object download(
            @RequestParam(value = "userSeq") Integer userSeq
            ,@RequestParam(value = "marketId") Integer marketId
    ){
        Map<String,Object> result = new HashMap<>();
        User u = new User();
        Repository r = new Repository();
        RepositoryDownload rd = new RepositoryDownload();
        try {
            u.setSeq(userSeq);
            r.setSeq(marketId);
            rd.setCreateDatetime(new java.util.Date());
            rd.setUser(u);
            rd.setRepository(r);
            repositoryDownloadRepository.save(rd);
            repositoryDownloadRepository.flush();
            result.put("result", true);
        }catch (Exception e){
            log.error(e.getMessage(),e);
            result.put("result", false);
        }

        return result;
    }

    // 버그신고
    @PostMapping(value = "/api/bug")
    public Object bug(
            @RequestParam(value = "recipient-user") Integer userSeq
            ,@RequestParam(value = "recipient-name") String title
            ,@RequestParam(value = "message-text") String content
            ,@RequestParam(value = "recipient-market") Integer marketId
            ,@RequestParam(value = "bugFile" , required = false) MultipartFile[] bugFile
    ){
        Map<String,Object> result = new HashMap<>();
        BbsOnetoone onetoone = new BbsOnetoone();
        User u = new User();
        Repository r = new Repository();
        r.setSeq(marketId);
        u.setSeq(userSeq);
        try{
            onetoone.setQnaType(2);
            onetoone.setUser(u);
            onetoone.setAnswerYn(0);
            onetoone.setTitle(title);
            onetoone.setContent(content);
            onetoone.setCreateDatetime(new java.util.Date());
            bbsOnetooneRepository.save(onetoone);
            for(int i = 0 ;i < bugFile.length;i++){
                BbsFile bbsFile = new BbsFile();
//                String extension = FilenameUtils.getExtension(bugFile[i].getOriginalFilename());
                String fileUrl = amazonClient.uploadFile(bugFile[i]);
                bbsFile.setBbsSeq(onetoone.getSeq());
                bbsFile.setFileName(fileUrl);
                bbsFile.setCreateDatetime(new java.util.Date());
                bbsFile.setBbsCode("bug");
                bbsFile.setFileType(0);
                bbsFileRepository.save(bbsFile);
            }
            bbsOnetooneRepository.flush();
            bbsFileRepository.flush();
            result.put("result", true);
        }catch (Exception e){
            log.error(e.getMessage(),e);
            result.put("result", false);
        }
        return result;
    }

    // 리뷰 작성
    @PostMapping(value = "/api/review")
    public Object review(
            RepositoryReview repositoryReview, BindingResult bindingResult
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {


            User user = userRepository.findOne(repositoryReview.getUserSeq());
            Repository repository = repositoryRepository.findOne(repositoryReview.getRepositorySeq());

            repositoryReview.setUser(user);
            repositoryReview.setRepository(repository);
            repositoryReviewRepository.save(repositoryReview);

            repositoryReviewRepository.flush();

            transactionManager.commit(status);
            result.put("result", true);
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            result.put("result", false);
        }
        return result;
    }

    // QNA 작성
    @PostMapping(value = "/api/qna")
    public Object qna(
            RepositoryQna repositoryQna, BindingResult bindingResult
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {

            User user = userRepository.findOne(repositoryQna.getUserSeq());
            Repository repository = repositoryRepository.findOne(repositoryQna.getRepositorySeq());

            repositoryQna.setUser(user);
            repositoryQna.setRepository(repository);
            repositoryQnaRepository.save(repositoryQna);

            repositoryQnaRepository.flush();

            transactionManager.commit(status);
            result.put("result", true);
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            result.put("result", false);
        }
        return result;
    }

    // QNA답변 작성
    @PostMapping(value = "/api/qna_answer")
    public Object qnaAnswer(
            RepositoryQnaAnswer repositoryQnaAnswer, BindingResult bindingResult
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try {
            RepositoryQna repositoryQna = repositoryQnaRepository.findOne(repositoryQnaAnswer.getRepositoryQnaSeq());

            repositoryQnaAnswer.setRepositoryQna(repositoryQna);
            repositoryQnaAnswerRepository.save(repositoryQnaAnswer);

            repositoryQnaAnswerRepository.flush();

            transactionManager.commit(status);
            result.put("result", true);
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            result.put("result", false);
        }
        return result;
    }

    // 프로필 업데이트
    @PutMapping(value = "/api/photo_update")
    public Object photo(
            @RequestParam(value = "file") MultipartFile file
            ,@RequestParam(value = "userSeq") Integer userSeq
    ){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        if(file != null){
            try {
                String profileFile = fileStorageService.storeFile(file);
                User user = userRepository.findOne(userSeq);
                user.setProfileImg(profileFile);
                userRepository.save(user);
                userRepository.flush();
                transactionManager.commit(status);
                result.put("result", true);
            }catch (Exception e){
                transactionManager.rollback(status);
                log.error(e.getMessage(),e);
                result.put("result", false);
            }

        }else{
            result.put("result", false);
        }
        return result;
    }

    // 1:1문의 등록
    @PostMapping(value = "/api/onetoone")
    public Object onetoone(BbsOnetoone bbsOnetoone, BindingResult bindingResult){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try{

            User user = userRepository.findOne(bbsOnetoone.getUserSeq());
            bbsOnetoone.setUser(user);
            bbsOnetoone.setQnaType(0);

            bbsOnetooneRepository.save(bbsOnetoone);

            bbsOnetooneRepository.flush();

            transactionManager.commit(status);
            result.put("result", true);
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            result.put("result", false);
        }

        return result;
    }

    // 로그인
    @PostMapping(value = "/api/login")
    public Object login(
            @RequestParam(value = "loginId") String id
            , @RequestParam(value = "loginPw") String pw
            , HttpServletResponse httpServletResponse
            , HttpServletRequest httpServletRequest
    ){
        Map<String,Object> result = new HashMap<>();
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
                result.put("result", true);
                result.put("user", user);
            }else {
                result.put("result", false);
            }
        }else {
            result.put("result", false);
        }
        return result;
    }

    @GetMapping(value = "/api/logout")
    public Object logout(
            HttpServletResponse httpServletResponse
            , HttpServletRequest httpServletRequest
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
        return new RedirectView("/");
    }

    @GetMapping(value = "/license/maketest2")
    public Object licenseMakeTest(
    ){
        Map<String,Object> result = new HashMap<>();
//        result.put("license",secureService.decode("9ceabdbf81109d23498558d209f69e27a70dc9cf01dbf75c088c274362055d87c603bcaec475cf81652e5b67019adf826a275a6b2dd506b46a811e618ce49cfb1b50af20ecafd1c9e4021b72d6fca03bca5a4c81b7cafbd6503ebedd4e30fc06dd388d595966f58f91f91df10bc61bbf754da8af4956670f58e87cad8b31af1840c2424acb5ac9436fe6e44ec9f68695a85027c777e2a90cb7913c5a2786f9b3057e2cbfdf98b7f501f6f343edc32e151af7afb0c57a7a95b48b98c15ff6b1e10705b92d446028cb4b32204072ee161b0d55405be8c0db30386a6a63c61b201d2a998ef1e46261ec68ac017a524d8097b512e7f9640d2582e7b2335f3ec6d041f8d32e84da05f8d22e1a0f118d78f9f6e8d8a0d9b5e89a456d8aeb48ef79bf05baf91babe4e8fd6964b92b7e107b280dee246c8f84e1234354cd0456d9c0dccdedf99f7cfc461905b20eff92e0de8cc2270d1d405252c217dadca7493a629ec485125804c1ad075003ee59859a4c9b402e2bcaaa9e19d5d14024808a48d7a73d241dfd183d348097ec08bc54308ed6de"));
        return result;
    }

    @RequestMapping(value="/api/fileDownload")
    public void fileDownload(HttpServletRequest request, HttpServletResponse response,
                             @RequestParam(value = "fileUrl", required = false) String fileUrl,
                             ModelMap model) throws Exception
    {
        String filePath = fileUrl;

        S3Object s3Object = amazonClient.downloadFile(filePath);
        String fileNameSetting = filePath.substring(filePath.lastIndexOf("/") + 1);

        String realFileName = fileStorageService.storeFile(s3Object, fileNameSetting);
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

        FileInputStream fis = new FileInputStream(file);
        BufferedInputStream bis = new BufferedInputStream(fis);
        ServletOutputStream so = response.getOutputStream();
        BufferedOutputStream bos = new BufferedOutputStream(so);

        byte[] data = new byte[2048];
        int input = 0;
        while((input = bis.read(data)) != -1){
            bos.write(data,0, input);
            bos.flush();
        }

        if(bos != null) bos.close();
        if(bis != null) bis.close();
        if(so != null) so.close();
        if(fis != null) fis.close();

        file.delete();
    }
}
