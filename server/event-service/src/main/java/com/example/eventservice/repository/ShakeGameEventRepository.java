package com.example.eventservice.repository;

import com.example.eventservice.entity.ShakeGameEvent;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ShakeGameEventRepository extends JpaRepository<ShakeGameEvent, UUID> {
}
