package com.example.eventservice.repository;

import com.example.eventservice.entity.QuizGameEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface QuizGameEventRepository extends JpaRepository<QuizGameEvent, UUID> {
    QuizGameEvent findByEventId(UUID eventId);
}
