package com.example.gameservice.service;

import com.example.gameservice.dto.QuizDto;

import java.util.List;
import java.util.UUID;

public interface QuizGameService {
    void createQuizGame();
    void updateQuizGame();
    void deleteQuizGame();
    void getQuizGame();
    void getAllQuizGames();
    List<QuizDto> getAllQuizzes();
    QuizDto getQuizById(UUID quizId);
    void updateQuiz(UUID quizId, QuizDto quizDto);

    void addQuiz(QuizDto quizDto);
    }
