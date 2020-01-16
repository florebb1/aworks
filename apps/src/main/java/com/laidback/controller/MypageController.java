package com.laidback.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.laidback.mapper.BbsFileMapper;
import com.laidback.mapper.BbsOnetooneMapper;
import com.laidback.mapper.RepositoryDownloadMapper;
import com.laidback.model.BbsFile;
import com.laidback.model.BbsOnetoone;
import com.laidback.model.RepositoryDownload;
import com.laidback.model.User;
import com.laidback.repository.BbsOnetooneRepository;
import com.laidback.repository.RepositoryDownloadRepository;
import com.laidback.repository.UserRepository;
import com.laidback.service.AmazonClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class MypageController extends RootController{
    @Autowired
    AmazonClient amazonClient;

    @Autowired
    BbsOnetooneRepository bbsOnetooneRepository;

    @Autowired
    BbsOnetooneMapper bbsOnetooneMapper;

    @Autowired
    UserRepository userRepository;

    @Autowired
    RepositoryDownloadMapper repositoryDownloadMapper;

    @Autowired
    BbsFileMapper bbsFileMapper;

    @GetMapping(value = "/mypage/onetoone")
    public ModelAndView onetoone(
            @RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            , @RequestParam(value = "page", defaultValue = "0") Integer page
            , @RequestParam(value = "row", defaultValue = "5") Integer row
            , ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("order", 1);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("userSeq", userSeq);

        int totalCount = bbsOnetooneMapper.onetooneByCount(params);
        mav.addObject("no", totalCount - (page * row));

        List<BbsOnetoone> results = bbsOnetooneMapper.repoByOnetoone(params);

        // 답변자 첨부파일 검색
        int aafCount = bbsFileMapper.aafCount();
        if(aafCount > 0) {
            List<BbsFile> files = bbsFileMapper.aaf();
            mav.addObject("files", files);
        }

        mav.addObject("results",results);
        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);

        mav.setViewName("mypage/onetoone");
        return mav;
    }

    @GetMapping(value = "/mypage/profile")
    public ModelAndView profile(
            ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");
        User user = userRepository.findOne(userSeq);
        mav.addObject("user", user);
        mav.setViewName("mypage/profile");
        return mav;
    }

    @GetMapping(value = "/mypage/download")
    public ModelAndView downloadList(
            @RequestParam(value = "page", defaultValue = "0") Integer page
            ,@RequestParam(value = "row", defaultValue = "5") Integer row
            ,@RequestParam(value = "sort", defaultValue = "create_datetime") String sort
            ,ModelAndView mav
            , HttpServletRequest httpServletRequest
    ){
        mav.addObject("s_user",super.getSessionUser(httpServletRequest));
        ObjectMapper oMapper = new ObjectMapper();
        Object obj = super.getSessionUser(httpServletRequest);
        // object -> Map
        Map<String, Object> map = oMapper.convertValue(obj, Map.class);
        Integer userSeq = (Integer) map.get("s_seq");
        Map<String, Object> params = new HashMap<>();
        params.put("sort", sort);
        params.put("order", 1);
        params.put("offset", page * row);
        params.put("count", row);
        params.put("userSeq", userSeq);
//
        int totalCount = repositoryDownloadMapper.count(params);
//
        mav.addObject("no", totalCount - (page * row));
//
        List<RepositoryDownload> results = repositoryDownloadMapper.findByDownload(params);
//
        mav.addObject("results",results);
        setPaginationData(mav, totalCount, page, row);
        mav.addObject("total",totalCount);
        mav.addObject("page",page);
        mav.addObject("row",row);

        mav.setViewName("mypage/download");
        return mav;
    }

    // 정보수정
    @PostMapping(value = "/mypage/edit")
    public Object edit(
            @RequestParam(value = "profileId") String loginId
            ,@RequestParam(value = "profileName") String name
            ,@RequestParam(value = "profileContact", required = false) String phone
            ,@RequestParam(value = "profileCompany", required = false) String company
            ,@RequestParam(value = "profilePosition", required = false) String position
            ,@RequestParam(value = "profileImg", required = false) String profileImg
            ,HttpServletRequest httpServletRequest
    ){
        Map<String,Object> result = new HashMap<>();
        try {
            Long userSeq = userRepository.findByLoginId(loginId);
            User user = userRepository.findOne(Math.toIntExact(userSeq));
            user.setName(name);
            user.setPhone(phone);
            user.setComName(company);
            user.setPosition(position);
            user.setUpdateDatetime(new java.util.Date());
            if(!profileImg.equals("") && profileImg != null){
                String fileUrl = amazonClient.uploadFileBase64(profileImg);
                user.setProfileImg(fileUrl);
            }
            userRepository.save(user);
            userRepository.flush();
            result.put("result", true);
        }catch (Exception e){
            log.error(e.getMessage(),e);
            result.put("result", false);
        }
        return result;
    }

    // 비밀번호수정
    @PostMapping(value = "/mypage/pwModify")
    public Object pwModify(
            @RequestParam(value = "changePwId") Integer userSeq
            ,@RequestParam(value = "originPw") String oldPw
            ,@RequestParam(value = "newPw") String newPw
    ){
        Map<String,Object> result = new HashMap<>();
        try {
            User user = userRepository.findOne(userSeq);
            BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
            String asisPw = user.getLoginPw();
            if(!pe.matches(oldPw,asisPw)){
                result.put("result", false);
            }else{
                user.setLoginPw(pe.encode(newPw));
                userRepository.save(user);
                userRepository.flush();
                result.put("result", true);
            }
        }catch (Exception e){
            log.error(e.getMessage(),e);
            result.put("result", false);
        }
        return result;
    }
    // 프로필 삭제
    @RequestMapping(value = "/mypage/profileDelete", method = RequestMethod.POST)
    public Object repositoryDelete(
            @RequestParam(value="seq") Integer seq
    ) {


        Map<String,Object> result = new HashMap<>();
        User old = userRepository.findOne(seq);

        amazonClient.deleteFileFromS3BucketAsync(old.getProfileImg());
        old.setProfileImg("");
        userRepository.save(old);
        result.put("result",true);
        return result;

    }
}
