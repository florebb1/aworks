package com.laidback.model;

import javax.persistence.*;

@Entity
@Table(name = "REPOSITORY_PROCESS")
public class RepositoryProcess {

    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @ManyToOne
    @JoinColumn(name = "repository_seq")
    private Repository repository;

    // 0:Finance&Accounting
    // 1:HR
    // 2:Sales
    // 3:Others
    @Column
    private Integer processType;



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

    public Integer getProcessType() {
        return processType;
    }

    public void setProcessType(Integer processType) {
        this.processType = processType;
    }
}
