package com.laidback.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

@Entity
@Table(name = "REPOSITORY_QNA")
public class RepositoryQna {

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
    private String title;

    @Column
    @Type(type = "text")
    private String content;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime = new Date();

    @Transient
    private Integer userSeq;

    @Transient
    private String appName;

    @Transient
    private Integer repositorySeq;

    @Transient
    private List<RepositoryQnaAnswer> repositoryQnaAnswer;

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

    public List<RepositoryQnaAnswer> getRepositoryQnaAnswer() {
        return repositoryQnaAnswer;
    }

    public void setRepositoryQnaAnswer(List<RepositoryQnaAnswer> repositoryQnaAnswer) {
        this.repositoryQnaAnswer = repositoryQnaAnswer;
    }

    public String getAppName() {
        return appName;
    }

    public void setAppName(String appName) {
        this.appName = appName;
    }
}
