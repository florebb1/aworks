package com.laidback.controller;

import com.laidback.mapper.*;
import com.laidback.model.*;
import com.laidback.repository.RepositoryLikeRepository;
import com.laidback.repository.RepositoryRepository;
import com.laidback.repository.UserRepository;
import com.laidback.response.ResponseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class RepositoryController extends RootController{
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
    protected ResponseService responseService;

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
        if(keyword != null ){
            params.put("keyword", keyword);
        }
        // 검색필터 배열화 및 변수객체 추가
        ArrayList<String> componentArray = new ArrayList<>();
        ArrayList<String> bussinessArray = new ArrayList<>();
        ArrayList<String> applicationArray = new ArrayList<>();
        if(componentArr != null ) {
            String[] componentValue = componentArr.split("\\|");
            for (String component : componentValue) {
                componentArray.add(component);
            }
            params.put("component", componentArray);
        }
        if(bussinessArr != null ) {
            String[] bussinessValue = bussinessArr.split("\\|");
            for (String bussiness : bussinessValue) {
                bussinessArray.add(bussiness);
            }
            params.put("bussiness", bussinessArray);
        }
        if(applicationArr != null ) {
            String[] applicationValue = applicationArr.split("\\|");
            for (String application : applicationValue) {
                applicationArray.add(application);
            }
            params.put("application", applicationArray);
        }
        System.out.println("params :"+params);
        int totalCount = repositoryMapper.count(params);
        List<Repository> list = repositoryMapper.find(params);

        return responseService.getListResult(totalCount,list);
    }

    @GetMapping(value = "/market/view")
    public ModelAndView view(
            @RequestParam(value="marketId") Integer marketId
            ,ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        Repository repo = repositoryRepository.findOne(marketId);
        int viewCount = repo.getViewCnt() + 1;
        repo.setViewCnt(viewCount);
        repositoryRepository.save(repo);
        repositoryRepository.flush();
        Repository result = repositoryMapper.getRepository(marketId);
        Map<String, Object> reviewParams = new HashMap<>();
        reviewParams.put("marketId", marketId);
        reviewParams.put("offset", 0);
        reviewParams.put("count", 5);
        List<RepositoryMedia> media = repositoryMediaMapper.search(marketId);

        mav.addObject("result",result);
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

        return responseService.getListResult(reviews.size(),reviews);
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

        return responseService.getListResult(qnas.size(),qnas);
    }
    @GetMapping(value = "/market/like")
    public Object like(
            @RequestParam(value="marketId") Integer marketId
            ,@RequestParam(value="loginId") String loginId
    ){
        Map<String,Object> result = new HashMap<>();
        Long userSeq = userRepository.findByLoginId(loginId);
        Map<String, Object> params = new HashMap<>();
        params.put("marketId", marketId);
        params.put("userSeq", userSeq);
        int rlCount = repositoryLikeMapper.count(params);
        if(rlCount > 0){
            int rlSeq = repositoryLikeMapper.find(params);
            repositoryLikeRepository.delete(rlSeq);
            repositoryLikeRepository.flush();
            return responseService.getSuccessResult();
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
            return responseService.getSuccessResult();
        }
    }

}
