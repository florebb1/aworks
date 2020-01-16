package com.laidback.controller;

import com.laidback.response.ResponseService;
import com.laidback.service.AmazonClient;
import com.laidback.mapper.RepositoryDownloadMapper;
import com.laidback.mapper.RepositoryQnaMapper;
import com.laidback.mapper.RepositoryReviewMapper;
import com.laidback.mapper.UserMapper;
import com.laidback.model.*;
import com.laidback.repository.RepositoryDownloadRepository;
import com.laidback.repository.RepositoryQnaRepository;
import com.laidback.repository.RepositoryReviewRepository;
import com.laidback.repository.UserRepository;
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

import java.util.*;

@RestController
public class UserController extends RootController{
    @Autowired
    AmazonClient amazonClient;

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserMapper userMapper;

    @Autowired
    RepositoryReviewMapper repositoryReviewMapper;

    @Autowired
    RepositoryReviewRepository repositoryReviewRepository;

    @Autowired
    RepositoryQnaMapper repositoryQnaMapper;

    @Autowired
    RepositoryQnaRepository repositoryQnaRepository;

    @Autowired
    RepositoryDownloadMapper repositoryDownloadMapper;

    @Autowired
    RepositoryDownloadRepository repositoryDownloadRepository;

    @Autowired
    protected ResponseService responseService;

    @GetMapping(value = "/user/list")
    public ModelAndView userList(
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
            params.put("startDate",DateUtil.date2String(DateUtil.dateCalc(DateUtil.string2Date(startDate,"yyyy-MM-dd"),Calendar.DATE,0),"yyyy-MM-dd"));
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


        int totalCount = userMapper.count(params);
        mav.addObject("no", totalCount - (page * row));
        mav.addObject("row",row);

        List<User> results = userMapper.find(params);
        mav.addObject("results",results);

        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("sort", sort);

        mav.setViewName("user/list");
        return mav;
    }


    @GetMapping(value = "/user/info")
    public Object info(
            @RequestParam(value = "userSeq") Integer userSeq
    ){
        Map<String,Object> result = new HashMap<>();
        // 회원정보
        User user = userRepository.findOne(userSeq);
        result.put("info",user);

        // 질문내역
        List<RepositoryQna> qna = repositoryQnaRepository.findByUserSeq(user.getSeq());
        result.put("qna",qna);

        // 리뷰내역
        List<RepositoryReview> review = repositoryReviewRepository.findByUserSeq(user.getSeq());
        result.put("review",review);

        // 다운로드 내역
        List<RepositoryDownload> download = repositoryDownloadRepository.findByUserSeq(user.getSeq());
        result.put("download",download);

        return result;
    }

    // 사용자 등록, 수정 모달 호출
    @GetMapping(value = "/user/userModalView")
    public ModelAndView modalView(ModelAndView mav,
            @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            User user = userMapper.findByUser(params);
            mav.addObject("user", user);
        }

