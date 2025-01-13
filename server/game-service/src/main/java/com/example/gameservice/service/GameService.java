package com.example.gameservice.service;

import com.example.gameservice.dto.GameDto;

import java.util.List;
import java.util.UUID;

public interface GameService {
    List<GameDto> getAllGames();
    GameDto getGameById(UUID gameId);
    void updateGame(UUID gameId, GameDto gameDto);
    GameDto getGameByType(String gameType);
    List<Long> getTotalQuizAndShakeGameAttempts();
}
