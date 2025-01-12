package com.example.gameservice.service;

import com.example.gameservice.dto.QuizDto;
import com.example.gameservice.dto.QuizGameDto;
import com.example.gameservice.dto.VoucherDto;

import java.util.List;
import java.util.UUID;

public interface QuizGameService {
    List<QuizDto> getAllQuizzes();
    QuizDto getQuizById(UUID quizId);
    void updateQuiz(UUID quizId, QuizDto quizDto);
    void addQuiz(QuizDto quizDto);
    List<QuizDto> startQuizGame(UUID eventId, UUID playerId);
    VoucherDto endQuizGame(UUID playerId, QuizGameDto quizGameDto);
}
