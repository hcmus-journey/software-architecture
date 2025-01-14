package com.example.inventoryservice.service;

import com.example.inventoryservice.client.EventClient;
import com.example.inventoryservice.dto.EventDto;
import com.example.inventoryservice.dto.ShakeGameEventDto;
import com.example.inventoryservice.dto.ShakeGameInventoryDto;
import com.example.inventoryservice.entity.ShakeGameInventory;
import com.example.inventoryservice.mapper.InventoryMapper;
import com.example.inventoryservice.repository.ShakeGameInventoryRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class InventoryServiceImpl implements InventoryService {
    final private ShakeGameInventoryRepository shakeGameInventoryRepository;

    final private EventClient eventClient;

    @Override
    public void collectCoin(UUID playerId, UUID eventId) {
        ShakeGameInventory shakeGameInventory = shakeGameInventoryRepository.findByEventId(eventId).orElseGet(() -> {
            ShakeGameInventory newShakeGameInventory = new ShakeGameInventory();
            newShakeGameInventory.setPlayerId(playerId);
            newShakeGameInventory.setEventId(eventId);
            newShakeGameInventory.setInventoryId(UUID.randomUUID());
            newShakeGameInventory.setCollectedCoins(0);

            ShakeGameEventDto shakeGameEventDto = eventClient.getShakeGameEvents(eventId.toString());

            newShakeGameInventory.setRequiredCoins(shakeGameEventDto.getRequiredCoins());

            return newShakeGameInventory;
        });

        shakeGameInventory.setCollectedCoins(shakeGameInventory.getCollectedCoins() + 1);

        shakeGameInventoryRepository.save(shakeGameInventory);
    }

    @Override
    public List<ShakeGameInventoryDto> getInventory(UUID playerId) {
        List<ShakeGameInventory> shakeGameInventories = shakeGameInventoryRepository.findByPlayerId(playerId);

        List<ShakeGameInventoryDto> shakeGameEventDtos = new ArrayList<>();

        for(ShakeGameInventory shakeGameInventory : shakeGameInventories) {
            ShakeGameInventoryDto shakeGameInventoryDto = InventoryMapper.INSTANCE.convertToDto(shakeGameInventory);

            ShakeGameEventDto shakeGameEventDto = eventClient
                    .getShakeGameEvents(shakeGameInventoryDto.getEventId().toString());

            EventDto eventDto = eventClient.getEvent(shakeGameInventoryDto.getEventId().toString());

            shakeGameInventoryDto.setEventName(eventDto.getName());

            shakeGameInventoryDto.setEventImageUrl(eventDto.getImageUrl());

            shakeGameInventoryDto.setRequiredCoins(shakeGameEventDto.getRequiredCoins());

            shakeGameEventDtos.add(shakeGameInventoryDto);

        }

        return shakeGameEventDtos;
    }
}