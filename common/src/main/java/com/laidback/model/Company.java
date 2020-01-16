package com.laidback.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;

// 계약회사
@Entity
@Table(name = "COMPANY")
public class Company {

    // 인덱스
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    // 회사명
    @Column
    private String comName;

    // 회사 uuid
    @Column
    private String comUuid;

    @Column
    private String comPhone;

    @Column
    private String comEmail;

    @Transient
    private Integer countContract;
//
//    // 계약 형태(0:온라인, 1:오프라인)
//    @Column
//    private Integer contractType;

    // 운영 담당자
    @Column
    private String serviceName;

    // 운영담당자 연락처
    @Column
    private String servicePhone;

    // 운영담당자 이메일
    @Column
    private String serviceEmail;

    // 등록일
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime;

    // 수정일
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateDatetime;

    // 수정일
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDatetime;

    // 계약회사 상태
    // 0: 사용, 1: 해지
    @Column
    private Integer status;

    @Column
    @Type(type="text")
    private String contractReason;

    @Transient
    private String userName;

    @Transient
    private String loginId;

    @Transient
    private String contractStart;

    @Transient
    private String contractEnd;

    @Transient
    private String contractPerson;

    @Transient
    private String deleteArray;

    @Transient
    private String chkValueArr;

    @Transient
    private Integer cuRow;

    @Transient
    private String cuSort;

    @Transient
    private Integer cuPage;

    @Transient
    private Integer cuOrder;


    @Transient
    private Integer clRow;

    @Transient
    private String clSort;

    @Transient
    private Integer clPage;

    @Transient
    private Integer clOrder;

    @Transient
    private String clStartDate;

    @Transient
    private String clEndDate;

    @Transient
    private String clSearchType;

    @Transient
    private String clSearchWord;



    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getServicePhone() {
        return servicePhone;
    }

    public void setServicePhone(String servicePhone) {
        this.servicePhone = servicePhone;
    }

    public String getServiceEmail() {
        return serviceEmail;
    }

    public void setServiceEmail(String serviceEmail) {
        this.serviceEmail = serviceEmail;
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

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getContractReason() {
        return contractReason;
    }

    public void setContractReason(String contractReason) {
        this.contractReason = contractReason;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getContractStart() {
        return contractStart;
    }

    public void setContractStart(String contractStart) {
        this.contractStart = contractStart;
    }

    public String getContractEnd() {
        return contractEnd;
    }

    public void setContractEnd(String contractEnd) {
        this.contractEnd = contractEnd;
    }

    public String getContractPerson() {
        return contractPerson;
    }

    public void setContractPerson(String contractPerson) {
        this.contractPerson = contractPerson;
    }

    public Date getDeleteDatetime() {
        return deleteDatetime;
    }

    public void setDeleteDatetime(Date deleteDatetime) {
        this.deleteDatetime = deleteDatetime;
    }

    public String getDeleteArray() {
        return deleteArray;
    }

    public void setDeleteArray(String deleteArray) {
        this.deleteArray = deleteArray;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public Integer getCuRow() {
        return cuRow;
    }

    public void setCuRow(Integer cuRow) {
        this.cuRow = cuRow;
    }

    public String getCuSort() {
        return cuSort;
    }

    public void setCuSort(String cuSort) {
        this.cuSort = cuSort;
    }

    public Integer getCuPage() {
        return cuPage;
    }

    public void setCuPage(Integer cuPage) {
        this.cuPage = cuPage;
    }

    public Integer getCuOrder() {
        return cuOrder;
    }

    public void setCuOrder(Integer cuOrder) {
        this.cuOrder = cuOrder;
    }

    public Integer getClRow() {
        return clRow;
    }

    public void setClRow(Integer clRow) {
        this.clRow = clRow;
    }

    public String getClSort() {
        return clSort;
    }

    public void setClSort(String clSort) {
        this.clSort = clSort;
    }

    public Integer getClPage() {
        return clPage;
    }

    public void setClPage(Integer clPage) {
        this.clPage = clPage;
    }

    public Integer getClOrder() {
        return clOrder;
    }

    public void setClOrder(Integer clOrder) {
        this.clOrder = clOrder;
    }

    public String getClStartDate() {
        return clStartDate;
    }

    public void setClStartDate(String clStartDate) {
        this.clStartDate = clStartDate;
    }

    public String getClEndDate() {
        return clEndDate;
    }

    public void setClEndDate(String clEndDate) {
        this.clEndDate = clEndDate;
    }

    public String getClSearchType() {
        return clSearchType;
    }

    public void setClSearchType(String clSearchType) {
        this.clSearchType = clSearchType;
    }

    public String getClSearchWord() {
        return clSearchWord;
    }

    public void setClSearchWord(String clSearchWord) {
        this.clSearchWord = clSearchWord;
    }

    public String getChkValueArr() {
        return chkValueArr;
    }

    public void setChkValueArr(String chkValueArr) {
        this.chkValueArr = chkValueArr;
    }

    public String getComUuid() {
        return comUuid;
    }

    public void setComUuid(String comUuid) {
        this.comUuid = comUuid;
    }

    public String getComPhone() {
        return comPhone;
    }

    public void setComPhone(String comPhone) {
        this.comPhone = comPhone;
    }

    public String getComEmail() {
        return comEmail;
    }

    public void setComEmail(String comEmail) {
        this.comEmail = comEmail;
    }

    public Integer getCountContract() {
        return countContract;
    }

    public void setCountContract(Integer countContract) {
        this.countContract = countContract;
    }
}