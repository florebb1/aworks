package com.laidback.repository;

import com.laidback.model.ReleaseNote;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ReleaseNoteRepository extends JpaRepository<ReleaseNote,Integer> {
}
