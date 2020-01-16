package com.laidback.mapper;

import com.laidback.model.BbsFile;
import com.laidback.model.BbsOnetoone;

import java.util.List;
import java.util.Map;

public interface BbsOnetooneMapper {
    int count(Map<String,Object> params);
    List<BbsOnetoone> find(Map<String,Object> params);

    BbsOnetoone findByOnetoone(Map<String, Object> params);
    int onetooneByCount(Map<String, Object> params);
    List<BbsOnetoone> repoByOnetoone(Map<String, Object> params);
    List<BbsOnetoone> findByMain();
    List<BbsOnetoone> getExeclDownList(Map<String, Object> params);
}
