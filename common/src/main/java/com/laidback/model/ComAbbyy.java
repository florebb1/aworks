package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "COM_ABBYY")
public class ComAbbyy {

    // 키값
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    // 계약회원 코드
    @Column
    private Integer comSeq;

    // 라이선스 시작일
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date startDate;

    // 라이선스 종료일
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date endDate;

    // 0 대기, 1 사용중, 2 중지, 3 종료
    @Column
    private Integer status;

    @Column
    private String abbyyLicenseKey;

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
    private String startDateStr;

    @Transient
    private String endDateStr;

    @Transient
    private String createDatetimeStr;

    @Transient
    private String comName;

    @Transient
    private String deleteArray;

    @Transient
    private String chkValueArr;



    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Integer getComSeq() {
        return comSeq;
    }

    public void setComSeq(Integer comSeq) {
        this.comSeq = comSeq;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getAbbyyLicenseKey() {
        return abbyyLicenseKey;
    }

    public void setAbbyyLicenseKey(String abbyyLicenseKey) {
        this.abbyyLicenseKey = abbyyLicenseKey;
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

    public String getStartDateStr() {
        return startDateStr;
    }

    public void setStartDateStr(String startDateStr) {
        this.startDateStr = startDateStr;
    }

    public String getEndDateStr() {
        return endDateStr;
    }

    public void setEndDateStr(String endDateStr) {
        this.endDateStr = endDateStr;
    }

    public String getCreateDatetimeStr() {
        return createDatetimeStr;
    }

    public void setCreateDatetimeStr(String createDatetimeStr) {
        this.createDatetimeStr = createDatetimeStr;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
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
}
