package com.laidback.repository;

import com.laidback.model.BbsNotice;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BbsNoticeRepository extends JpaRepository<BbsNotice,Integer> {
}
