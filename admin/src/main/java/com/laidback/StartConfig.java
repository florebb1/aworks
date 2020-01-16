package com.laidback;

import com.laidback.model.Admin;
import com.laidback.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class StartConfig implements CommandLineRunner {
    @Autowired
    private AdminRepository adminRepository;

    @Override
    public void run(String...args){
        List<Admin> admins = adminRepository.findAll();
        if(admins.size() == 0){
            BCryptPasswordEncoder pe = new BCryptPasswordEncoder();
            Admin admin = new Admin();
            admin.setAdminEmail("poscoict@poscoict.com");
            admin.setAdminId("administrator");
            admin.setAdminName("poscoict");
            admin.setAdminPhone("");
            admin.setAdminPw(pe.encode("1234qwer"));
            admin.setLicenseDate1(30);
            admin.setLicenseDate2(15);
            admin.setLicenseDate3(2);
            adminRepository.save(admin);
            adminRepository.flush();
        }
    }
}