        mav.setViewName("user/userModal");
        return mav;
    }


    @PostMapping(value = "/user/duple_email")
    public Object dupleEmail(
            @RequestParam(value = "loginId") String loginId)
    {
        Map<String,Object> result = new HashMap<>();
        Map<String,Object> params = new HashMap<>();
        params.put("loginId", loginId);

        User user = userMapper.findByUser(params);


        if(user == null) {

            return responseService.getSuccessResult();
        } else  {
            return responseService.getFailResult(0,"");
        }

    }

    // 계약회사 ajax 자동완성
    @GetMapping(value = "/user/get_user")
    public Object getObjectName(@RequestParam(value = "phrase", required = false) String userName){
        Map<String, Object> params = new HashMap<>();
        params.put("userName", userName);
        params.put("comSeq",1);
        List<User> userList = userMapper.userNameSearch(params);
        return userList;
    }

    @PostMapping(value = "/user/save")
    public Object save(User user, BindingResult bindingResult)
    {
        Map<String,Object> result = new HashMap<>();

        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
        try{
            // 수정
            if(user.getSeq() != null){
                User old = userRepository.findOne(user.getSeq());
                old.setName(removeTag(user.getName()));
                old.setPhone(removeTag(user.getPhone()));
                old.setPosition(removeTag(user.getPosition()));
                old.setComName(removeTag(user.getComName()));
                old.setUpdateDatetime(new Date());
                if(!StringUtils.isEmpty(user.getLoginPw()))old.setLoginPw(pe.encode(user.getLoginPw()));
                if(user.getProfileImgFile() != null && !"".equals(user.getProfileImgFile().getOriginalFilename())){
                    String fileUrl = amazonClient.uploadFile(user.getProfileImgFile());
                    old.setProfileImg(fileUrl);
                }
                userRepository.save(old);
            }
            // 등록
            else {
                user.setName(removeTag(user.getName()));
                user.setPhone(removeTag(user.getPhone()));
                user.setPosition(removeTag(user.getPosition()));
                user.setComName(removeTag(user.getComName()));
                System.out.println(new java.util.Date());
                user.setCreateDatetime(new java.util.Date());
                user.setLevel(1);
                if(user.getProfileImgFile() != null && !"".equals(user.getProfileImgFile().getOriginalFilename())){
                    String fileUrl = amazonClient.uploadFile(user.getProfileImgFile());
                    //String profileImg = fileStorageService.storeFile(user.getProfileImgFile());
                    user.setProfileImg(fileUrl);
                }else{
                    user.setProfileImg("");
                }
                if(!StringUtils.isEmpty(user.getLoginPw()))user.setLoginPw(pe.encode(user.getLoginPw()));
                userRepository.save(user);
            }

            userRepository.flush();
            transactionManager.commit(status);
            return responseService.getSuccessResult();
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    // 사용자 상세 정보 페이지 호출
    @GetMapping(value = "/user/userView")
    public ModelAndView view(ModelAndView mav,
            @RequestParam(value = "seq", defaultValue = "0") Integer seq)
    {
        Map<String, Object> params = new HashMap<>();
        if(seq != 0) {
            params.put("seq", seq);
            User user = userMapper.findByUser(params);
            mav.addObject("user", user);
        }

        mav.setViewName("user/view");
        return mav;
    }

    // 사용자 삭제 처리
    @RequestMapping(value = "/user/userDelete", method = RequestMethod.POST)
    public Object userDelete(User user, BindingResult bindingResult) {

        Map<String,Object> params = new HashMap<>();
        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        Integer delY = 0;
        Integer delN = 0;
        try{
            String deleteArray = user.getDeleteArray();
            String[] deleteArrayList = deleteArray.split("\\|");
            for(String seq : deleteArrayList) {
                params.put("seq", Integer.parseInt(seq));
                user = userMapper.findByUser(params);
                if(user.getLevel() == 1) {
                    user.setSeq(Integer.parseInt(seq));
                    user.setDeleteDatetime(new java.util.Date());
                    userRepository.save(user);
                    userRepository.flush();
                    delY++;
                }else{
                    delN++;
                }
            }

            transactionManager.commit(status);
            result.put("delY",delY);
            result.put("delN",delN);
            return responseService.getSingleResult(result);
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            return responseService.getFailResult(0,"");
        }

    }

    // 엑셀다운로드 대상 리스트 추출
    @PostMapping(value = "/user/execlDownList")
    public Object getExeclDownList(
            User user
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "0") Integer order
    ) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();

        String chkValueArr = user.getChkValueArr();
        String[] chkValueArrList = chkValueArr.split("\\|");
        ArrayList<Integer> userList = new ArrayList<>();
        for(String seq : chkValueArrList) {
            userList.add(Integer.parseInt(seq));
        }
        params.put("userList", userList);
        params.put("sort",sort);
        params.put("order",order);

        List<User> execlDownList = userMapper.getExeclDownList(params);

        return responseService.getListResult(execlDownList.size(),execlDownList);
    }

    // 리뷰 히스토리 호출
    @RequestMapping(value = "/user/reviewList", method = RequestMethod.POST)
    public Object reviewList(User user, BindingResult bindingResult) {

        Map<String, Object> params = new HashMap<>();
        params.put("sort", user.getRvSort());
        params.put("offset", (user.getRvPage() - 1) * user.getRvRow());
        params.put("count", user.getRvRow());
        params.put("userSeq", user.getSeq());

        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

        // Order value Change
        setOrderValueChangeModal(result, params, user.getRvOrder());

        int totalCount = repositoryReviewMapper.countByUser(params);
        result.put("no", (int) Math.ceil((double) totalCount / user.getRvRow()));
        result.put("row", user.getRvRow());

        List<RepositoryReview> results = repositoryReviewMapper.findByUser(params);
        result.put("resultsList", results);
        result.put("total", totalCount);
        result.put("sort", user.getRvSort());
        result.put("userSeq", user.getSeq());

        return result;
    }

    // 질문 히스토리 호출
    @RequestMapping(value = "/user/qnaList", method = RequestMethod.POST)
    public Object qnaList(User user, BindingResult bindingResult) {

        Map<String, Object> params = new HashMap<>();
        params.put("sort", user.getQnaSort());
        params.put("offset", (user.getQnaPage() - 1) * user.getQnaRow());
        params.put("count", user.getQnaRow());
        params.put("userSeq", user.getSeq());

        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

        // Order value Change
        setOrderValueChangeModal(result, params, user.getQnaOrder());

        int totalCount = repositoryQnaMapper.countByUser(params);
        result.put("no", (int) Math.ceil((double) totalCount / user.getQnaRow()));
        result.put("row", user.getQnaRow());

        List<RepositoryReview> results = repositoryQnaMapper.findByUser(params);
        result.put("resultsList", results);
        result.put("total", totalCount);
        result.put("sort", user.getQnaSort());
        result.put("userSeq", user.getSeq());

        return result;
    }

    // 다운로드 히스토리 호출
    @RequestMapping(value = "/user/downloadList", method = RequestMethod.POST)
    public Object downloadList(User user, BindingResult bindingResult) {

        Map<String, Object> params = new HashMap<>();
        params.put("sort", user.getDlSort());
        params.put("offset", (user.getDlPage() - 1) * user.getDlRow());
        params.put("count", user.getDlRow());
        params.put("userSeq", user.getSeq());

        Map<String,Object> result = new HashMap<>();
        if(bindingResult.hasErrors()){
            for(ObjectError oe: bindingResult.getAllErrors()){
                log.error(oe.getDefaultMessage());
            }
            return responseService.getFailResult(0,"");
        }

        // Order value Change
        setOrderValueChangeModal(result, params, user.getDlOrder());

        int totalCount = repositoryDownloadMapper.countByUser(params);
        result.put("no", (int) Math.ceil((double) totalCount / user.getDlRow()));
        result.put("row", user.getDlRow());

        List<RepositoryDownload> results = repositoryDownloadMapper.findByUser(params);
        result.put("resultsList", results);
        result.put("total", totalCount);
        result.put("sort", user.getDlSort());
        result.put("userSeq", user.getSeq());

        return result;
    }

    @RequestMapping(value = "/user/ajax_list" , method = RequestMethod.GET)
    public Object ajaxList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "10") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,@RequestParam(value = "order", defaultValue = "1") Integer order
            ,@RequestParam(value = "searchWord", required = false) String searchWord
            ,@RequestParam(value = "searchType", required = false) String searchType
            ,@RequestParam(value = "startDate",required = false)String startDate
            ,@RequestParam(value = "endDate",required = false)String endDate
    ){
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("order",order);
        params.put("offset", page * row);
        params.put("count", row);


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

        if(searchWord != null){
            params.put("searchWord",searchWord);
            params.put("searchType",searchType);
        }


        int totalCount = userMapper.count(params);

        List<User> results = userMapper.find(params);

        return responseService.getListResult(totalCount,results);
    }

    // 이미지 삭제 처리
    @RequestMapping(value = "/user/profileDelete", method = RequestMethod.POST)
    public Object profileDelete(
            @RequestParam(value="seq") Integer seq
    ) {


        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

        User old = userRepository.findOne(seq);

        amazonClient.deleteFileFromS3BucketAsync(old.getProfileImg());

        old.setProfileImg("");
        userRepository.save(old);
        userRepository.flush();
        transactionManager.commit(status);

        return responseService.getSuccessResult();

    }

    public String removeTag(String html) throws Exception {
        return html.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", "");
    }
}
