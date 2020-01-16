package com.laidback.mapper;

import com.laidback.model.Repository;
import com.laidback.model.RepositoryRecomm;

import java.util.List;
import java.util.Map;

public interface RepositoryRecommMapper {
    int count();

    int countByRecomm(Map<String, Object> params);

    List<Repository> findByRecomm(Map<String, Object> params);

    RepositoryRecomm findByRecommInfo(Map<String, Object> params);
}
