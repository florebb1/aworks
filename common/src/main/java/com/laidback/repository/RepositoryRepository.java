package com.laidback.repository;

import com.laidback.model.Repository;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RepositoryRepository extends JpaRepository<Repository,Integer> {
}
