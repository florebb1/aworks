package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "COM_LICENSE_USE")
public class ComLicenseUse {
    // 키값
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @ManyToOne
    @JoinColumn(name = "com_license_seq")
    private ComLicense comLicense;

    @Column
    private String macAddress;

    @Column
    private String licenseCode;

    @Column
    private Integer countUnattended;

    // 봇타입
    @Column
    private Integer countAttended;

    // 봇타입
    @Column
    private Integer countDeveloper;

    @Column
    private Integer countWorkcenter;

    @Column
    private String comUuid;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime;

    @Column
    private String licenseName;

    @Column
    private Integer status;

    @Column
    private Integer comSeq;

    @Column
    private Integer comContractSeq;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public ComLicense getComLicense() {
        return comLicense;
    }

    public void setComLicense(ComLicense comLicense) {
        this.comLicense = comLicense;
    }

    public String getMacAddress() {
        return macAddress;
    }

    public void setMacAddress(String macAddress) {
        this.macAddress = macAddress;
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

    public Integer getCountDeveloper() {
        return countDeveloper;
    }

    public void setCountDeveloper(Integer countDeveloper) {
        this.countDeveloper = countDeveloper;
    }

    public String getLicenseCode() {
        return licenseCode;
    }

    public void setLicenseCode(String licenseCode) {
        this.licenseCode = licenseCode;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public String getComUuid() {
        return comUuid;
    }

    public void setComUuid(String comUuid) {
        this.comUuid = comUuid;
    }

    public String getLicenseName() {
        return licenseName;
    }

    public void setLicenseName(String licenseName) {
        this.licenseName = licenseName;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getCountWorkcenter() {
        return countWorkcenter;
    }

    public void setCountWorkcenter(Integer countWorkcenter) {
        this.countWorkcenter = countWorkcenter;
    }

    public Integer getComSeq() {
        return comSeq;
    }

    public void setComSeq(Integer comSeq) {
        this.comSeq = comSeq;
    }

    public Integer getComContractSeq() {
        return comContractSeq;
    }

    public void setComContractSeq(Integer comContractSeq) {
        this.comContractSeq = comContractSeq;
    }
}
