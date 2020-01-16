package com.laidback.mapper;


import com.laidback.model.Contactus;

import java.util.List;
import java.util.Map;

public interface ContactusMapper {
    int count(Map<String, Object> params);
    List<Contactus> find(Map<String, Object> params);
    Contactus findByContactus(Map<String, Object> params);

    List<Contactus> getExeclDownList(Map<String, Object> params);
}
