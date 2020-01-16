package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "REPOSITORY_LIKE")
public class RepositoryLike {
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

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Repository getRepository() {
        return repository;
    }

    public void setRepository(Repository repository) {
        this.repository = repository;
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
}
