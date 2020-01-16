package com.laidback.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.laidback.mapper.BbsNewsroomMapper;
import com.laidback.mapper.BbsNoticeMapper;
import com.laidback.model.BbsNewsroom;
import com.laidback.model.BbsNotice;
import com.laidback.repository.BbsNoticeRepository;
import com.laidback.response.ResponseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class BoardController extends RootController{
    @Autowired
    BbsNoticeMapper bbsNoticeMapper;

    @Autowired
    BbsNoticeRepository bbsNoticeRepository;

    @Autowired
    BbsNewsroomMapper bbsNewsroomMapper;

    @Autowired
    protected ResponseService responseService;

    @GetMapping(value = "/board/notice")
    public ModelAndView notice(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            , @RequestParam(value = "row", defaultValue = "10") Integer row
            , ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        Map<String, Object> params = new HashMap<>();
        params.put("sort", "create_datetime");
        params.put("order", 1);
        params.put("offset", page * row);
        params.put("count", row);

        int totalCount = bbsNoticeMapper.count(params);

        mav.addObject("no", totalCount - (page * row));

        List<BbsNotice> results = bbsNoticeMapper.find(params);

        mav.addObject("results",results);
        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);

        mav.setViewName("board/notice_list");
        return mav;
    }

    @GetMapping(value = "/board/notice/view")
    public ModelAndView noticeView(
            @RequestParam(value="noticeId") Integer noticeId
            ,ModelAndView mav
            ,HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        BbsNotice bbsNotice = bbsNoticeRepository.findOne(noticeId);
        mav.addObject("row",bbsNotice);
        mav.setViewName("board/notice_view");
        return mav;
    }

    @GetMapping(value="/newsroom/ajax_list")
    public Object newsRoom(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            , @RequestParam(value = "row", defaultValue = "10") Integer row
    ){
//        Object sessionUser = getSessionUser();

        Map<String, Object> params = new HashMap<>();
        params.put("displayYn",0);
        params.put("sort", "create_datetime");
        params.put("order", 1);
        params.put("offset", page * row);
        params.put("count", row);

        int totalCount = bbsNewsroomMapper.count(params);


        List<BbsNewsroom> results = bbsNewsroomMapper.find(params);

        return responseService.getListResult(totalCount,results);
    }
}
