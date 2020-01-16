package com.laidback.model;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import javax.persistence.*;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;

@Entity
@Table(name = "SITE_CONFIG")
public class Admin implements UserDetails {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @Column
    private String adminId;

    @Column
    private String adminPw;

    @Column
    private String adminEmail;

    @Column
    private String adminPhone;

    @Column
    private String adminName;

    @Column
    private Integer licenseDate1;

    @Column
    private Integer licenseDate2;

    @Column
    private Integer licenseDate3;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateDatetime;

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        Collection<GrantedAuthority> authorities = new HashSet<>(1);
        authorities.add(new SimpleGrantedAuthority("ROLE_ADMIN"));
        return authorities;
    }

    @Override
    public String getPassword() {
        return adminPw;
    }

    @Override
    public String getUsername() {
        return adminId;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    public String getAdminId() {
        return adminId;
    }

    public void setAdminId(String adminId) {
        this.adminId = adminId;
    }

    public String getAdminPw() {
        return adminPw;
    }

    public void setAdminPw(String adminPw) {
        this.adminPw = adminPw;
    }

    public String getAdminEmail() {
        return adminEmail;
    }

    public void setAdminEmail(String adminEmail) {
        this.adminEmail = adminEmail;
    }

    public String getAdminPhone() {
        return adminPhone;
    }

    public void setAdminPhone(String adminPhone) {
        this.adminPhone = adminPhone;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public Integer getLicenseDate1() {
        return licenseDate1;
    }

    public void setLicenseDate1(Integer licenseDate1) {
        this.licenseDate1 = licenseDate1;
    }

    public Integer getLicenseDate2() {
        return licenseDate2;
    }

    public void setLicenseDate2(Integer licenseDate2) {
        this.licenseDate2 = licenseDate2;
    }

    public Integer getLicenseDate3() {
        return licenseDate3;
    }

    public void setLicenseDate3(Integer licenseDate3) {
        this.licenseDate3 = licenseDate3;
    }

    public Date getUpdateDatetime() {
        return updateDatetime;
    }

    public void setUpdateDatetime(Date updateDatetime) {
        this.updateDatetime = updateDatetime;
    }

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }


}
