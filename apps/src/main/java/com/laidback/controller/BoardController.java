package com.laidback.controller;

import com.laidback.mapper.*;
import com.laidback.model.*;
import com.laidback.repository.*;
import com.laidback.service.AmazonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class BoardController extends RootController {
    @Autowired
    AmazonClient amazonClient;

    @Autowired
    BbsNoticeMapper bbsNoticeMapper;

    @Autowired
    BbsNoticeRepository bbsNoticeRepository;

    @Autowired
    BbsFileMapper bbsFileMapper;

    @Autowired
    UserRepository userRepository;

    @Autowired
    BbsOnetooneRepository bbsOnetooneRepository;

    @Autowired
    BbsFileRepository bbsFileRepository;

    @GetMapping(value = "/board/list")
    public ModelAndView notice(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            , @RequestParam(value = "row", defaultValue = "5") Integer row
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

        mav.addObject("results", results);
        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total", totalCount);
        mav.addObject("page", page);
        mav.addObject("row", row);

        mav.setViewName("board/list");
        return mav;
    }

    @GetMapping(value = "/board/view")
    public ModelAndView noticeView(
            @RequestParam(value = "noticeId") Integer noticeId
            , ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        // view 증가
        BbsNotice bbsRepo = bbsNoticeRepository.findOne(noticeId);
        int viewCount = bbsRepo.getViewCnt() + 1;
        bbsRepo.setViewCnt(viewCount);
        bbsNoticeRepository.save(bbsRepo);
        bbsNoticeRepository.flush();

        // 게시판 기본정보 검색
        BbsNotice bbs = bbsNoticeMapper.detail(noticeId);
        mav.addObject("board", bbs);

        // 게시판 첨부파일 검색
        int fileCount = bbsFileMapper.fileCount(noticeId);
        if(fileCount > 0) {

            List<BbsFile> file = bbsFileMapper.noticeByFiles(noticeId);
            mav.addObject("file",file);
        }
        mav.setViewName("board/view");
        return mav;
    }

    @GetMapping(value = "/board/direct")
    public ModelAndView noticeView(
            ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        mav.setViewName("board/direct");
        return mav;
    }

    // 1:1 문의
    @PostMapping(value = "/board/onetoone")
    public Object bug(
            @RequestParam(value = "recipient-user") Integer userSeq
            ,@RequestParam(value = "recipient-name") String title
            ,@RequestParam(value = "message-text") String content
            ,@RequestParam(value = "bugFile" , required = false) MultipartFile[] bugFile
    ){
        Map<String,Object> result = new HashMap<>();
        BbsOnetoone onetoone = new BbsOnetoone();
        User u = new User();
        u.setSeq(userSeq);
        try{
            onetoone.setQnaType(0);
            onetoone.setUser(u);
            onetoone.setAnswerYn(0);
            onetoone.setTitle(title);
            onetoone.setContent(content);
            onetoone.setCreateDatetime(new java.util.Date());
            bbsOnetooneRepository.save(onetoone);

            for(int i = 0 ;i < bugFile.length;i++){
                BbsFile bbsFile = new BbsFile();
                String fileName = bugFile[i].getOriginalFilename();
                String fileUrl = amazonClient.uploadFile(bugFile[i]);
                bbsFile.setBbsSeq(onetoone.getSeq());
                bbsFile.setFileName(fileUrl);
                bbsFile.setCreateDatetime(new java.util.Date());
                bbsFile.setFileType(0);
                bbsFile.setOriginalFileName(fileName);
                bbsFile.setBbsCode("onetoone");
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
}
