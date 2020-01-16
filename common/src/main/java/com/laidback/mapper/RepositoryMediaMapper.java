package com.laidback.mapper;

import com.laidback.model.RepositoryMedia;

import java.util.List;

public interface RepositoryMediaMapper {
    List<RepositoryMedia> search(Integer marketId);
}
