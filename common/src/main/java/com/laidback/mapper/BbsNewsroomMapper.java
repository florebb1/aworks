package com.laidback.mapper;

import com.laidback.model.BbsNewsroom;

import java.util.List;
import java.util.Map;

public interface BbsNewsroomMapper {
    int count(Map<String,Object> params);
    List<BbsNewsroom> find(Map<String,Object> params);
    BbsNewsroom findByNewsroom(Map<String, Object> params);
    BbsNewsroom detail(Integer newsroomId);

    List<BbsNewsroom> getExeclDownList(Map<String, Object> params);
}
