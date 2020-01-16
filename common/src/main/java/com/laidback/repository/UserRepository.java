package com.laidback.repository;

import com.laidback.model.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface UserRepository extends JpaRepository<User,Integer> {

    @Query("select seq from User us where us.loginId = :loginId")
    public Long findByLoginId(@Param(value = "loginId") String loginId);


}
