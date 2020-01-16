package com.laidback.mapper;

import com.laidback.model.BbsNotice;

import java.util.List;
import java.util.Map;

public interface BbsNoticeMapper {
    int count(Map<String,Object> params);
    List<BbsNotice> find(Map<String,Object> params);
    BbsNotice findByNotice(Map<String, Object> params);
    void saveForNotice(BbsNotice notice);
    BbsNotice detail(Integer noticeId);

    List<BbsNotice> getExeclDownList(Map<String, Object> params);
}
