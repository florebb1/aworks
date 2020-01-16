package com.laidback.model;

import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "FAQ")
public class Faq {

    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @Column
    private Integer faqType;

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

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Integer getFaqType() {
        return faqType;
    }

    public void setFaqType(Integer fnqType) {
        this.faqType = fnqType;
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

}
