package com.example.inventoryservice.client;


import com.example.inventoryservice.dto.GameDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

@FeignClient(name = "game-service")
public interface GameClient {
    @GetMapping("/api/games/shake-game-info")
    GameDto getShakeGameInfo();

    @GetMapping("/api/games/quiz-game-info")
    GameDto getQuizGameInfo();
}
