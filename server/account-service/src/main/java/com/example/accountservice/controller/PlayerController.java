package com.example.accountservice.controller;

import com.example.accountservice.dto.PlayerProfileDto;
import com.example.accountservice.security.JwtUtil;
import com.example.accountservice.service.PlayerService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/player")
@AllArgsConstructor
public class PlayerController {

    private final PlayerService playerService;

    private JwtUtil jwtUtil;

    @RequestMapping(path = "/profile", method = RequestMethod.PUT)
    @Operation(tags = "Player", description = "Update player profile")
    public ResponseEntity<Map<String, String>> updateProfileRequest(
            @Valid @RequestBody PlayerProfileDto  playerProfileDto,
            @RequestHeader("Authorization") String authorizationHeader) {

        // Extract player id from authorization header.
        // Player id is user id in this case.
        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        playerService.updateProfile(playerId, playerProfileDto);

        return ResponseEntity.ok(Map.of("message", "Profile updated successfully"));
    }

    @RequestMapping(path = "/active", method = RequestMethod.POST)
    @Operation(tags = "Player", description = "Update player profile")
    public ResponseEntity<Map<String, String>> activePlayerRequest(
            @Valid @RequestBody PlayerProfileDto  playerProfileDto,
            @RequestHeader("Authorization") String authorizationHeader) {

        // Extract player id from authorization header.
        // Player id is user id in this case.
        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        playerService.activePlayer(playerId, playerProfileDto);

        return ResponseEntity.ok(Map.of("message", "Player activated successfully"));
    }
}
