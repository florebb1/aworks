package com.laidback.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;

// 메인 문의
@Entity
@Table(name = "CONTACTUS")
public class Contactus {
    // 인덱스
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @Column
    private String name;

    @Column
    private String email;

    @Column
    private String comName;

    @Column
    private String comPhone;

    @Column
    @Type(type = "text")
    private String content;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDatetime;

    @Transient
    private String chkValueArr;

    @Transient
    private String deleteArray;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getComName() {
        return comName;
    }

    public void setComName(String comName) {
        this.comName = comName;
    }

    public String getComPhone() {
        return comPhone;
    }

    public void setComPhone(String comPhone) {
        this.comPhone = comPhone;
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

    public String getChkValueArr() {
        return chkValueArr;
    }

    public void setChkValueArr(String chkValueArr) {
        this.chkValueArr = chkValueArr;
    }

    public String getDeleteArray() {
        return deleteArray;
    }

    public void setDeleteArray(String deleteArray) {
        this.deleteArray = deleteArray;
    }

    public Date getDeleteDatetime() {
        return deleteDatetime;
    }

    public void setDeleteDatetime(Date deleteDatetime) {
        this.deleteDatetime = deleteDatetime;
    }
}
