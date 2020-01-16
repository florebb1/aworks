package com.laidback.model;

import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "Partner")
public class Partner {
    // 키값
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @Column
    private String name;

    @Column
    private String homepage;

    @Column
    private String logo;

    @Column
    private String tel;

    @Column
    private String address;

    @Column
    private String businessNumber;

    @Column
    private String memo;

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
    private String deleteArray;

    @Transient
    private String chkValueArr;

    @Transient
    private MultipartFile logoImgFile;


    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHomepage() {
        return homepage;
    }

    public void setHomepage(String homepage) {
        this.homepage = homepage;
    }

    public String getLogo() {
        return logo;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getBusinessNumber() {
        return businessNumber;
    }

    public void setBusinessNumber(String businessNumber) {
        this.businessNumber = businessNumber;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
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

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getDeleteArray() {
        return deleteArray;
    }

    public void setDeleteArray(String deleteArray) {
        this.deleteArray = deleteArray;
    }

    public String getChkValueArr() {
        return chkValueArr;
    }

    public void setChkValueArr(String chkValueArr) {
        this.chkValueArr = chkValueArr;
    }

    public MultipartFile getLogoImgFile() {
        return logoImgFile;
    }

    public void setLogoImgFile(MultipartFile logoImgFile) {
        this.logoImgFile = logoImgFile;
    }
}
