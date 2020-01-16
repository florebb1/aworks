package com.laidback.mapper;

import com.laidback.model.RepositoryRating;

import java.util.Map;

public interface RepositoryRatingMapper {
    RepositoryRating getDuple(Map<String,Object> params);
    int count(Map<String, Object> params);
    int findBySeq(Map<String, Object> params);
    Double findByRating(Map<String, Object> params);
}
