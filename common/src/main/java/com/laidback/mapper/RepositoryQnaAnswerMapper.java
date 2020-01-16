package com.laidback.mapper;

import com.laidback.model.RepositoryQnaAnswer;

import java.util.List;
import java.util.Map;

public interface RepositoryQnaAnswerMapper {
    List<RepositoryQnaAnswer> find(Integer repositoryQnaSeq);
}
