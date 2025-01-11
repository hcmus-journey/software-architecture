package com.example.gameservice.controller;

import com.example.gameservice.dto.GameDto;
import com.example.gameservice.service.GameService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/games")
@AllArgsConstructor
public class GameController {
    final private GameService gameService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    @Operation(tags = "Admin", description = "Get all games from the system.")
    public ResponseEntity<Map<String, List<GameDto>>> getGames(
            @RequestHeader("Authorization") String authorizationHeader) {
        List<GameDto> games = gameService.getAllGames();
        return ResponseEntity.ok(Map.of("data", games));
    }

    @RequestMapping(value = "/{gameId}", method = RequestMethod.GET)
    @Operation(tags = "Admin", description = "Get a game from the system.")
    public ResponseEntity<GameDto> getGame(
            @PathVariable String gameId,
            @RequestHeader("Authorization") String authorizationHeader) {
        GameDto game = gameService.getGameById(UUID.fromString(gameId));
        return ResponseEntity.ok(game);
    }

    @RequestMapping(value = "/{gameId}", method = RequestMethod.PUT)
    @Operation(tags = "Admin", description = "Update a game in the system.")
    public ResponseEntity<Map<String, String>> updateGame(
            @PathVariable String gameId,
            @RequestBody GameDto gameDto,
            @RequestHeader("Authorization") String authorizationHeader) {
        gameService.updateGame(UUID.fromString(gameId), gameDto);
        return ResponseEntity.ok(Map.of("message", "Game updated successfully"));
    }
}
