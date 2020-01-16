package com.laidback.model;

import javax.persistence.*;
import java.util.Date;

@Entity
@Table(name = "BBS_FILE")
public class BbsFile {
    @Id
    @GeneratedValue
    @Column
    private Integer seq;

    @Column
    private Integer bbsSeq;

    @Column
    private String bbsCode;

    @Column
    private String fileName;

    @Column
    private String originalFileName;

    // 0:질문자등록/1:답변자등록
    @Column
    private Integer fileType;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDatetime;

    @Column
    @Temporal(TemporalType.TIMESTAMP)
    private Date deleteDatetime;



    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Integer getBbsSeq() {
        return bbsSeq;
    }

    public void setBbsSeq(Integer bbsSeq) {
        this.bbsSeq = bbsSeq;
    }

    public String getBbsCode() {
        return bbsCode;
    }

    public void setBbsCode(String bbsCode) {
        this.bbsCode = bbsCode;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public Date getCreateDatetime() {
        return createDatetime;
    }

    public void setCreateDatetime(Date createDatetime) {
        this.createDatetime = createDatetime;
    }

    public Date getDeleteDatetime() {
        return deleteDatetime;
    }

    public void setDeleteDatetime(Date deleteDatetime) {
        this.deleteDatetime = deleteDatetime;
    }

    public Integer getFileType() {
        return fileType;
    }

    public void setFileType(Integer fileType) {
        this.fileType = fileType;
    }


    public String getOriginalFileName() {
        return originalFileName;
    }

    public void setOriginalFileName(String originalFileName) {
        this.originalFileName = originalFileName;
    }

}
