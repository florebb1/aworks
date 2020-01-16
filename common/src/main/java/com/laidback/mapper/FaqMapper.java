package com.laidback.mapper;

import com.laidback.model.Faq;

import java.util.List;
import java.util.Map;

public interface FaqMapper {
    List<Faq> find(Map<String, Object> filter);
    int count(Map<String, Object> filter);
}
