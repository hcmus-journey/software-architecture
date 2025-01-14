package com.example.inventoryservice.service;

import com.example.inventoryservice.dto.GiftCoinRequest;
import com.example.inventoryservice.dto.ShakeGameInventoryDto;
import com.example.inventoryservice.dto.VoucherDto;

import java.util.List;
import java.util.UUID;

public interface InventoryService {
    void collectCoin(UUID playerId, UUID eventId);

    List<ShakeGameInventoryDto> getInventory(UUID playerId);

    VoucherDto exchangeCoin(UUID playerId, UUID inventoryId);

    void giftCoin(UUID currentUserId, GiftCoinRequest giftCoinRequest, UUID inventoryId);
}
