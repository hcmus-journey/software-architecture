package com.example.gameservice.client;

import com.example.gameservice.dto.QuizGameEventDto;
import com.example.gameservice.dto.ShakeGameEventDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "event-service")
public interface EventClient {
    @GetMapping("/api/events/{eventId}/quiz-game-event")
    QuizGameEventDto getQuizGameEvents(@PathVariable String eventId);

    @GetMapping("/api/events/{eventId}/shake-game-event")
    ShakeGameEventDto getShakeGameEvents(@PathVariable String eventId);
}
