package com.laidback.mapper;

import com.laidback.model.VersionManage;


import java.util.List;
import java.util.Map;

public interface VersionManageMapper {
    int count(Map<String,Object> params);
    List<VersionManage> find(Map<String,Object> params);
    VersionManage getLast(Integer versionType);
    VersionManage get32(Map<String, Object> i);
    VersionManage get64(Map<String, Object> i);
    int get32Count(Map<String, Object> i);
    int get64Count(Map<String, Object> i);
    VersionManage getStudio32();
    VersionManage getMini32();
    VersionManage getStudio64();
    VersionManage getMini64();

    VersionManage getLinux();
    VersionManage getWindows();
}
