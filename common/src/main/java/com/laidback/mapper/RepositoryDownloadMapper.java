package com.laidback.mapper;

import com.laidback.model.RepositoryDownload;

import java.util.List;
import java.util.Map;

public interface RepositoryDownloadMapper {
    RepositoryDownload getDuple(Map<String,Object> params);
    int count(Map<String,Object> params);
    List<RepositoryDownload> find(Map<String,Object> params);
    int appDown(Map<String, Object> params);
    List<RepositoryDownload> findByDownload(Map<String, Object> params);

    int countByUser(Map<String, Object> params);
    List<RepositoryDownload> findByUser(Map<String, Object> params);
}
