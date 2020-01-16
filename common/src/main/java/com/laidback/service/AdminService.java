package com.laidback.service;

import com.laidback.model.Admin;
import com.laidback.repository.AdminRepository;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

/**
 * Created by jack on 2018. 7. 28..
 */
@Service
public class AdminService implements UserDetailsService{

    protected final Logger log = LoggerFactory.getLogger(UserService.class);

    @Autowired
    private AdminRepository adminRepository;

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        log.info("username" + userName);
        Admin ad = adminRepository.findByAdmin(userName);
        if(ad == null) throw new UsernameNotFoundException("로그인 정보가 올바르지 않습니다. 다시 시도하세요");
        return ad;
    }
}
