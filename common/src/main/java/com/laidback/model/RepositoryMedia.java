package com.laidback.model;

import javax.persistence.*;

@Entity
@Table(name = "REPOSITORY_MEDIA")
public class RepositoryMedia {
    @Id
    @GeneratedValue
    @Column(columnDefinition = "serial")
    private Integer seq;

    @ManyToOne
    @JoinColumn(name = "repository_seq")
    private Repository repository;

    /*
    0 : 사진
    1 : 동영상
    2 : 파일
     */
    @Column
    private Integer mediaType;

    @Column
    private String mediaValue;

    public Integer getSeq() {
        return seq;
    }

    public void setSeq(Integer seq) {
        this.seq = seq;
    }

    public Repository getRepository() {
        return repository;
    }

    public void setRepository(Repository repository) {
        this.repository = repository;
    }

    public Integer getMediaType() {
        return mediaType;
    }

    public void setMediaType(Integer mediaType) {
        this.mediaType = mediaType;
    }

    public String getMediaValue() {
        return mediaValue;
    }

    public void setMediaValue(String mediaValue) {
        this.mediaValue = mediaValue;
    }
}
