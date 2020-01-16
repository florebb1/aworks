package com.laidback.mapper;

import com.laidback.model.Repository;

import java.util.List;
import java.util.Map;

public interface RepositoryMapper {
    int count(Map<String,Object> params);
    List<Repository> find(Map<String,Object> params);
    List<Repository> selectPopular();
    List<Repository> selectUpdate();
    Repository getRepository(Integer seq);
    List<Repository> selectRecommAdmin();
    List<Repository> selectRecomm();

    Repository findByRepository(Map<String, Object> params);

    List<Repository> findBySuper(Map<String, Object> params);

    int countBySuper(Map<String, Object> params);

    int countBySuperActivate(Map<String, Object> params);

    List<Repository> findBySuperActivate(Map<String, Object> params);

    List<Repository> getExeclDownList(Map<String, Object> params);
}
