package com.laidback.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;

// 계약회사 기간 히스토리
@Entity
@Table(name = "COM_CONTRACT")
public class ComContract {

    // 인덱스
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    // 계약회사 키값

    @ManyToOne
    @JoinColumn(name = "com_seq")
    private Company company;


    @ManyToOne
    @JoinColumn(name = "user_seq")
    private User user;

    // 계약번호
    @Column
    private String contractNumber;

    // 계약명
    @Column
    private String contractName;

    // 계약 시작일
    @Temporal(TemporalType.TIMESTAMP)
    private Date contractStart;

    // 계약 종료일
    @Temporal(TemporalType.TIMESTAMP)
    private Date contractEnd;

    // 계약담당자
    @Column
    private String contractChargerName;

    // 계약 담당자 이메일
    @Column
    private String contractChargerEmail;

    // 계약 담당자 연락처
    @Column
    private String contractChargerPhone;

    // ict 담당자
    @Column
    private String contractIctName;

    // 등록일
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime;

    // 삭제일
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDatetime;

    @Transient
    private String userName;

    @Transient
    private String loginId;

    @Transient
    private String userPhone;

    @Transient
    private Integer countLicense;

    @Column
    private Integer contractStatus;

    @Transient
    private String comName;

    @Transient
    private Integer comSeq;

    @Transient
    private Integer userSeq;

    @Transient
    private Integer contractType;

    @Transient
    private Integer licenseType;

    @Transient
    private Integer subscribeType;

    @Transient
    private Integer unattendedLicensePrice;

    @Transient
    private Integer unattendedLicenseListPrice;

    @Transient
    private Integer countUnattended;

    @Transient
    private Integer attendedLicensePrice;

    @Transient
    private Integer attendedLicenseListPrice;

    @Transient
    private Integer countAttended;

    @Transient
    private Integer studioLicensePrice;

    @Transient
    private Integer studioLicenseListPrice;

    @Transient
    private Integer countStudio;

    @Transient
    private Integer workcenterLicensePrice;

    @Transient
    private Integer workcenterLicenseListPrice;

    @Transient
    private Integer countWorkcenter;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Company getCompany() {
        return company;
    }

    public void setCompany(Company company) {
        this.company = company;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getContractNumber() {
        return contractNumber;
    }

    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
    }

    public String getContractName() {
        return contractName;
    }

    public void setContractName(String contractName) {
        this.contractName = contractName;
    }

    public Date getContractStart() {
        return contractStart;
    }

    public void setContractStart(Date contractStart) {
        this.contractStart = contractStart;
    }

    public Date getContractEnd() {
        return contractEnd;
    }

    public void setContractEnd(Date contractEnd) {
        this.contractEnd = contractEnd;
    }

    public String getContractChargerName() {
        return contractChargerName;
    }

    public void setContractChargerName(String contractChargerName) {
        this.contractChargerName = contractChargerName;
    }

    public String getContractChargerEmail() {
        return contractChargerEmail;
    }

    public void setContractChargerEmail(String contractChargerEmail) {
        this.contractChargerEmail = contractChargerEmail;
    }

    public String getContractChargerPhone() {
        return contractChargerPhone;
    }

    public void setContractChargerPhone(String contractChargerPhone) {
        this.contractChargerPhone = contractChargerPhone;
    }

    public String getContractIctName() {
        return contractIctName;
    }

    public void setContractIctName(String contractIctName) {
        this.contractIctName = contractIctName;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public Integer getCountLicense() {
        return countLicense;
    }

    public void setCountLicense(Integer countLicense) {
        this.countLicense = countLicense;
    }

    public Integer getContractStatus() {
        return contractStatus;
    }

    public void setContractStatus(Integer contractStatus) {
        this.contractStatus = contractStatus;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    public Date getDeleteDatetime() {
        return deleteDatetime;
    }

    public void setDeleteDatetime(Date deleteDatetime) {
        this.deleteDatetime = deleteDatetime;
    }

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public Integer getComSeq() {
        return comSeq;
    }

    public void setComSeq(Integer comSeq) {
        this.comSeq = comSeq;
    }

    public Integer getUserSeq() {
        return userSeq;
    }

    public void setUserSeq(Integer userSeq) {
        this.userSeq = userSeq;
    }

    public Integer getContractType() {
        return contractType;
    }

    public void setContractType(Integer contractType) {
        this.contractType = contractType;
    }

    public Integer getLicenseType() {
        return licenseType;
    }

    public void setLicenseType(Integer licenseType) {
        this.licenseType = licenseType;
    }

    public Integer getSubscribeType() {
        return subscribeType;
    }

    public void setSubscribeType(Integer subscribeType) {
        this.subscribeType = subscribeType;
    }

    public Integer getUnattendedLicensePrice() {
        return unattendedLicensePrice;
    }

    public void setUnattendedLicensePrice(Integer unattendedLicensePrice) {
        this.unattendedLicensePrice = unattendedLicensePrice;
    }

    public Integer getUnattendedLicenseListPrice() {
        return unattendedLicenseListPrice;
    }

    public void setUnattendedLicenseListPrice(Integer unattendedLicenseListPrice) {
        this.unattendedLicenseListPrice = unattendedLicenseListPrice;
    }

    public Integer getCountUnattended() {
        return countUnattended;
    }

    public void setCountUnattended(Integer countUnattended) {
        this.countUnattended = countUnattended;
    }

    public Integer getAttendedLicensePrice() {
        return attendedLicensePrice;
    }

    public void setAttendedLicensePrice(Integer attendedLicensePrice) {
        this.attendedLicensePrice = attendedLicensePrice;
    }

    public Integer getAttendedLicenseListPrice() {
        return attendedLicenseListPrice;
    }

    public void setAttendedLicenseListPrice(Integer attendedLicenseListPrice) {
        this.attendedLicenseListPrice = attendedLicenseListPrice;
    }

    public Integer getCountAttended() {
        return countAttended;
    }

    public void setCountAttended(Integer countAttended) {
        this.countAttended = countAttended;
    }

    public Integer getStudioLicensePrice() {
        return studioLicensePrice;
    }

    public void setStudioLicensePrice(Integer studioLicensePrice) {
        this.studioLicensePrice = studioLicensePrice;
    }

    public Integer getStudioLicenseListPrice() {
        return studioLicenseListPrice;
    }

    public void setStudioLicenseListPrice(Integer studioLicenseListPrice) {
        this.studioLicenseListPrice = studioLicenseListPrice;
    }

    public Integer getCountStudio() {
        return countStudio;
    }

    public void setCountStudio(Integer countStudio) {
        this.countStudio = countStudio;
    }

    public Integer getWorkcenterLicensePrice() {
        return workcenterLicensePrice;
    }

    public void setWorkcenterLicensePrice(Integer workcenterLicensePrice) {
        this.workcenterLicensePrice = workcenterLicensePrice;
    }

    public Integer getWorkcenterLicenseListPrice() {
        return workcenterLicenseListPrice;
    }

    public void setWorkcenterLicenseListPrice(Integer workcenterLicenseListPrice) {
        this.workcenterLicenseListPrice = workcenterLicenseListPrice;
    }

    public Integer getCountWorkcenter() {
        return countWorkcenter;
    }

    public void setCountWorkcenter(Integer countWorkcenter) {
        this.countWorkcenter = countWorkcenter;
    }
}