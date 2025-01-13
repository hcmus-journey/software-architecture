package com.example.gameservice.service;

import com.example.gameservice.dto.GameDto;
import com.example.gameservice.entity.Game;
import com.example.gameservice.exception.BadRequestException;
import com.example.gameservice.mapper.GameMapper;
import com.example.gameservice.repository.GameRepository;
import com.example.gameservice.repository.QuizGameResultRepository;
import com.example.gameservice.repository.ShakeGameResultRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class GameServiceImpl implements GameService {
    final private GameRepository gameRepository;

    final private QuizGameResultRepository quizGameResultRepository;

    final private ShakeGameResultRepository shakeGameResultRepository;

    @Override
    public List<GameDto> getAllGames() {
        return gameRepository.findAll().stream().map(GameMapper.INSTANCE::convertToGameDto).toList();
    }

    @Override
    public GameDto getGameById(UUID gameId) {
        Game game = gameRepository.findById(gameId).orElse(null);

        if (game == null) {
            throw new BadRequestException("Game not found");
        }

        return GameMapper.INSTANCE.convertToGameDto(game);
    }

    @Override
    public void updateGame(UUID gameId, GameDto gameDto) {
        Game game = gameRepository.findById(gameId).orElse(null);

        if (game == null) {
            throw new BadRequestException("Game not found");
        }

        if(gameDto.getName() != null && !gameDto.getName().isEmpty()) {
            game.setName(gameDto.getName());
        }

        if(gameDto.getDescription() != null && !gameDto.getDescription().isEmpty()) {
            game.setDescription(gameDto.getDescription());
        }

        if(gameDto.getImageUrl() != null && !gameDto.getImageUrl().isEmpty()) {
            game.setImageUrl(gameDto.getImageUrl());
        }

        gameRepository.save(game);
    }

    @Override
    public GameDto getGameByType(String gameType) {
        return gameRepository.findByType(gameType)
                .stream()
                .findFirst()
                .map(GameMapper.INSTANCE::convertToGameDto)
                .orElse(null);
    }

    @Override
    public List<Long> getTotalQuizAndShakeGameAttempts() {
        return List.of(
                quizGameResultRepository.count(),
                shakeGameResultRepository.count()
        );
    }
}
