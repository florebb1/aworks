package com.laidback.mapper;

import com.laidback.model.RepositoryReview;

import java.util.List;
import java.util.Map;

public interface RepositoryReviewMapper {
    List<RepositoryReview> find(Map<String,Object> params);
    int count(Integer marketId);
    List<RepositoryReview> search(Map<String, Object> params);

    int countByUser(Map<String, Object> params);

    List<RepositoryReview> findByUser(Map<String, Object> params);
}
