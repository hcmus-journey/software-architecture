package com.example.inventoryservice.repository;

import com.example.inventoryservice.entity.ShakeGameInventory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Repository
public interface ShakeGameInventoryRepository extends JpaRepository<ShakeGameInventory, UUID> {
    Optional<ShakeGameInventory> findByEventId(UUID eventId);
    ShakeGameInventory findByInventoryId(UUID inventoryId);
    List<ShakeGameInventory> findByPlayerId(UUID playerId);
    ShakeGameInventory findByPlayerIdAndEventId(UUID playerId, UUID eventId);
}
