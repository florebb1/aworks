package com.laidback.model;


import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.Collection;
import java.util.Date;
import java.util.HashSet;

@Entity
@Table(name = "MEMBER")
public class User{
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @Column
    private Integer comSeq;

    @Column
    private String loginId;

    @Column
    private String loginPw;

    @Column
    private String name;

    @Column
    private String phone;

    @Column
    private String comName;

    @Column
    private String position;

    @Column
    private String profileImg;

    @Column
    private Integer level;

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
    private MultipartFile profileImgFile;

    @Transient
    private String deleteArray;

    @Transient
    private String chkValueArr;


    @Transient
    private Integer rvRow;

    @Transient
    private String rvSort;

    @Transient
    private Integer rvPage;

    @Transient
    private Integer rvOrder;


    @Transient
    private Integer qnaRow;

    @Transient
    private String qnaSort;

    @Transient
    private Integer qnaPage;

    @Transient
    private Integer qnaOrder;


    @Transient
    private Integer dlRow;

    @Transient
    private String dlSort;

    @Transient
    private Integer dlPage;

    @Transient
    private Integer dlOrder;


    @Transient
    private Integer trialUserCnt;

    @Transient
    private Integer userCnt;

    @Transient
    private Integer contractUserCnt;

    @Column
    private Integer downloadYn;



    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getLoginPw() {
        return loginPw;
    }

    public void setLoginPw(String loginPw) {
        this.loginPw = loginPw;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getProfileImg() {
        return profileImg;
    }

    public void setProfileImg(String profileImg) {
        this.profileImg = profileImg;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public MultipartFile getProfileImgFile() {
        return profileImgFile;
    }

    public void setProfileImgFile(MultipartFile profileImgFile) {
        this.profileImgFile = profileImgFile;
    }

    public Integer getComSeq() {
        return comSeq;
    }

    public void setComSeq(Integer comSeq) {
        this.comSeq = comSeq;
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

    public String getDeleteArray() {
        return deleteArray;
    }

    public void setDeleteArray(String deleteArray) {
        this.deleteArray = deleteArray;
    }

    public Integer getRvRow() {
        return rvRow;
    }

    public void setRvRow(Integer rvRow) {
        this.rvRow = rvRow;
    }

    public String getRvSort() {
        return rvSort;
    }

    public void setRvSort(String rvSort) {
        this.rvSort = rvSort;
    }

    public Integer getRvPage() {
        return rvPage;
    }

    public void setRvPage(Integer rvPage) {
        this.rvPage = rvPage;
    }

    public Integer getRvOrder() {
        return rvOrder;
    }

    public void setRvOrder(Integer rvOrder) {
        this.rvOrder = rvOrder;
    }

    public Integer getQnaRow() {
        return qnaRow;
    }

    public void setQnaRow(Integer qnaRow) {
        this.qnaRow = qnaRow;
    }

    public String getQnaSort() {
        return qnaSort;
    }

    public void setQnaSort(String qnaSort) {
        this.qnaSort = qnaSort;
    }

    public Integer getQnaPage() {
        return qnaPage;
    }

    public void setQnaPage(Integer qnaPage) {
        this.qnaPage = qnaPage;
    }

    public Integer getQnaOrder() {
        return qnaOrder;
    }

    public void setQnaOrder(Integer qnaOrder) {
        this.qnaOrder = qnaOrder;
    }

    public Integer getDlRow() {
        return dlRow;
    }

    public void setDlRow(Integer dlRow) {
        this.dlRow = dlRow;
    }

    public String getDlSort() {
        return dlSort;
    }

    public void setDlSort(String dlSort) {
        this.dlSort = dlSort;
    }

    public Integer getDlPage() {
        return dlPage;
    }

    public void setDlPage(Integer dlPage) {
        this.dlPage = dlPage;
    }

    public Integer getDlOrder() {
        return dlOrder;
    }

    public void setDlOrder(Integer dlOrder) {
        this.dlOrder = dlOrder;
    }

    public Integer getTrialUserCnt() {
        return trialUserCnt;
    }

    public void setTrialUserCnt(Integer trialUserCnt) {
        this.trialUserCnt = trialUserCnt;
    }

    public Integer getUserCnt() {
        return userCnt;
    }

    public void setUserCnt(Integer userCnt) {
        this.userCnt = userCnt;
    }

    public Integer getContractUserCnt() {
        return contractUserCnt;
    }

    public void setContractUserCnt(Integer contractUserCnt) {
        this.contractUserCnt = contractUserCnt;
    }

    public String getChkValueArr() {
        return chkValueArr;
    }

    public void setChkValueArr(String chkValueArr) {
        this.chkValueArr = chkValueArr;
    }

    public Integer getDownloadYn() {
        return downloadYn;
    }

    public void setDownloadYn(Integer downloadYn) {
        this.downloadYn = downloadYn;
    }
}
