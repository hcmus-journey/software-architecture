package com.example.gameservice.service;

import java.util.UUID;

public interface ShakeGameService {
    Boolean startShakeGame(UUID eventId, UUID playerId);
}
