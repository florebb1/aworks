package com.laidback.mapper;

import com.laidback.model.BbsFile;

import java.util.List;
import java.util.Map;

public interface BbsFileMapper {
    List<BbsFile> findByFiles(Map<String, Object> params);
    List<BbsFile> noticeByFiles(Integer params);
    int fileCount(Integer params);
    int aafCount();
    List<BbsFile> aaf();
    BbsFile findByFile(Map<String, Object> params);
    List<BbsFile> findByFilesQ(Map<String, Object> params);
    List<BbsFile> findByFilesA(Map<String, Object> params);
}
