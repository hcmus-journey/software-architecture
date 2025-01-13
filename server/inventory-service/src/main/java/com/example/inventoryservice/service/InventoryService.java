package com.example.inventoryservice.service;

import com.example.inventoryservice.dto.ShakeGameInventoryDto;

import java.util.List;
import java.util.UUID;

public interface InventoryService {
    void collectCoin(UUID playerId, UUID eventId);

    List<ShakeGameInventoryDto> getInventory(UUID playerId);
}
