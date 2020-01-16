package com.laidback.mapper;

import com.laidback.model.ReleaseNote;

import java.util.List;
import java.util.Map;

public interface ReleaseNoteMapper {
    int count(Map<String,Object> params);
    List<ReleaseNote> find(Map<String,Object> params);
    List<ReleaseNote> typeFind(Integer noteType);
}
