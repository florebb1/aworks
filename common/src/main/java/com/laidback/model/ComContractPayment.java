package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

// 계약회사 결제내역
@Entity
@Table(name = "COM_CONTRACT_PAYMENT")
public class ComContractPayment {

    // 인덱스
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    // 계약회사 키값
    @Column
    private Integer comSeq;

    // 계약금액
    @Column
    private Integer payment;

    // 결제 년도
    @Column
    private String year;

    // 결제 월
    @Column
    private String month;

    // 등록일
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime;

    // 수정일
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateDatetime;

    // 삭제일
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDatetime;


    @Transient
    private Integer ccpRow;

    @Transient
    private String ccpSort;

    @Transient
    private Integer ccpPage;

    @Transient
    private Integer ccpOrder;

    @Transient
    private String ccpStartDate;

    @Transient
    private String ccpEndDate;

    @Transient
    private String ccpSearchType;

    @Transient
    private String ccpSearchWord;

    @Transient
    private String checkedArr;


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

    public Integer getPayment() {
        return payment;
    }

    public void setPayment(Integer payment) {
        this.payment = payment;
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

    public Integer getCcpRow() {
        return ccpRow;
    }

    public void setCcpRow(Integer ccpRow) {
        this.ccpRow = ccpRow;
    }

    public String getCcpSort() {
        return ccpSort;
    }

    public void setCcpSort(String ccpSort) {
        this.ccpSort = ccpSort;
    }

    public Integer getCcpPage() {
        return ccpPage;
    }

    public void setCcpPage(Integer ccpPage) {
        this.ccpPage = ccpPage;
    }

    public Integer getCcpOrder() {
        return ccpOrder;
    }

    public void setCcpOrder(Integer ccpOrder) {
        this.ccpOrder = ccpOrder;
    }

    public String getCcpStartDate() {
        return ccpStartDate;
    }

    public void setCcpStartDate(String ccpStartDate) {
        this.ccpStartDate = ccpStartDate;
    }

    public String getCcpEndDate() {
        return ccpEndDate;
    }

    public void setCcpEndDate(String ccpEndDate) {
        this.ccpEndDate = ccpEndDate;
    }

    public String getCcpSearchType() {
        return ccpSearchType;
    }

    public void setCcpSearchType(String ccpSearchType) {
        this.ccpSearchType = ccpSearchType;
    }

    public String getCcpSearchWord() {
        return ccpSearchWord;
    }

    public void setCcpSearchWord(String ccpSearchWord) {
        this.ccpSearchWord = ccpSearchWord;
    }

    public String getYear() {
        return year;
    }

    public void setYear(String year) {
        this.year = year;
    }

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month;
    }

    public String getCheckedArr() {
        return checkedArr;
    }

    public void setCheckedArr(String checkedArr) {
        this.checkedArr = checkedArr;
    }
}