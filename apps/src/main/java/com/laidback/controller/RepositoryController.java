package com.laidback.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.laidback.mapper.*;
import com.laidback.model.*;
import com.laidback.repository.*;
import com.laidback.service.AmazonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@RestController
public class RepositoryController extends RootController{

    @Autowired
    AmazonClient amazonClient;

    @Autowired
    RepositoryMapper repositoryMapper;

    @Autowired
    RepositoryRepository repositoryRepository;

    @Autowired
    RepositoryMediaMapper repositoryMediaMapper;

    @Autowired
    RepositoryReviewMapper repositoryReviewMapper;

    @Autowired
    RepositoryQnaMapper repositoryQnaMapper;

    @Autowired
    RepositoryQnaAnswerMapper repositoryQnaAnswerMapper;

    @Autowired
    RepositoryLikeMapper repositoryLikeMapper;

    @Autowired
    UserMapper userMapper;

    @Autowired
    UserRepository userRepository;

    @Autowired
    RepositoryLikeRepository repositoryLikeRepository;

    @Autowired
    RepositoryRatingMapper repositoryRatingMapper;

    @Autowired
    RepositoryRatingRepository repositoryRatingRepository;

    @Autowired
    RepositoryDownloadMapper repositoryDownloadMapper;

    @Autowired
    RepositoryReviewRepository repositoryReviewRepository;

    // 최초 페이지 로딩
    @GetMapping(value = "/market")
    public ModelAndView main(
            ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("market/list");
        return mav;
    }

