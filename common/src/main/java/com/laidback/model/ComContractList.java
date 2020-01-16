package com.laidback.model;

import javax.persistence.*;

@Entity
@Table(name = "COM_CONTRACT_LIST")
public class ComContractList {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @ManyToOne
    @JoinColumn(name = "com_contract_seq")
    private ComContract comContract;

    // 라이선스 종류
    @Column
    private Integer licenseType;

    // 계약 과금 종류
    @Column
    private Integer subscribeType;

    // 납품금액
    @Column
    private Integer licensePrice;

    // list price
    @Column
    private Integer licenseListPrice;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public ComContract getComContract() {
        return comContract;
    }

    public void setComContract(ComContract comContract) {
        this.comContract = comContract;
    }

    public Integer getLicenseType() {
        return licenseType;
    }

    public void setLicenseType(Integer licenseType) {
        this.licenseType = licenseType;
    }

    public Integer getSubscribeType() {
        return subscribeType;
    }

    public void setSubscribeType(Integer subscribeType) {
        this.subscribeType = subscribeType;
    }

    public Integer getLicensePrice() {
        return licensePrice;
    }

    public void setLicensePrice(Integer licensePrice) {
        this.licensePrice = licensePrice;
    }

    public Integer getLicenseListPrice() {
        return licenseListPrice;
    }

    public void setLicenseListPrice(Integer licenseListPrice) {
        this.licenseListPrice = licenseListPrice;
    }
}
