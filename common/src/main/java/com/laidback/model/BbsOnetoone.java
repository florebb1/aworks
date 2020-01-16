package com.laidback.model;

import org.hibernate.annotations.Type;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "BBS_ONETOONE")
public class BbsOnetoone {

    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @ManyToOne
    @JoinColumn(name = "user_seq")
    private User user;

//    @ManyToOne
//    @JoinColumn(name = "repository_seq")
//    private Repository repository;

    @Column
    private Integer qnaType;

    @Column
    private String title;

    @Column
    @Type(type = "text")
    private String content;

    @Column
    private String answer;

    @Column
    @Type(type = "text")
    private String answerContent;

    @Column
    private Integer answerYn;

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
    private Integer userSeq;

    @Transient
    private Integer repositorySeq;

    @Transient
    private  Integer comSeq;

    @Transient
    private MultipartFile[] file;

    @Transient
    private String deleteArray;

    @Transient
    private String chkValueArr;


    @Transient
    private String userName;

    @Transient
    private String comName;

    @Transient
    private String loginId;

    @Transient
    private List<BbsFile> bbsFilesQ;

    @Transient
    private List<BbsFile> bbsFilesA;



    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getAnswerYn() {
        return answerYn;
    }

    public void setAnswerYn(Integer answerYn) {
        this.answerYn = answerYn;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Integer getQnaType() {
        return qnaType;
    }

    public void setQnaType(Integer qnaType) {
        this.qnaType = qnaType;
    }

//    public Repository getRepository() {
//        return repository;
//    }
//
//    public void setRepository(Repository repository) {
//        this.repository = repository;
//    }

    public Integer getUserSeq() {
        return userSeq;
    }

    public void setUserSeq(Integer userSeq) {
        this.userSeq = userSeq;
    }

    public Integer getRepositorySeq() {
        return repositorySeq;
    }

    public void setRepositorySeq(Integer repositorySeq) {
        this.repositorySeq = repositorySeq;
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

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getAnswerContent() {
        return answerContent;
    }

    public void setAnswerContent(String answerContent) {
        this.answerContent = answerContent;
    }

    public Integer getComSeq() {
        return comSeq;
    }

    public void setComSeq(Integer comSeq) {
        this.comSeq = comSeq;
    }

    public MultipartFile[] getFile() {
        return file;
    }

    public void setFile(MultipartFile[] file) {
        this.file = file;
    }

    public String getDeleteArray() {
        return deleteArray;
    }

    public void setDeleteArray(String deleteArray) {
        this.deleteArray = deleteArray;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    public String getChkValueArr() {
        return chkValueArr;
    }

    public void setChkValueArr(String chkValueArr) {
        this.chkValueArr = chkValueArr;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public List<BbsFile> getBbsFilesQ() {
        return bbsFilesQ;
    }

    public void setBbsFilesQ(List<BbsFile> bbsFilesQ) {
        this.bbsFilesQ = bbsFilesQ;
    }

    public List<BbsFile> getBbsFilesA() {
        return bbsFilesA;
    }

    public void setBbsFilesA(List<BbsFile> bbsFilesA) {
        this.bbsFilesA = bbsFilesA;
    }
}
