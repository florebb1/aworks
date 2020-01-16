package com.laidback.controller;


import com.laidback.mapper.UserMapper;
import com.laidback.model.User;
import com.laidback.repository.AdminRepository;
import com.laidback.repository.UserRepository;
import com.laidback.service.FileStorageService;
import com.laidback.util.JwtUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

public class RootController {


    protected final Logger log = LoggerFactory.getLogger(RootController.class);

    protected final int PAGE_SIZE = 10;

    private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Autowired
    protected PlatformTransactionManager transactionManager;

    @Autowired
    protected AdminRepository adminRepository;

    @Autowired
    protected FileStorageService fileStorageService;

    @Value("${jwt.privateKey}")
    public String SIGNKEY;

    @Value("${jwt.cookieName}")
    public String COOKIENAME;

    @Autowired
    UserRepository userRepository;

    @Autowired
    UserMapper userMapper;
    /**
     * 페이징 데이터 셋팅
     *
     * @param mav
     * @param totalCount
     * @param pageNumber
     * @param pageSize
     */
    protected void setPaginationData(ModelAndView mav, int totalCount, int pageNumber, int pageSize) {

        Map<String, Object> paginationData = new HashMap<>();
        paginationData.put("pagesAvailable", (int) Math.ceil((double) totalCount / pageSize));
        paginationData.put("pageNumber", pageNumber);
        paginationData.put("pageSize", pageSize);

        mav.addObject("paginationData", paginationData);
    }

//    protected Object getSessionUser(){
//        if(null != SecurityContextHolder.getContext().getAuthentication() &&
//                null != SecurityContextHolder.getContext().getAuthentication().getPrincipal()) {
//
//            return SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        }
//        return null;
//    }

    protected Object getSessionUser(HttpServletRequest httpServletRequest){
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> userParams = new HashMap<>();
        String s_seq = JwtUtil.getSubject(httpServletRequest,COOKIENAME,SIGNKEY);
//        System.out.println(s_seq);
        User s_user = new User();
//        userRepository.flush();

        if(s_seq != null){
            userParams.put("seq",Integer.parseInt(s_seq));
            s_user = userMapper.findByUser(userParams);
            result.put("s_seq",s_user.getSeq());
            result.put("s_name",s_user.getName());
            result.put("s_loginId", s_user.getLoginId());
            result.put("s_comseq", s_user.getComSeq());
            result.put("s_profileImg", s_user.getProfileImg());
            result.put("s_level",s_user.getLevel());
            if(s_user.getDownloadYn() != null) {
                result.put("s_downloadYn", s_user.getDownloadYn());
            }else{
                result.put("s_downloadYn", 0);
            }
        }else{
            result.put("s_seq",0);
            result.put("s_name","");
            result.put("s_loginId", "");
            result.put("s_comseq","");
            result.put("s_profileImg", "");
            result.put("s_level","");
            result.put("s_downloadYn","");
//            result.put("s_seq",null);
        }

//        return Integer.parseInt(s_seq);
        return result;
    }
}
