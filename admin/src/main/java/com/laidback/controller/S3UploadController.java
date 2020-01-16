package com.laidback.controller;

import com.laidback.model.FileForm;
import com.laidback.service.AmazonClient;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@RestController
public class S3UploadController extends RootController {

    private AmazonClient amazonClient;

    @Autowired
    S3UploadController(AmazonClient amazonClient) {
        this.amazonClient = amazonClient;
    }

    @PostMapping("/storage/upload_multi")
    public Object uploadFile(FileForm fileForm) {
        Map<String,Object> resultMap = new HashMap<>();
        List<String> urls = new ArrayList<>();
        for(MultipartFile file : fileForm.getFiles()){
            urls.add(amazonClient.uploadFile(file));
        }
        resultMap.put("url", StringUtils.join(urls,"|"));
        return resultMap;
    }

    @PostMapping("/storage/upload_single")
    public Object uploadFile(@RequestParam("file") MultipartFile file) {
        Map<String,Object> resultMap = new HashMap<>();
        resultMap.put("url",amazonClient.uploadFile(file));
        return resultMap;
    }

    @DeleteMapping("/storage/delete")
    public Object deleteFile(@RequestParam(value = "url") String fileUrl) {
        Map<String,Object> resultMap = new HashMap<>();
        try{
            resultMap.put("result",amazonClient.deleteFileFromS3Bucket(fileUrl));
        }catch (Exception e){
            log.error(e.getMessage(),e);
            resultMap.put("result",false);
        }
        return resultMap;
    }

    // @PostMapping("/storage/baseTest")
    // public Object baseTest(@RequestParam("file_base64[]") List<String> fileBase64,
    //                        @RequestParam("file_type[]") List<String> fileType
    //                             ) {
    //     Map<String,Object> resultMap = new HashMap<>();
    //     try{
    //         resultMap.put("result",true);
    //     }catch (Exception e){
    //         log.error(e.getMessage(),e);
    //         resultMap.put("result",false);
    //     }
    //     return resultMap;
    // }
}
