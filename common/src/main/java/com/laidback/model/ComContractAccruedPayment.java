package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

// 계약회사 미수금 내역
@Entity
@Table(name = "COM_CONTRACT_ACCRUED_PAYMENT")
public class ComContractAccruedPayment {

    // 인덱스
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    // 계약회사 키값
    @Column
    private Integer comSeq;

    // 미수금액
    @Column
    private Integer accruedPayment;

    @Column
    private String year;

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
    private Integer ccapRow;

    @Transient
    private String ccapSort;

    @Transient
    private Integer ccapPage;

    @Transient
    private Integer ccapOrder;

    @Transient
    private String ccapStartDate;

    @Transient
    private String ccapEndDate;

    @Transient
    private String ccapSearchType;

    @Transient
    private String ccapSearchWord;

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

    public Integer getAccruedPayment() {
        return accruedPayment;
    }

    public void setAccruedPayment(Integer accruedPayment) {
        this.accruedPayment = accruedPayment;
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

    public Integer getCcapRow() {
        return ccapRow;
    }

    public void setCcapRow(Integer ccapRow) {
        this.ccapRow = ccapRow;
    }

    public String getCcapSort() {
        return ccapSort;
    }

    public void setCcapSort(String ccapSort) {
        this.ccapSort = ccapSort;
    }

    public Integer getCcapPage() {
        return ccapPage;
    }

    public void setCcapPage(Integer ccapPage) {
        this.ccapPage = ccapPage;
    }

    public Integer getCcapOrder() {
        return ccapOrder;
    }

    public void setCcapOrder(Integer ccapOrder) {
        this.ccapOrder = ccapOrder;
    }

    public String getCcapStartDate() {
        return ccapStartDate;
    }

    public void setCcapStartDate(String ccapStartDate) {
        this.ccapStartDate = ccapStartDate;
    }

    public String getCcapEndDate() {
        return ccapEndDate;
    }

    public void setCcapEndDate(String ccapEndDate) {
        this.ccapEndDate = ccapEndDate;
    }

    public String getCcapSearchType() {
        return ccapSearchType;
    }

    public void setCcapSearchType(String ccapSearchType) {
        this.ccapSearchType = ccapSearchType;
    }

    public String getCcapSearchWord() {
        return ccapSearchWord;
    }

    public void setCcapSearchWord(String ccapSearchWord) {
        this.ccapSearchWord = ccapSearchWord;
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