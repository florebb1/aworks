package com.laidback.repository;

import com.laidback.model.RepositoryQna;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RepositoryQnaRepository extends JpaRepository<RepositoryQna,Integer> {
    @Query("select rq from RepositoryQna rq where rq.user = :userSeq")
    List<RepositoryQna> findByUserSeq(@Param(value = "userSeq") Integer userSeq);

}
