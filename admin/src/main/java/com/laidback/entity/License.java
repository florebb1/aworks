package com.laidback.entity;

public class License {
    /**
     * 라이선스 발급 종류
     * 현재는 Organization 고정
     */
    private String type;
    /**
     * tariff 과금방식
     * Hour , Month , Annual
     */
    private String tariff;
    /**
     * licenseKey
     * UUID형식의 Portal 에서 생성
     */
    private String licenseKey;
    /**
     * subscriptor
     * W/C에서 첨부한 파일에 있는 Organization UUID
     */
    private String subscriptor;
    /**
     * name
     * 라이선스 이름
     */
    private String name;
    /**
     * issuedDatetime
     * 등록일 timestamp
     */
    private Long issuedDatetime;
    /**
     * licenseStartedDatetime
     * 라이선스 시작 timestamp
     */
    private Long licenseStartedDatetime;
    /**
     * licenseFinishedDatetime
     * 라이선스 종료 timestamp
     */
    private Long licenseFinishedDatetime;
    /**
     * countUnattended
     * Unattended 사용 개수
     */
    private Integer countUnattended;
    /**
     * countAttended
     * attended 사용 개수
     */
    private Integer countAttended;
    /**
     * countStudio
     * Studio 사용 개수
     */
    private Integer countStudio;
    /**
     * priceUnattended
     * Unattanded 금액
     */
    private Long priceUnattended;
    /**
     * priceAttended
     * Attended 금액
     */
    private Long priceAttended;
    /**
     * priceStudio
     * Studio 금액
     */
    private Long priceStudio;
    /**
     * issueType
     * 발급 종류
     * 1 : 신규
     * 2 : 기간갱신
     * 3 : 기간+수량갱신
     */
    private Integer issueType;

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTariff() {
        return tariff;
    }

    public void setTariff(String tariff) {
        this.tariff = tariff;
    }

    public String getLicenseKey() {
        return licenseKey;
    }

    public void setLicenseKey(String licenseKey) {
        this.licenseKey = licenseKey;
    }

    public String getSubscriptor() {
        return subscriptor;
    }

    public void setSubscriptor(String subscriptor) {
        this.subscriptor = subscriptor;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getIssuedDatetime() {
        return issuedDatetime;
    }

    public void setIssuedDatetime(Long issuedDatetime) {
        this.issuedDatetime = issuedDatetime;
    }

    public Long getLicenseStartedDatetime() {
        return licenseStartedDatetime;
    }

    public void setLicenseStartedDatetime(Long licenseStartedDatetime) {
        this.licenseStartedDatetime = licenseStartedDatetime;
    }

    public Long getLicenseFinishedDatetime() {
        return licenseFinishedDatetime;
    }

    public void setLicenseFinishedDatetime(Long licenseFinishedDatetime) {
        this.licenseFinishedDatetime = licenseFinishedDatetime;
    }

    public Integer getCountUnattended() {
        return countUnattended;
    }

    public void setCountUnattended(Integer countUnattended) {
        this.countUnattended = countUnattended;
    }

    public Integer getCountAttended() {
        return countAttended;
    }

    public void setCountAttended(Integer countAttended) {
        this.countAttended = countAttended;
    }

    public Integer getCountStudio() {
        return countStudio;
    }

    public void setCountStudio(Integer countStudio) {
        this.countStudio = countStudio;
    }

    public Long getPriceUnattended() {
        return priceUnattended;
    }

    public void setPriceUnattended(Long priceUnattended) {
        this.priceUnattended = priceUnattended;
    }

    public Long getPriceAttended() {
        return priceAttended;
    }

    public void setPriceAttended(Long priceAttended) {
        this.priceAttended = priceAttended;
    }

    public Long getPriceStudio() {
        return priceStudio;
    }

    public void setPriceStudio(Long priceStudio) {
        this.priceStudio = priceStudio;
    }

    public Integer getIssueType() {
        return issueType;
    }

    public void setIssueType(Integer issueType) {
        this.issueType = issueType;
    }
}
