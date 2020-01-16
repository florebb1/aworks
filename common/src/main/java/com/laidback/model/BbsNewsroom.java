package com.laidback.model;

import org.hibernate.annotations.Type;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "BBS_NEWSROOM")
public class BbsNewsroom {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @Column
    private String title;

    @Column
    private String subTitle;

    @Column
    @Type(type = "text")
    private String content;

    @Column
    private Integer viewCnt;

    @Column
    private String writer;

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
    private MultipartFile file;

    @Transient
    private String deleteArray;

    @Transient
    private String chkValueArr;


    @Transient
    private String contentNote;

    @Transient
    private Integer pre;

    @Transient
    private String preTitle;

    @Transient
    private Integer nex;

    @Transient
    private String nexTitle;

    @Transient
    private String listFile;

    // 기사 등록일
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date viewDatetime;

    @Transient
    private String viewDatetimeStr;

    @Column
    private Integer displayYn;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
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

    public Integer getViewCnt() {
        return viewCnt;
    }

    public void setViewCnt(Integer viewCnt) {
        this.viewCnt = viewCnt;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
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

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }

    public String getDeleteArray() {
        return deleteArray;
    }

    public void setDeleteArray(String deleteArray) {
        this.deleteArray = deleteArray;
    }

    public String getChkValueArr() {
        return chkValueArr;
    }

    public void setChkValueArr(String chkValueArr) {
        this.chkValueArr = chkValueArr;
    }

    public String getContentNote() {
        return contentNote;
    }

    public void setContentNote(String contentNote) {
        this.contentNote = contentNote;
    }

    public Integer getPre() {
        return pre;
    }

    public void setPre(Integer pre) {
        this.pre = pre;
    }

    public String getPreTitle() {
        return preTitle;
    }

    public void setPreTitle(String preTitle) {
        this.preTitle = preTitle;
    }

    public Integer getNex() {
        return nex;
    }

    public void setNex(Integer nex) {
        this.nex = nex;
    }

    public String getNexTitle() {
        return nexTitle;
    }

    public void setNexTitle(String nexTitle) {
        this.nexTitle = nexTitle;
    }

    public String getListFile() {
        return listFile;
    }

    public void setListFile(String listFile) {
        this.listFile = listFile;
    }

    public String getSubTitle() {
        return subTitle;
    }

    public void setSubTitle(String subTitle) {
        this.subTitle = subTitle;
    }

    public Date getViewDatetime() {
        return viewDatetime;
    }

    public void setViewDatetime(Date viewDatetime) {
        this.viewDatetime = viewDatetime;
    }

    public String getViewDatetimeStr() {
        return viewDatetimeStr;
    }

    public void setViewDatetimeStr(String viewDatetimeStr) {
        this.viewDatetimeStr = viewDatetimeStr;
    }

    public Integer getDisplayYn() {
        return displayYn;
    }

    public void setDisplayYn(Integer displayYn) {
        this.displayYn = displayYn;
    }
}
