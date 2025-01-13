package com.example.gameservice.controller;

import com.example.gameservice.security.JwtUtil;
import com.example.gameservice.service.ShakeGameService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/shake-games")
@AllArgsConstructor
public class ShakeGameController {
    final private ShakeGameService shakeGameService;

    final private JwtUtil jwtUtil;

    @RequestMapping(value = "/start", method = RequestMethod.POST)
    @Operation(tags = "Player", description = "Start a shake game.")
    public ResponseEntity<Map<String, Boolean>> startQuizGame(
            @RequestParam String eventId,
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);
        boolean isDrop = shakeGameService.startShakeGame(UUID.fromString(eventId), playerId);
        if(isDrop) {
            return ResponseEntity.ok(Map.of("isDrop", true));
        }
        return ResponseEntity.ok(Map.of("isDrop", false));
    }
}
