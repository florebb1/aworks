package com.laidback.model;

import org.hibernate.annotations.Type;
import org.joda.time.DateTime;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "REPOSITORY")
public class Repository {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

//    @ManyToOne
//    @JoinColumn(name = "user_seq")
//    private User user;

    @Column
    private Integer userSeq;

    @Column
    private String appName;

    @Column
    private String summary;

    @Column
    @Type(type = "text")
    private String Description;

    /*
    0: Process
    1: Task
    2: Event Item
    3: Connector
    */
    @Column
    private Integer appType;

    /*
    0: Finance & Accounting
    1: HR
    2: Sales
    3: Others
    */
//    @Column
//    private Integer processIndustry;

    /*
    0: Adobe
    1: Microsoft
    2: Oracle ERP
    3: SAP
    */
    @Column
    private Integer application;

    @Column
    private String Tags;

    @Column
    @Type(type = "text")
    private String benefit;

    @Column
    private String appDependencies;

    @Column
    private String component;

    @Column
    private String version;

    @Column
    private String versionNote;

    @Column
    private Integer viewCnt;

    // 앱 보안인증 Y/N(Y=1/N=0)
    @Column
    private Integer security;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date lastUpdate;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDatetime;

    @Column
    private Integer status;

    @Column
    private String manualFileUrl;

    @Column
    private String manualFileOriginalName;

    @Column
    private String licenseFileUrl;

    @Column
    private String licenseFileOriginalName;

    @Column
    private String appFileUrl;

    @Column
    private String appFileOriginalName;

    @Column
    private String movieFileUrl;

    @Transient
    private Integer downloadCnt;

    @Transient
    private Integer likeCnt;

    @Transient
    private Integer qnaCnt;

    @Transient
    private Integer review;

    @Transient
    private Float ratingAvg;

    @Transient
    private Integer recomm;

    @Transient
    private String deleteArray;

    @Transient
    private String chkValueArr;

    @Transient
    private String processType;

    @Transient
    private MultipartFile[] appScreen;

    @Transient
    private MultipartFile manual;

    @Transient
    private MultipartFile licenseFile;

    @Transient
    private MultipartFile appFile;

    @Transient
    private String appPlayUrl;


    @Transient
    private String chkArray;

    @Transient
    private Integer recommSeq;

    @Transient
    private String[] imgArrValue;


    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

//    public User getUser() {
//        return user;
//    }
//
//    public void setUser(User user) {
//        this.user = user;
//    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String description) {
        Description = description;
    }

    public Integer getAppType() { return appType; }

    public void setAppType(Integer appType) {
        this.appType = appType;
    }

