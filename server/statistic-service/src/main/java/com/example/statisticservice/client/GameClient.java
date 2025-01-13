package com.example.statisticservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@FeignClient(name = "game-service")
public interface GameClient {
    @GetMapping("/api/games/total-attempts")
    List<Long> getTotalQuizAndShakeGameAttempts();
}
