package com.example.eventservice.client;

import com.example.eventservice.dto.GameDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "game-service")
public interface GameClient {
    @GetMapping("/api/games/shake-game-info")
    GameDto getShakeGameInfo();

    @GetMapping("/api/games/quiz-game-info")
    GameDto getQuizGameInfo();
}
