package com.laidback.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "RELEASE_NOTE")
public class ReleaseNote {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @Column
    private Integer noteType;

    @Column
    private String title;

    @Column
    @Type(type = "text")
    private String content;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime;
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateDatetime;
    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDatetime;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Integer getNoteType() {
        return noteType;
    }

    public void setNoteType(Integer noteType) {
        this.noteType = noteType;
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
}
