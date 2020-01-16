package com.laidback.mapper;

import com.laidback.model.RepositoryProcess;
import java.util.List;

public interface RepositoryProcessMapper {

    List<RepositoryProcess> findByProcessTypes(Integer seq);
}
