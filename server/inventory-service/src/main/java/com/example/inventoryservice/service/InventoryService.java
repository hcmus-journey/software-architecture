package com.example.inventoryservice.service;

import java.util.UUID;

public interface InventoryService {
    void collectCoin(UUID playerId, UUID eventId);
}