//    public Integer getProcessIndustry() {
//        return processIndustry;
//    }
//
//    public void setProcessIndustry(Integer processIndustry) {
//        this.processIndustry = processIndustry;
//    }

    public String getTags() {
        return Tags;
    }

    public void setTags(String tags) {
        Tags = tags;
    }

    public String getBenefit() {
        return benefit;
    }

    public void setBenefit(String benefit) {
        this.benefit = benefit;
    }

    public String getAppDependencies() {
        return appDependencies;
    }

    public void setAppDependencies(String appDependencies) {
        this.appDependencies = appDependencies;
    }

    public String getComponent() {
        return component;
    }

    public void setComponent(String component) {
        this.component = component;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getVersionNote() {
        return versionNote;
    }

    public void setVersionNote(String versionNote) {
        this.versionNote = versionNote;
    }

    public Date getLastUpdate() {
        return lastUpdate;
    }

    public void setLastUpdate(Date lastUpdate) {
        this.lastUpdate = lastUpdate;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Integer getApplication() {
        return application;
    }

    public void setApplication(Integer application) {
        this.application = application;
    }

    public Integer getDownloadCnt() {
        return downloadCnt;
    }

    public void setDownloadCnt(Integer downloadCnt) {
        this.downloadCnt = downloadCnt;
    }

    public Integer getLikeCnt() { return likeCnt; }

    public void setLikeCnt(Integer likeCnt) { this.likeCnt = likeCnt; }

    public Float getRatingAvg() { return ratingAvg; }

    public void setRatingAvg(Float ratingAvg) { this.ratingAvg = ratingAvg; }

    public Integer getViewCnt() {
        return viewCnt;
    }

    public void setViewCnt(Integer viewCnt) {
        this.viewCnt = viewCnt;
    }

    public Integer getSecurity() {
        return security;
    }

    public void setSecurity(Integer security) {
        this.security = security;
    }

    public Integer getRecomm() { return recomm; }

    public void setRecomm(Integer recomm) { this.recomm = recomm; }

    public Date getDeleteDatetime() {
        return deleteDatetime;
    }

    public void setDeleteDatetime(Date deleteDatetime) {
        this.deleteDatetime = deleteDatetime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getQnaCnt() {
        return qnaCnt;
    }

    public void setQnaCnt(Integer qnaCnt) {
        this.qnaCnt = qnaCnt;
    }

    public Integer getReview() {
        return review;
    }

    public void setReview(Integer review) {
        this.review = review;
    }

    public String getDeleteArray() {
        return deleteArray;
    }

    public void setDeleteArray(String deleteArray) {
        this.deleteArray = deleteArray;
    }

    public String getProcessType() {
        return processType;
    }

    public void setProcessType(String processType) {
        this.processType = processType;
    }


    public MultipartFile[] getAppScreen() {
        return appScreen;
    }

    public void setAppScreen(MultipartFile[] appScreen) {
        this.appScreen = appScreen;
    }

    public String getAppPlayUrl() {
        return appPlayUrl;
    }

    public void setAppPlayUrl(String appPlayUrl) {
        this.appPlayUrl = appPlayUrl;
    }

    public MultipartFile getManual() {
        return manual;
    }

    public void setManual(MultipartFile manual) {
        this.manual = manual;
    }

    public MultipartFile getLicenseFile() {
        return licenseFile;
    }

    public void setLicenseFile(MultipartFile licenseFile) {
        this.licenseFile = licenseFile;
    }

    public MultipartFile getAppFile() {
        return appFile;
    }

    public void setAppFile(MultipartFile appFile) {
        this.appFile = appFile;
    }




    public String getChkArray() {
        return chkArray;
    }

    public void setChkArray(String chkArray) {
        this.chkArray = chkArray;
    }

    public Integer getRecommSeq() {
        return recommSeq;
    }

    public void setRecommSeq(Integer recommSeq) {
        this.recommSeq = recommSeq;
    }

    public String[] getImgArrValue() {
        return imgArrValue;
    }

    public void setImgArrValue(String[] imgArrValue) {
        this.imgArrValue = imgArrValue;
    }

    public String getManualFileUrl() {
        return manualFileUrl;
    }

    public void setManualFileUrl(String manualFileUrl) {
        this.manualFileUrl = manualFileUrl;
    }

    public String getLicenseFileUrl() {
        return licenseFileUrl;
    }

    public void setLicenseFileUrl(String licenseFileUrl) {
        this.licenseFileUrl = licenseFileUrl;
    }

    public String getAppFileUrl() {
        return appFileUrl;
    }

    public void setAppFileUrl(String appFileUrl) {
        this.appFileUrl = appFileUrl;
    }

    public String getMovieFileUrl() {
        return movieFileUrl;
    }

    public void setMovieFileUrl(String movieFileUrl) {
        this.movieFileUrl = movieFileUrl;
    }

    public String getChkValueArr() {
        return chkValueArr;
    }

    public void setChkValueArr(String chkValueArr) {
        this.chkValueArr = chkValueArr;
    }


    public String getManualFileOriginalName() {
        return manualFileOriginalName;
    }

    public void setManualFileOriginalName(String manualFileOriginalName) {
        this.manualFileOriginalName = manualFileOriginalName;
    }

    public String getLicenseFileOriginalName() {
        return licenseFileOriginalName;
    }

    public void setLicenseFileOriginalName(String licenseFileOriginalName) {
        this.licenseFileOriginalName = licenseFileOriginalName;
    }

    public String getAppFileOriginalName() {
        return appFileOriginalName;
    }

    public void setAppFileOriginalName(String appFileOriginalName) {
        this.appFileOriginalName = appFileOriginalName;
    }

    public Integer getUserSeq() {
        return userSeq;
    }

    public void setUserSeq(Integer userSeq) {
        this.userSeq = userSeq;
    }
}