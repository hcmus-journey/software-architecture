package com.example.gameservice.service;

import com.example.gameservice.client.EventClient;
import com.example.gameservice.client.InventoryClient;
import com.example.gameservice.dto.ShakeGameEventDto;
import com.example.gameservice.entity.ShakeGameResult;
import com.example.gameservice.repository.ShakeGameResultRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@AllArgsConstructor
public class ShakeGameServiceImpl implements ShakeGameService {

    final private ShakeGameResultRepository shakeGameResultRepository;

    final private EventClient eventClient;

    final private InventoryClient inventoryClient;

    @Override
    public Boolean startShakeGame(UUID eventId, UUID playerId) {

        ShakeGameEventDto shakeGameEventDto = eventClient.getShakeGameEvents(eventId.toString());

        boolean isDrop = Math.random() < (shakeGameEventDto.getCoinDropRate() / 100.0);

        ShakeGameResult shakeGameResult = ShakeGameResult.builder()
                .eventId(eventId)
                .id(UUID.randomUUID())
                .playerId(playerId)
                .isDrop(isDrop)
                .build();

        if(isDrop) {
            inventoryClient.collectCoin(playerId, eventId);
        }

        shakeGameResultRepository.save(shakeGameResult);

        return isDrop;
    }
}
