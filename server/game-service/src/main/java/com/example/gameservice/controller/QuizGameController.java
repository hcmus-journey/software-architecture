package com.example.gameservice.controller;

import com.example.gameservice.dto.QuizDto;
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
    final private QuizGameService quizGameService;

    @RequestMapping(value = "", method = RequestMethod.GET)
    @Operation(tags = "Admin", description = "Get all quizzes from the system.")
    public ResponseEntity<Map<String, List<QuizDto>>> getQuizzes(
            @RequestHeader("Authorization") String authorizationHeader) {
        List<QuizDto> quizzes = quizGameService.getAllQuizzes();
        return ResponseEntity.ok(Map.of("data", quizzes));
    }

    @RequestMapping(value = "/{quizId}", method = RequestMethod.GET)
    @Operation(tags = "Admin", description = "Get a quiz from the system.")
    public ResponseEntity<QuizDto> getQuiz(
            @PathVariable String quizId,
            @RequestHeader("Authorization") String authorizationHeader) {
        QuizDto quiz = quizGameService.getQuizById(UUID.fromString(quizId));
        return ResponseEntity.ok(quiz);
    }

    @RequestMapping(value = "/{quizId}", method = RequestMethod.PUT)
    @Operation(tags = "Admin", description = "Update a quiz in the system.")
    public ResponseEntity<Map<String, String>> updateQuiz(
            @PathVariable String quizId,
            @RequestBody QuizDto quizDto,
            @RequestHeader("Authorization") String authorizationHeader) {
        quizGameService.updateQuiz(UUID.fromString(quizId), quizDto);
        return ResponseEntity.ok(Map.of("message", "Quiz updated successfully"));
    }


}
