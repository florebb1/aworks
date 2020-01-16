package com.laidback.mapper;

import com.laidback.model.ComLicense;
import com.laidback.model.TrialUser;

import java.util.List;
import java.util.Map;

public interface TrialUserMapper {
    int find(String email);
    int count(String email);

    int countBySuper(Map<String, Object> params);

    List<TrialUser> findBySuper(Map<String, Object> params);

    List<TrialUser> getExeclDownList(Map<String, Object> params);
}
