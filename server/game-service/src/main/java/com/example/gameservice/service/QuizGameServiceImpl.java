package com.example.gameservice.service;

import com.example.gameservice.dto.QuizDto;
import com.example.gameservice.entity.Quiz;
import com.example.gameservice.exception.BadRequestException;
import com.example.gameservice.mapper.QuizMapper;
import com.example.gameservice.repository.QuizGameRepository;
import com.example.gameservice.repository.QuizRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class QuizGameServiceImpl implements QuizGameService {

    final private QuizGameRepository quizGameRepository;

    final private QuizRepository quizRepository;

    @Override
    public void createQuizGame() {

    }

    @Override
    public void updateQuizGame() {

    }

    @Override
    public void deleteQuizGame() {

    }

    @Override
    public void getQuizGame() {

    }

    @Override
    public void getAllQuizGames() {

    }

    @Override
    public List<QuizDto> getAllQuizzes() {
        return quizRepository.findAll().stream().map(QuizMapper.INSTANCE::convertToQuizDto).toList();
    }

    @Override
    public QuizDto getQuizById(UUID quizId) {
        return quizRepository.findById(quizId).map(QuizMapper.INSTANCE::convertToQuizDto).orElse(null);
    }

    @Override
    public void updateQuiz(UUID quizId, QuizDto quizDto) {
        Quiz quiz = quizRepository.findById(quizId).orElse(null);
        if(quiz == null) {
            throw new BadRequestException("Quiz not found");
        }

        if(quizDto.getContent() != null && !quizDto.getContent().isEmpty()) {
            quiz.setContent(quizDto.getContent());
        }

        if(quizDto.getOptions() != null && !quizDto.getOptions().isEmpty()) {
            quiz.setOptions(quizDto.getOptions());
        }

        quizRepository.save(quiz);
    }
}
