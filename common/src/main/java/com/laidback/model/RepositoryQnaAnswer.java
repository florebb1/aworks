package com.laidback.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "REPOSITORY_QNA_ANSWER")
public class RepositoryQnaAnswer {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @ManyToOne
    @JoinColumn(name = "repository_qna_seq")
    private RepositoryQna repositoryQna;

    @ManyToOne
    @JoinColumn(name = "user_seq")
    private User user;

    @Column
    private Integer crSeq;

    @Column
    @Type(type = "text")
    private String content;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime = new Date();

    @Transient
    private Integer repositoryQnaSeq;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public RepositoryQna getRepositoryQna() {
        return repositoryQna;
    }

    public void setRepositoryQna(RepositoryQna repositoryQna) {
        this.repositoryQna = repositoryQna;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Integer getCrSeq() {
        return crSeq;
    }

    public void setCrSeq(Integer crSeq) {
        this.crSeq = crSeq;
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

    public Integer getRepositoryQnaSeq() {
        return repositoryQnaSeq;
    }

    public void setRepositoryQnaSeq(Integer repositoryQnaSeq) {
        this.repositoryQnaSeq = repositoryQnaSeq;
    }
}
