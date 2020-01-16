package com.laidback.repository;

import com.laidback.model.RepositoryReview;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface RepositoryReviewRepository extends JpaRepository<RepositoryReview,Integer> {
    @Query("select rr from RepositoryReview rr where rr.user = :userSeq")
    List<RepositoryReview> findByUserSeq(@Param(value = "userSeq") Integer userSeq);
}
