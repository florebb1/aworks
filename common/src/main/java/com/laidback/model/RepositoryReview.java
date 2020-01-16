package com.laidback.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "REPOSITORY_REVIEW")
public class RepositoryReview {
    // 키값
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    // portal 로그인 회원키
    @ManyToOne
    @JoinColumn(name = "user_seq")
    private User user;

    @ManyToOne
    @JoinColumn(name = "repository_seq")
    private Repository repository;

    @Column
    @Type(type = "text")
    private String content;

    @Column
    @Temporal(TemporalType.TIMESTAMP)

    @Transient
    private Integer userSeq;

    @Transient
    private Integer repositorySeq;

    @Transient
    private String name;

    @Transient
    private String appName;

    @Transient
    private String loginId;

    @Transient
    private String profileImg;

    @Transient
    private String position;

    private Date createDatetime = new Date();

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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Repository getRepository() {
        return repository;
    }

    public void setRepository(Repository repository) {
        this.repository = repository;
    }

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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLoginId() {
        return loginId;
    }

    public void setLoginId(String loginId) {
        this.loginId = loginId;
    }

    public String getProfileImg() {
        return profileImg;
    }

    public void setProfileImg(String profileImg) {
        this.profileImg = profileImg;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }
}
