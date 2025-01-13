package com.example.inventoryservice.client;


import com.example.inventoryservice.dto.EventDto;
import com.example.inventoryservice.dto.QuizGameEventDto;
import com.example.inventoryservice.dto.ShakeGameEventDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "event-service")
public interface EventClient {
    @GetMapping("/api/events/{eventId}/quiz-game-event")
    QuizGameEventDto getQuizGameEvents(@PathVariable String eventId);

    @GetMapping("/api/events/{eventId}/shake-game-event")
    ShakeGameEventDto getShakeGameEvents(@PathVariable String eventId);

    @GetMapping("/api/events/{eventId}")
    EventDto getEvent(@PathVariable String eventId);
}
