package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "REPOSITORY_DOWNLOAD")
public class RepositoryDownload {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @ManyToOne
    @JoinColumn(name = "repository_seq")
    private Repository repository;

    @ManyToOne
    @JoinColumn(name = "user_seq")
    private User user;


    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime = new Date();

    @Transient
    private Integer userSeq;

    @Transient
    private Integer repositorySeq;

    @Transient
    private String appName;

    @Transient
    private Integer appType;

    @Transient
    private String description;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDatetime;

    @Transient
    private Integer status;

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

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) { this.appName = appName; }

    public Integer getAppType() {
        return appType;
    }

    public void setAppType(Integer appType) {
        this.appType = appType;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

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
}