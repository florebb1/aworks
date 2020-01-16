package com.laidback.mapper;

import com.laidback.model.RepositoryQna;
import com.laidback.model.RepositoryReview;

import java.util.List;
import java.util.Map;

public interface RepositoryQnaMapper {
    List<RepositoryQna> find(Map<String,Object> params);

    int countByUser(Map<String, Object> params);

    List<RepositoryReview> findByUser(Map<String, Object> params);
}
