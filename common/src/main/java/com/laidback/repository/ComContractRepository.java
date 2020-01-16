package com.laidback.repository;

import com.laidback.model.ComContract;
import com.laidback.model.Company;
import com.laidback.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface ComContractRepository extends JpaRepository<ComContract, Integer> {
    @Query("select us from ComContract us where us.company = :company order by us.seq desc")
    public List<ComContract> findByCompany(@Param(value = "company") Company company);

    @Query("select us from ComContract us where us.user = :user order by us.seq desc")
    public List<ComContract> findByUser(@Param(value = "user") User user);

}
