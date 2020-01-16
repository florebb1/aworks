package com.laidback.controller;

import com.laidback.mapper.VersionManageMapper;
import com.laidback.model.VersionManage;
import com.laidback.repository.VersionManageRepository;
import com.laidback.response.ResponseService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.xml.ws.Response;
import java.util.HashMap;
import java.util.Map;

@RestController
public class ApiController {
    @Autowired
    VersionManageMapper versionManageMapper;

    @Autowired
    VersionManageRepository versionManageRepository;

    @Autowired
    protected ResponseService responseService;

    @GetMapping(value = "/api/version_launcher")
    public Object launcherVersion(){
        Map<String,Object> result = new HashMap<>();

        VersionManage versionManage = versionManageMapper.getLast(0);


        return responseService.getSingleResult(versionManage);

    }

    @GetMapping(value = "/api/version_studio")
    public Object studioVersion(){
        Map<String,Object> result = new HashMap<>();

        VersionManage versionManage = versionManageMapper.getLast(1);


        return responseService.getSingleResult(versionManage);
    }
}
