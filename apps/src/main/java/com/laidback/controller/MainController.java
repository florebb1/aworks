package com.laidback.controller;

import com.laidback.mapper.BbsNoticeMapper;
import com.laidback.mapper.RepositoryMapper;
import com.laidback.mapper.RepositoryRecommMapper;
import com.laidback.mapper.UserMapper;
import com.laidback.model.BbsNotice;
import com.laidback.model.Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class MainController extends RootController {
    @Autowired
    UserMapper userMapper;

    @Autowired
    RepositoryMapper repositoryMapper;

    @Autowired
    BbsNoticeMapper bbsNoticeMapper;

    @Autowired
    RepositoryRecommMapper repositoryRecommMapper;

    // 메인
    @RequestMapping(value = "/", method = RequestMethod.GET)
    public ModelAndView main(
            ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        // 가장 인기있는 앱
        List<Repository> popularResult = repositoryMapper.selectPopular();
        // 추천 아이템
        int recommTotal = repositoryRecommMapper.count(); // 관리자 등록 앱 갯수확인
        if(recommTotal > 0) { // 관리자 등록된 앱이 있다면
            List<Repository> recommResult = repositoryMapper.selectRecommAdmin(); // 해당 등록된 앱 검색
            mav.addObject("recomm",recommResult);
            System.out.println("recommResult1 :"+recommResult);
        }else {
            List<Repository> recommResult = repositoryMapper.selectRecomm(); // 다운로드 상위 6개
            mav.addObject("recomm",recommResult);
            System.out.println("recommResult2 :"+recommResult);
        }

        // 신규 업데이트 앱
        List<Repository> updateResult = repositoryMapper.selectUpdate();
        // 공지사항
        Map<String, Object> params = new HashMap<>();
        params.put("sort", "create_datetime");
        params.put("order", 1);
        params.put("offset", 0);
        params.put("count", 3);
        List<BbsNotice> noticeResult = bbsNoticeMapper.find(params);

      if(popularResult != null){
        mav.addObject("popular",popularResult);
      }
      if(updateResult != null){
        mav.addObject("update",updateResult);
      }
        mav.addObject("notice",noticeResult);
        mav.setViewName("main");
        return mav;
    }
}
