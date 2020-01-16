package com.laidback.model;

import org.springframework.web.multipart.MultipartFile;

import java.util.List;

/**
 * Created by jack on 2018. 7. 13..
 */
public class FileForm {
    private List<MultipartFile> files;

    public List<MultipartFile> getFiles() {
        return files;
    }

    public void setFiles(List<MultipartFile> files) {
        this.files = files;
    }
}
