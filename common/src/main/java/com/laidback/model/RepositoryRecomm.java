package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "REPOSITORY_RECOMM")
public class RepositoryRecomm {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @ManyToOne
    @JoinColumn(name = "repository_seq")
    private Repository repository;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime = new Date();

    @Transient
    private String deleteArray;

    @Transient
    private String chkArray;

    @Transient
    private Integer page;

    @Transient
    private Integer row;

    @Transient
    private String sort;

    @Transient
    private Integer order;

    @Transient
    private String startDate;

    @Transient
    private String endDate;

    @Transient
    private String searchType;

    @Transient
    private String searchWord;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
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

    public String getDeleteArray() {
        return deleteArray;
    }

    public void setDeleteArray(String deleteArray) {
        this.deleteArray = deleteArray;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getRow() {
        return row;
    }

    public void setRow(Integer row) {
        this.row = row;
    }

    public String getSort() {
        return sort;
    }

    public void setSort(String sort) {
        this.sort = sort;
    }

    public Integer getOrder() {
        return order;
    }

    public void setOrder(Integer order) {
        this.order = order;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getSearchType() {
        return searchType;
    }

    public void setSearchType(String searchType) {
        this.searchType = searchType;
    }

    public String getSearchWord() {
        return searchWord;
    }

    public void setSearchWord(String searchWord) {
        this.searchWord = searchWord;
    }

    public String getChkArray() {
        return chkArray;
    }

    public void setChkArray(String chkArray) {
        this.chkArray = chkArray;
    }
}
