package com.laidback.repository;

import com.laidback.model.RepositoryDownload;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RepositoryDownloadRepository extends JpaRepository<RepositoryDownload,Integer> {
    @Query("select rd from RepositoryDownload rd where rd.user = :userSeq")
    List<RepositoryDownload> findByUserSeq(@Param(value = "userSeq") Integer userSeq);
}
