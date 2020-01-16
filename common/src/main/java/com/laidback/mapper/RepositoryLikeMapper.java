package com.laidback.mapper;

import com.laidback.model.RepositoryLike;

import java.util.Map;

public interface RepositoryLikeMapper {
    RepositoryLike getDuple(Map<String,Object> params);
    int find(Map<String, Object> params);
    int count(Map<String, Object> params);
}
