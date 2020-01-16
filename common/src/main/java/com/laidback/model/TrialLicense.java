package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "TRIAL_LICENSE")
public class TrialLicense {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date startDate = new Date();

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date endDate = new Date();

    @ManyToOne
    @JoinColumn(name = "trial_seq")
    private TrialUser trialSeq;

    @Column
    private Integer status;

    @Column
    private Integer extension;

    @Column
    private String licenseKey;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public TrialUser getTrialSeq() {
        return trialSeq;
    }

    public void setTrialSeq(TrialUser trialSeq) {
        this.trialSeq = trialSeq;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getExtension() {
        return extension;
    }

    public void setExtension(Integer extension) {
        this.extension = extension;
    }

    public String getLicenseKey() {
        return licenseKey;
    }

    public void setLicenseKey(String licenseKey) {
        this.licenseKey = licenseKey;
    }
}
