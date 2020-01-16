package com.laidback.mapper;

import com.laidback.model.Partner;

import java.util.List;
import java.util.Map;

public interface PartnerMapper {
    int count(Map<String,Object> params);
    List<Partner> find(Map<String,Object> params);

    Partner findByPartner(Map<String, Object> params);

    List<Partner> getExeclDownList(Map<String, Object> params);
}
