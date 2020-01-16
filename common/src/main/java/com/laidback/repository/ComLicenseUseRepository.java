package com.laidback.repository;

import com.laidback.model.ComLicenseUse;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ComLicenseUseRepository extends JpaRepository<ComLicenseUse,Integer> {

}
