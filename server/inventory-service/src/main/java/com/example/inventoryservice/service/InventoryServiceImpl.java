package com.example.inventoryservice.service;

import com.example.inventoryservice.client.EventClient;
import com.example.inventoryservice.client.VoucherClient;
import com.example.inventoryservice.dto.*;
import com.example.inventoryservice.entity.ShakeGameInventory;
import com.example.inventoryservice.exception.BadRequestException;
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

    final private VoucherClient voucherClient;

    @Override
    public void collectCoin(UUID playerId, UUID eventId) {
        ShakeGameInventory shakeGameInventory = shakeGameInventoryRepository.findByPlayerIdAndEventId(playerId, eventId);
        if(shakeGameInventory == null)
        {
            ShakeGameInventory newShakeGameInventory = new ShakeGameInventory();
            newShakeGameInventory.setPlayerId(playerId);
            newShakeGameInventory.setEventId(eventId);
            newShakeGameInventory.setInventoryId(UUID.randomUUID());
            newShakeGameInventory.setCollectedCoins(0);

            ShakeGameEventDto shakeGameEventDto = eventClient.getShakeGameEvents(eventId.toString());

            newShakeGameInventory.setRequiredCoins(shakeGameEventDto.getRequiredCoins());

            shakeGameInventoryRepository.save(newShakeGameInventory);
            return;
        }

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

    @Override
    public VoucherDto exchangeCoin(UUID playerId, UUID inventoryId) {
        ShakeGameInventory shakeGameInventory = shakeGameInventoryRepository.findByInventoryId(inventoryId);

        if (shakeGameInventory.getCollectedCoins() < shakeGameInventory.getRequiredCoins()) {
            throw new BadRequestException("Not enough coins to exchange");
        }

        shakeGameInventory.setCollectedCoins(shakeGameInventory.getCollectedCoins() - shakeGameInventory.getRequiredCoins());

        shakeGameInventoryRepository.save(shakeGameInventory);

        return voucherClient.distributeVoucher(shakeGameInventory.getEventId(), playerId);
    }

    @Override
    public void giftCoin(UUID currentUserId, GiftCoinRequest giftCoinRequest, UUID inventoryId) {
        ShakeGameInventory currentPlayerInventory = shakeGameInventoryRepository.findByInventoryId(inventoryId);

        if (currentPlayerInventory.getCollectedCoins() < giftCoinRequest.getCoins()) {
            throw new BadRequestException("Not enough coins to gift");
        }

        currentPlayerInventory.setCollectedCoins(currentPlayerInventory.getCollectedCoins() - giftCoinRequest.getCoins());

        shakeGameInventoryRepository.save(currentPlayerInventory);

        ShakeGameInventory receiverShakeGameInventory = shakeGameInventoryRepository.findByPlayerIdAndEventId(
                UUID.fromString(giftCoinRequest.getReceiverId()), currentPlayerInventory.getEventId());

        if (receiverShakeGameInventory == null) {
            receiverShakeGameInventory = new ShakeGameInventory();
            receiverShakeGameInventory.setInventoryId(UUID.randomUUID());
            receiverShakeGameInventory.setPlayerId(UUID.fromString(giftCoinRequest.getReceiverId()));
            receiverShakeGameInventory.setEventId(currentPlayerInventory.getEventId());
            receiverShakeGameInventory.setRequiredCoins(currentPlayerInventory.getRequiredCoins());
            receiverShakeGameInventory.setCollectedCoins(giftCoinRequest.getCoins());
        }
        else {
            receiverShakeGameInventory.setCollectedCoins(receiverShakeGameInventory.getCollectedCoins() + giftCoinRequest.getCoins());
        }

        shakeGameInventoryRepository.save(receiverShakeGameInventory);
    }
}