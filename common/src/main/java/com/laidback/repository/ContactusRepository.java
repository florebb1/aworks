package com.laidback.repository;

import com.laidback.model.Contactus;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContactusRepository extends JpaRepository<Contactus,Integer> {
}
