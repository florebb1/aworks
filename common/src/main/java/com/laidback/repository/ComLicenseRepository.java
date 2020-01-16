package com.laidback.repository;

import com.laidback.model.ComContract;
import com.laidback.model.ComLicense;
import com.laidback.model.Company;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ComLicenseRepository extends JpaRepository<ComLicense,Integer> {
    @Query("select us from ComLicense us where us.comContract = :comContract")
    public List<ComLicense> findByContract(@Param(value = "comContract") ComContract comContract);
}
