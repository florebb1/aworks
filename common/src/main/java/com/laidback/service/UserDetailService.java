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
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

@Service
public class UserDetailService implements UserDetailsService {
    protected final Logger log = LoggerFactory.getLogger(UserDetailsService.class);

    @Autowired
    private AdminRepository adminRepository;

    @Autowired
    protected PlatformTransactionManager transactionManager;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Admin admin = adminRepository.findByAdmin(username);
        if(admin == null) throw new UsernameNotFoundException("로그인 정보가 올바르지 않습니다. 다시 시도하세요");

        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        TransactionStatus status = transactionManager.getTransaction(def);

//        try{
//            user.setLastLoginDateTime(new Date());
//            userRepository.save(user);
//            userRepository.flush();
//            transactionManager.commit(status);
//        }catch (Exception e){
//            transactionManager.rollback(status);
//        }

        return admin;
    }
}
