package com.example.gameservice.controller;

import com.example.gameservice.dto.QuizDto;
import com.example.gameservice.dto.QuizGameDto;
import com.example.gameservice.dto.VoucherDto;
import com.example.gameservice.security.JwtUtil;
import com.example.gameservice.service.QuizGameService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/quiz-games")
@AllArgsConstructor
public class QuizGameController {
    final private JwtUtil jwtUtil;

    final private QuizGameService quizGameService;

    @RequestMapping(value = "/quizzes", method = RequestMethod.GET)
    @Operation(tags = "Admin", description = "Get all quizzes from the system.")
    public ResponseEntity<List<QuizDto>> getQuizzes(
            @RequestHeader("Authorization") String authorizationHeader) {
        List<QuizDto> quizzes = quizGameService.getAllQuizzes();
        return ResponseEntity.ok(quizzes);
    }

    @RequestMapping(value = "/quizzes", method = RequestMethod.POST)
    @Operation(tags = "Admin", description = "Add a new quiz to the system.")
    public ResponseEntity<Void> getQuizzes(
            @RequestBody QuizDto quizDto,
            @RequestHeader("Authorization") String authorizationHeader) {
        quizGameService.addQuiz(quizDto);
        return ResponseEntity.ok().build();
    }

    @RequestMapping(value = "/quizzes/{quizId}", method = RequestMethod.GET)
    @Operation(tags = "Admin", description = "Get a quiz from the system.")
    public ResponseEntity<QuizDto> getQuiz(
            @PathVariable String quizId,
            @RequestHeader("Authorization") String authorizationHeader) {
        QuizDto quiz = quizGameService.getQuizById(UUID.fromString(quizId));
        return ResponseEntity.ok(quiz);
    }

    @RequestMapping(value = "/quizzes/{quizId}", method = RequestMethod.PUT)
    @Operation(tags = "Admin", description = "Update a quiz in the system.")
    public ResponseEntity<Map<String, String>> updateQuiz(
            @PathVariable String quizId,
            @RequestBody QuizDto quizDto,
            @RequestHeader("Authorization") String authorizationHeader) {
        quizGameService.updateQuiz(UUID.fromString(quizId), quizDto);
        return ResponseEntity.ok(Map.of("message", "Quiz updated successfully"));
    }

    @RequestMapping(value = "/quizzes/{quizId}", method = RequestMethod.DELETE)
    @Operation(tags = "Admin", description = "Delete a quiz in the system.")
    public ResponseEntity<Map<String, String>> deleteQuiz(
            @PathVariable String quizId,
            @RequestHeader("Authorization") String authorizationHeader) {
        quizGameService.deleteQuiz(UUID.fromString(quizId));
        return ResponseEntity.ok(Map.of("message", "Quiz deleted successfully"));
    }

    @RequestMapping(value = "/start", method = RequestMethod.POST)
    @Operation(tags = "Player", description = "Start a quiz game.")
    public ResponseEntity<List<QuizDto>> startQuizGame(
            @RequestParam String eventId,
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);
        List<QuizDto> quizDtos = quizGameService.startQuizGame(UUID.fromString(eventId), playerId);
        return ResponseEntity.ok(quizDtos);
    }

    @RequestMapping(value = "/end", method = RequestMethod.POST)
    @Operation(tags = "Player", description = "End a quiz game.")
    public ResponseEntity<VoucherDto> endQuizGame(
            @RequestBody QuizGameDto quizGameDto,
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);
        VoucherDto voucherDto = quizGameService.endQuizGame(playerId, quizGameDto);
        if(voucherDto == null) {
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.ok(voucherDto);
    }
}
