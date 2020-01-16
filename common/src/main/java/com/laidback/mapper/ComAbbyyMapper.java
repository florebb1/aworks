package com.laidback.mapper;

import com.laidback.model.ComAbbyy;
import com.laidback.model.ComLicense;

import java.util.List;
import java.util.Map;

public interface ComAbbyyMapper {

    int count(Map<String, Object> params);
    List<ComLicense> find(Map<String, Object> params);

    ComAbbyy findByAbbyyLicense(Integer seq);

    List<ComAbbyy> getExeclDownList(Map<String, Object> params);
}
