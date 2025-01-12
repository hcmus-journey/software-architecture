package com.example.eventservice.repository;

import com.example.eventservice.entity.PlayerFavoriteEvent;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.UUID;

public interface PlayerFavoriteEventRepository extends JpaRepository<PlayerFavoriteEvent, UUID> {
    List<PlayerFavoriteEvent> findByPlayerId(UUID playerId);
    List<PlayerFavoriteEvent> findByEventId(UUID eventId);
    PlayerFavoriteEvent findByPlayerIdAndEventId(UUID playerId, UUID eventId);
}
