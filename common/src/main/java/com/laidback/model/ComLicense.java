package com.laidback.model;

import org.apache.http.annotation.Contract;

import javax.persistence.*;
import java.math.BigInteger;
import java.util.Date;

@Entity
@Table(name = "COM_LICENSE")
public class ComLicense {

    // 키값
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;



    // 계약 코드
    @ManyToOne
    @JoinColumn(name = "com_contract_seq")
    private ComContract comContract;

    // 계약 타입
    @Column
    private Integer contractType;

    // 라이선스 종류
    @Column
    private Integer licenseType;

    // 과금 종류
    @Column
    private Integer subscribeType;

     //봇타입
    @Column
    private Integer countUnattended;

    // 봇타입
    @Column
    private Integer countAttended;

    // 봇타입
    @Column
    private Integer countStudio;

    @Column
    private Long unattendedLicensePrice;

    // list price
    @Column
    private Long unattendedLicenseListPrice;

    @Column
    private Long attendedLicensePrice;

    // list price
    @Column
    private Long attendedLicenseListPrice;

    @Column
    private Long studioLicensePrice;

    // list price
    @Column
    private Long studioLicenseListPrice;

    @Column
    private Long workcenterLicensePrice;

    // list price
    @Column
    private Long workcenterLicenseListPrice;

    @Column
    private Integer countWorkcenter;

    @Column
    private Integer licenseStatus;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateDatetime;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDatetime;

    @Transient
    private Integer countAttendedUse;

    @Transient
    private Integer countUnAttendedUse;

    @Transient
    private Integer countStudioUse;

    @Transient
    private Integer countWorkcenterUse;

    @Transient
    private String contractNumber;

    @Transient
    private Integer comContractSeq;

    @Transient
    private Date contractStart;

    @Transient
    private Date contractEnd;

    @Transient
    private Contract contract;

    @Transient
    private Integer contractStatus;

    @Transient
    private String userName;

    @Transient
    private String loginId;

    @Transient
    private String userPhone;

    @Transient
    private String contractIctName;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public ComContract getComContract() {
        return comContract;
    }

    public void setComContract(ComContract comContract) {
        this.comContract = comContract;
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

    public Integer getCountUnattended() {
        return countUnattended;
    }

    public void setCountUnattended(Integer countUnattended) {
        this.countUnattended = countUnattended;
    }

    public Integer getCountAttended() {
        return countAttended;
    }

    public void setCountAttended(Integer countAttended) {
        this.countAttended = countAttended;
    }

    public Integer getCountStudio() {
        return countStudio;
    }

    public void setCountStudio(Integer countStudio) {
        this.countStudio = countStudio;
    }

    public Long getUnattendedLicensePrice() {
        return unattendedLicensePrice;
    }

    public void setUnattendedLicensePrice(Long unattendedLicensePrice) {
        this.unattendedLicensePrice = unattendedLicensePrice;
    }

    public Long getUnattendedLicenseListPrice() {
        return unattendedLicenseListPrice;
    }

    public void setUnattendedLicenseListPrice(Long unattendedLicenseListPrice) {
        this.unattendedLicenseListPrice = unattendedLicenseListPrice;
    }

    public Long getAttendedLicensePrice() {
        return attendedLicensePrice;
    }

    public void setAttendedLicensePrice(Long attendedLicensePrice) {
        this.attendedLicensePrice = attendedLicensePrice;
    }

    public Long getAttendedLicenseListPrice() {
        return attendedLicenseListPrice;
    }

    public void setAttendedLicenseListPrice(Long attendedLicenseListPrice) {
        this.attendedLicenseListPrice = attendedLicenseListPrice;
    }

    public Long getStudioLicensePrice() {
        return studioLicensePrice;
    }

    public void setStudioLicensePrice(Long studioLicensePrice) {
        this.studioLicensePrice = studioLicensePrice;
    }

    public Long getStudioLicenseListPrice() {
        return studioLicenseListPrice;
    }

    public void setStudioLicenseListPrice(Long studioLicenseListPrice) {
        this.studioLicenseListPrice = studioLicenseListPrice;
    }

    public Long getWorkcenterLicensePrice() {
        return workcenterLicensePrice;
    }

    public void setWorkcenterLicensePrice(Long workcenterLicensePrice) {
        this.workcenterLicensePrice = workcenterLicensePrice;
    }

    public Long getWorkcenterLicenseListPrice() {
        return workcenterLicenseListPrice;
    }

    public void setWorkcenterLicenseListPrice(Long workcenterLicenseListPrice) {
        this.workcenterLicenseListPrice = workcenterLicenseListPrice;
    }

    public Integer getCountWorkcenter() {
        return countWorkcenter;
    }

    public void setCountWorkcenter(Integer countWorkcenter) {
        this.countWorkcenter = countWorkcenter;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Date getUpdateDatetime() {
        return updateDatetime;
    }

    public void setUpdateDatetime(Date updateDatetime) {
        this.updateDatetime = updateDatetime;
    }

    public Date getDeleteDatetime() {
        return deleteDatetime;
    }

    public void setDeleteDatetime(Date deleteDatetime) {
        this.deleteDatetime = deleteDatetime;
    }

    public Integer getCountAttendedUse() {
        return countAttendedUse;
    }

    public void setCountAttendedUse(Integer countAttendedUse) {
        this.countAttendedUse = countAttendedUse;
    }

    public Integer getCountUnAttendedUse() {
        return countUnAttendedUse;
    }

    public void setCountUnAttendedUse(Integer countUnAttendedUse) {
        this.countUnAttendedUse = countUnAttendedUse;
    }

    public Integer getCountStudioUse() {
        return countStudioUse;
    }

    public void setCountStudioUse(Integer countStudioUse) {
        this.countStudioUse = countStudioUse;
    }

    public String getContractNumber() {
        return contractNumber;
    }

    public void setContractNumber(String contractNumber) {
        this.contractNumber = contractNumber;
    }

    public Integer getComContractSeq() {
        return comContractSeq;
    }

    public void setComContractSeq(Integer comContractSeq) {
        this.comContractSeq = comContractSeq;
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

    public Integer getLicenseStatus() {
        return licenseStatus;
    }

    public void setLicenseStatus(Integer licenseStatus) {
        this.licenseStatus = licenseStatus;
    }

    public Contract getContract() {
        return contract;
    }

    public void setContract(Contract contract) {
        this.contract = contract;
    }

    public Integer getContractStatus() {
        return contractStatus;
    }

    public void setContractStatus(Integer contractStatus) {
        this.contractStatus = contractStatus;
    }

    public Integer getCountWorkcenterUse() {
        return countWorkcenterUse;
    }

    public void setCountWorkcenterUse(Integer countWorkcenterUse) {
        this.countWorkcenterUse = countWorkcenterUse;
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

    public String getUserPhone() {
        return userPhone;
    }

    public void setUserPhone(String userPhone) {
        this.userPhone = userPhone;
    }

    public String getContractIctName() {
        return contractIctName;
    }

    public void setContractIctName(String contractIctName) {
        this.contractIctName = contractIctName;
    }
}
