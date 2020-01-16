package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

// 1:1문의 분류
@Entity
@Table(name = "DIV_ONE")
public class DivOne {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @Column
    private String divName;

    @Column
    private String chargerName;

    @Column
    private String chargerPart;

    @Column
    private String chargerPosition;

    @Column
    private String chargerEmail;

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

    public String getDivName() {
        return divName;
    }

    public void setDivName(String divName) {
        this.divName = divName;
    }

    public String getChargerName() {
        return chargerName;
    }

    public void setChargerName(String chargerName) {
        this.chargerName = chargerName;
    }

    public String getChargerPart() {
        return chargerPart;
    }

    public void setChargerPart(String chargerPart) {
        this.chargerPart = chargerPart;
    }

    public String getChargerEmail() {
        return chargerEmail;
    }

    public void setChargerEmail(String chargerEmail) {
        this.chargerEmail = chargerEmail;
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

    public String getChargerPosition() {
        return chargerPosition;
    }

    public void setChargerPosition(String chargerPosition) {
        this.chargerPosition = chargerPosition;
    }
}
