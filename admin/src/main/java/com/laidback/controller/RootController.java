package com.laidback.controller;

import com.laidback.model.Admin;
import com.laidback.repository.AdminRepository;
import com.laidback.service.FileStorageService;
import com.laidback.service.EmailService;
import freemarker.template.Configuration;
import freemarker.template.Template;
import org.apache.commons.lang3.RandomStringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.ui.freemarker.FreeMarkerTemplateUtils;
import org.springframework.web.servlet.ModelAndView;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class RootController {
    protected final Logger log = LoggerFactory.getLogger(RootController.class);

    protected final int PAGE_SIZE = 10;

    @Autowired
    protected EmailService emailService;

    @Autowired
    protected Configuration configuration;

    private PasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    @Autowired
    protected PlatformTransactionManager transactionManager;

    @Autowired
    protected AdminRepository adminRepository;

    @Autowired
    protected FileStorageService fileStorageService;


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
    protected void setPaginationDataModal(Map<String, Object> result, int totalCount, int pageNumber, int pageSize) {

        Map<String, Object> paginationData = new HashMap<>();
        paginationData.put("pagesAvailable", (int) Math.ceil((double) totalCount / pageSize));
        paginationData.put("pageNumber", pageNumber);
        paginationData.put("pageSize", pageSize);

        result.put("paginationData", paginationData);
    }

    protected void setOrderValueChange(ModelAndView mav, Map<String, Object> params, int orderValue) {
        if(orderValue == 0) {
            params.put("order", 1);
            mav.addObject("order", 1);
        } else {
            params.put("order", 0);
            mav.addObject("order", 0);
        }
    }
    protected void setOrderValueChangeModal(Map<String, Object> result, Map<String, Object> params, int orderValue) {
        if(orderValue == 0) {
            params.put("order", 1);
            result.put("order", 1);
        } else {
            params.put("order", 0);
            result.put("order", 0);
        }
    }

    protected Object getSessionUser(){
        if(null != SecurityContextHolder.getContext().getAuthentication() &&
                null != SecurityContextHolder.getContext().getAuthentication().getPrincipal()) {

            return SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        }
        return null;
    }

    protected Object resetPw(String adminId){
        Map<String,Object> result = new HashMap<>();
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);
        try{
            Admin admin = adminRepository.findByAdmin(adminId);
            admin.setUpdateDatetime(new Date());
            final String newPassword = RandomStringUtils.random(8, true, true);
            final String encodedPassword = passwordEncoder.encode(newPassword);
            admin.setAdminPw(encodedPassword);

            adminRepository.save(admin);
            adminRepository.flush();
            transactionManager.commit(status);

            //TODO 메일 발송
            final Template t = configuration.getTemplate("mail/password.ftl");
            final Map<String, Object> params = new HashMap<>();
            params.put("adminPw", newPassword);
            //params.put("loginUrl", "www.google.com");
            final String content = FreeMarkerTemplateUtils.processTemplateIntoString(t, params);

            emailService.sendmail("noreply@aworksrpa.com","[a.works] 임시 비밀번호 안내를 위한 메일입니다.",content,admin.getAdminEmail(),null,null);
            result.put("result",true);
            result.put("newPw",newPassword);
        }catch (Exception e){
            transactionManager.rollback(status);
            log.error(e.getMessage(),e);
            result.put("result",false);
        }
        return result;
    }

}
