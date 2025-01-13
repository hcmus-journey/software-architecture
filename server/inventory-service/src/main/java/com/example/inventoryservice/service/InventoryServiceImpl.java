package com.example.inventoryservice.service;

import com.example.inventoryservice.entity.ShakeGameInventory;
import com.example.inventoryservice.repository.ShakeGameInventoryRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@AllArgsConstructor
public class InventoryServiceImpl implements InventoryService {
    final private ShakeGameInventoryRepository shakeGameInventoryRepository;

    @Override
    public void collectCoin(UUID playerId, UUID eventId) {
        ShakeGameInventory shakeGameInventory = shakeGameInventoryRepository.findByEventId(eventId).orElseGet(() -> {
            ShakeGameInventory newShakeGameInventory = new ShakeGameInventory();
            newShakeGameInventory.setPlayerId(playerId);
            newShakeGameInventory.setEventId(eventId);
            newShakeGameInventory.setInventoryId(UUID.randomUUID());
            newShakeGameInventory.setCollectedCoin(0);
            return newShakeGameInventory;
        });

        shakeGameInventory.setCollectedCoin(shakeGameInventory.getCollectedCoin() + 1);

        shakeGameInventoryRepository.save(shakeGameInventory);
    }
}