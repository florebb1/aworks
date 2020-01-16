package com.laidback.mapper;

import com.laidback.model.DivOne;

import java.util.List;
import java.util.Map;

public interface DivOneMapper {
    int count(Map<String,Object> params);
    List<DivOne> find(Map<String,Object> params);
    List<DivOne> sendFind(Map<String,Object> params);
}
