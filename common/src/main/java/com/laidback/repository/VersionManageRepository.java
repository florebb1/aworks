package com.laidback.repository;

import com.laidback.model.VersionManage;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VersionManageRepository extends JpaRepository<VersionManage,Integer> {
}
