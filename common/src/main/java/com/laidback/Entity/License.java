package com.laidback.Entity;

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
    private String issuedDatetime;
    /**
     * licenseStartedDatetime
     * 라이선스 시작 timestamp
     */
    private String licenseStartedDatetime;
    /**
     * licenseFinishedDatetime
     * 라이선스 종료 timestamp
     */
    private String licenseFinishedDatetime;
    /**
     * countUnattended
     * Unattended 사용 개수
     */
    private String countUnattended;
    /**
     * countAttended
     * attended 사용 개수
     */
    private String countAttended;
    /**
     * countStudio
     * Studio 사용 개수
     */
    private String countStudio;
    /**
     * priceUnattended
     * Unattanded 금액
     */
    private String priceUnattended;
    /**
     * priceAttended
     * Attended 금액
     */
    private String priceAttended;
    /**
     * priceStudio
     * Studio 금액
     */
    private String priceStudio;
    /**
     * issueType
     * 발급 종류
     * 1 : 신규
     * 2 : 기간갱신
     * 3 : 기간+수량갱신
     */
    private String issueType;

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

    public String getIssuedDatetime() {
        return issuedDatetime;
    }

    public void setIssuedDatetime(String issuedDatetime) {
        this.issuedDatetime = issuedDatetime;
    }

    public String getLicenseStartedDatetime() {
        return licenseStartedDatetime;
    }

    public void setLicenseStartedDatetime(String licenseStartedDatetime) {
        this.licenseStartedDatetime = licenseStartedDatetime;
    }

    public String getLicenseFinishedDatetime() {
        return licenseFinishedDatetime;
    }

    public void setLicenseFinishedDatetime(String licenseFinishedDatetime) {
        this.licenseFinishedDatetime = licenseFinishedDatetime;
    }

    public String getCountUnattended() {
        return countUnattended;
    }

    public void setCountUnattended(String countUnattended) {
        this.countUnattended = countUnattended;
    }

    public String getCountAttended() {
        return countAttended;
    }

    public void setCountAttended(String countAttended) {
        this.countAttended = countAttended;
    }

    public String getCountStudio() {
        return countStudio;
    }

    public void setCountStudio(String countStudio) {
        this.countStudio = countStudio;
    }

    public String getPriceUnattended() {
        return priceUnattended;
    }

    public void setPriceUnattended(String priceUnattended) {
        this.priceUnattended = priceUnattended;
    }

    public String getPriceAttended() {
        return priceAttended;
    }

    public void setPriceAttended(String priceAttended) {
        this.priceAttended = priceAttended;
    }

    public String getPriceStudio() {
        return priceStudio;
    }

    public void setPriceStudio(String priceStudio) {
        this.priceStudio = priceStudio;
    }

    public String getIssueType() {
        return issueType;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }
}