    // 비동기 호출
    @GetMapping(value = "/market/list")
    public Object marketList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "12") Integer row
            ,@RequestParam(value = "search", required = false) String keyword
            ,@RequestParam(value = "criteria", defaultValue = "0") Integer criteria
            ,@RequestParam(value = "componentArr", required = false) String componentArr
            ,@RequestParam(value = "bussinessArr", required = false) String bussinessArr
            ,@RequestParam(value = "applicationArr", required = false) String applicationArr
            ,@RequestParam(value = "contentCtn", required = false) Integer contentCtn
    ){
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        if(contentCtn != null){
            params.put("offset", contentCtn);
            params.put("count", row - (contentCtn - row));
        }else {
            params.put("offset", page * row);
            params.put("count", row);
        }

        // 리스트 정렬 기준
        if(criteria == 0) {
            params.put("sort", "create_datetime");
            params.put("order", 0);
        }else if (criteria == 1) {
            params.put("sort", "last_update");
            params.put("order", 1);
        }else if (criteria == 2) {
            params.put("sort", "view_cnt");
            params.put("order", 1);
        }else if (criteria == 3) {
            params.put("sort", "downloadCnt");
            params.put("order", 1);
        }else if (criteria == 4) {
            params.put("sort", "review");
            params.put("order", 1);
        }else if (criteria == 5) {
            params.put("sort", "likeCnt");
            params.put("order", 1);
        }

        // 제목 또는 타이틀 검색어
        if(keyword != null){
            params.put("keyword", keyword);
        }
        // 검색필터 배열화 및 변수객체 추가
        ArrayList<Integer> componentArray = new ArrayList<>();
        ArrayList<Integer> bussinessArray = new ArrayList<>();
        ArrayList<Integer> applicationArray = new ArrayList<>();
        if(componentArr != null ) {
            String[] componentValue = componentArr.split("\\|");
            for (String component : componentValue) {
                componentArray.add(Integer.parseInt(component));
            }
            params.put("component", componentArray);
        }
        if(bussinessArr != null ) {
            String[] bussinessValue = bussinessArr.split("\\|");
            for (String bussiness : bussinessValue) {
                bussinessArray.add(Integer.parseInt(bussiness));
            }
            params.put("bussiness", bussinessArray);
        }
        if(applicationArr != null ) {
            String[] applicationValue = applicationArr.split("\\|");
            for (String application : applicationValue) {
                applicationArray.add(Integer.parseInt(application));
            }
            params.put("application", applicationArray);
        }
        int totalCount = repositoryMapper.count(params);
        List<Repository> list = repositoryMapper.find(params);
        result.put("total",totalCount);
        result.put("list",list);
        return result;
    }

    @GetMapping(value = "/market/view")
    public ModelAndView view(
            @RequestParam(value="marketId") Integer marketId
            , @RequestParam(value = "reviewPage", defaultValue = "0") Integer reviewPage
            , @RequestParam(value = "QAPage", defaultValue = "0") Integer QAPage
            , ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");

        Repository repo = repositoryRepository.findOne(marketId);
        // view 수 증가
        int viewCount = repo.getViewCnt() + 1;
        repo.setViewCnt(viewCount);
        repositoryRepository.save(repo);
        repositoryRepository.flush();

        // 앱 기본정보 검색
        Repository result = repositoryMapper.getRepository(marketId);

        // 로그인 회원 앱 추천 검색
        Map<String, Object> likeParams = new HashMap<>();
        likeParams.put("marketId", marketId);
        likeParams.put("userSeq", userSeq);
        int rlCount = repositoryLikeMapper.count(likeParams);

        // 이미지 검색
        List<RepositoryMedia> media = repositoryMediaMapper.search(marketId);

        // 리뷰 총 갯수
        int reviewCount = repositoryReviewMapper.count(marketId);
        mav.addObject("reviewCount",reviewCount);
        if(reviewCount > 0) {
            Map<String, Object> params = new HashMap<>();
            params.put("marketId", marketId);
            params.put("offset", 0);
            params.put("count", 5);
            List<RepositoryReview> reviews = repositoryReviewMapper.search(params);
            mav.addObject("reviews",reviews);
        }
        Map<String, Object> qnaParams = new HashMap<>();
        qnaParams.put("marketId", marketId);
        qnaParams.put("offset", 0);
        qnaParams.put("count", 5);

//        List<RepositoryQna> qnas = repositoryQnaMapper.find(qnaParams);
//        for(RepositoryQna qna : qnas){
//            List<RepositoryQnaAnswer> qnaAnswer = repositoryQnaAnswerMapper.find(qna.getSeq());
//
//            qna.setRepositoryQnaAnswer(qnaAnswer);
//        }


        mav.addObject("result",result);
        mav.addObject("like",rlCount);
        mav.addObject("media",media);
        mav.setViewName("market/view");
        return mav;
    }

    @GetMapping(value = "/market/review_list")
    public Object reviewList(
            @RequestParam(value="marketId") Integer marketId
            ,@RequestParam(value="page") Integer page
    ){
        Map<String, Object> reviewParams = new HashMap<>();
        reviewParams.put("marketId", marketId);
        reviewParams.put("offset", 0);
        reviewParams.put("count", 5);

        List<RepositoryReview> reviews = repositoryReviewMapper.find(reviewParams);
        Map<String,Object> result = new HashMap<>();

        result.put("reviewList",reviews);
        return result;
    }

    @GetMapping(value = "/market/qna_list")
    public Object qnaList(
            @RequestParam(value="marketId") Integer marketId
            ,@RequestParam(value="page") Integer page
    ){
        Map<String, Object> qnaParams = new HashMap<>();
        qnaParams.put("marketId", marketId);
        qnaParams.put("offset", 0);
        qnaParams.put("count", 8);

        List<RepositoryQna> qnas = repositoryQnaMapper.find(qnaParams);
        for(RepositoryQna qna : qnas){
            List<RepositoryQnaAnswer> qnaAnswer = repositoryQnaAnswerMapper.find(qna.getSeq());

            qna.setRepositoryQnaAnswer(qnaAnswer);
        }

        Map<String,Object> result = new HashMap<>();
        result.put("qnaList",qnas);
        return result;
    }
    @GetMapping(value = "/market/like")
    public Object like(
            @RequestParam(value="marketId") Integer marketId
            ,@RequestParam(value="loginId") Integer userSeq
    ){
        Map<String,Object> result = new HashMap<>();
        Map<String, Object> params = new HashMap<>();
        params.put("marketId", marketId);
        params.put("userSeq", userSeq);
        int rlCount = repositoryLikeMapper.count(params);
        if(rlCount > 0){
            int rlSeq = repositoryLikeMapper.find(params);
            repositoryLikeRepository.delete(rlSeq);
            repositoryLikeRepository.flush();
            result.put("result", "delete");
        }else {
            RepositoryLike likes = new RepositoryLike();
            Repository r = new Repository();
            User u = new User();
            r.setSeq(marketId);
            u.setSeq(Math.toIntExact(userSeq));
            likes.setRepository(r);
            likes.setUser(u);
            repositoryLikeRepository.save(likes);
            repositoryLikeRepository.flush();
            result.put("result", "add");
        }
        return result;
    }
    @GetMapping(value = "/market/rating")
    public Object rating(
            @RequestParam(value="marketId") Integer marketId
            ,@RequestParam(value="loginId") String loginId
            ,@RequestParam(value="appRating") Double rating
    ){
        Map<String,Object> result = new HashMap<>();
        Long userSeq = userRepository.findByLoginId(loginId);
        Map<String, Object> params = new HashMap<>();
        params.put("marketId", marketId);
        params.put("userSeq", userSeq);
        int r2Count = repositoryRatingMapper.count(params);
        if(r2Count > 0){
            int r2Seq = repositoryRatingMapper.findBySeq(params);
            RepositoryRating ratings = repositoryRatingRepository.findOne(r2Seq);
            Repository r = new Repository();
            User u = new User();
            r.setSeq(marketId);
            u.setSeq(Math.toIntExact(userSeq));
            ratings.setRating(rating);
            ratings.setRepository(r);
            ratings.setUser(u);
            repositoryRatingRepository.save(ratings);
            repositoryRatingRepository.flush();
            result.put("result", "edit");
        }else {
            RepositoryRating ratings = new RepositoryRating();
            Repository r = new Repository();
            User u = new User();
            r.setSeq(marketId);
            u.setSeq(Math.toIntExact(userSeq));
            ratings.setRating(rating);
            ratings.setRepository(r);
            ratings.setUser(u);
            repositoryRatingRepository.save(ratings);
            repositoryRatingRepository.flush();
            result.put("result", "add");
        }
        return result;
    }
    @GetMapping(value = "/market/loginInfo")
    public Object loginInfo(
            @RequestParam(value="marketId") Integer marketId
            ,@RequestParam(value = "loginId") String loginId
    ) {
        Map<String,Object> result = new HashMap<>();
        Long userSeq = userRepository.findByLoginId(loginId);
        Map<String, Object> params = new HashMap<>();
        params.put("marketId", marketId);
        params.put("userSeq", userSeq);
        int like = repositoryLikeMapper.count(params);
        result.put("likeCount", like);
        int ratingCount = repositoryRatingMapper.count(params);
        if (ratingCount > 0) {
            Double rating = repositoryRatingMapper.findByRating(params);
            result.put("rating", rating);
        } else {
            result.put("rating", 0);
        }
        return result;
    }
    @GetMapping(value = "/market/reviewWrite")
    public Object reviewWrite(
            @RequestParam(value="marketId") Integer marketId
            ,@RequestParam(value = "loginId") String loginId
            ,@RequestParam(value = "review") String review
    ) {
        Map<String,Object> result = new HashMap<>();
        Long userSeq = userRepository.findByLoginId(loginId);
        RepositoryReview newReview = new RepositoryReview();
        Repository r = new Repository();
        User u = new User();
        try {
            r.setSeq(marketId);
            u.setSeq(Math.toIntExact(userSeq));
            newReview.setContent(review);
            newReview.setRepository(r);
            newReview.setUser(u);
            repositoryReviewRepository.save(newReview);
            repositoryReviewRepository.flush();
            result.put("result", true);
        }catch (Exception e) {
            result.put("result", false);
        }
        return result;
    }
}
