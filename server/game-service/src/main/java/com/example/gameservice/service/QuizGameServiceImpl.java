package com.example.gameservice.service;

import com.example.gameservice.client.EventClient;
import com.example.gameservice.client.VoucherClient;
import com.example.gameservice.dto.QuizDto;
import com.example.gameservice.dto.QuizGameDto;
import com.example.gameservice.dto.QuizGameEventDto;
import com.example.gameservice.dto.VoucherDto;
import com.example.gameservice.entity.Quiz;
import com.example.gameservice.entity.QuizGameResult;
import com.example.gameservice.exception.BadRequestException;
import com.example.gameservice.mapper.QuizMapper;
import com.example.gameservice.repository.QuizGameResultRepository;
import com.example.gameservice.repository.QuizRepository;
import com.example.gameservice.repository.ShakeGameResultRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Collections;
import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class QuizGameServiceImpl implements QuizGameService {

    final private VoucherClient voucherClient;

    final private EventClient eventClient;

    final private QuizRepository quizRepository;

    final private QuizGameResultRepository quizGameResultRepository;

    final private ShakeGameResultRepository shakeGameResultRepository;

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

    @Override
    public QuizDto addQuiz(QuizDto quizDto) {
        Quiz quiz = QuizMapper.INSTANCE.convertToQuiz(quizDto);
        quiz.setQuizId(UUID.randomUUID());
        quizRepository.save(quiz);
        return QuizMapper.INSTANCE.convertToQuizDto(quiz);
    }



    @Override
    public List<QuizDto> startQuizGame(UUID eventId, UUID playerId) {
        QuizGameEventDto quizGameEventDto = eventClient.getQuizGameEvents(eventId.toString());
        if(quizGameEventDto == null) {
            throw new BadRequestException("Quiz game event not found");
        }
        List<Quiz> quizzes = quizRepository.findAll();
        Collections.shuffle(quizzes);
        List<Quiz> randomQuizzes = quizzes.stream().limit(quizGameEventDto.getQuestionCount()).toList();
        return randomQuizzes.stream().map(QuizMapper.INSTANCE::convertToQuizDto).toList();
    }

    @Override
    public VoucherDto endQuizGame(UUID playerId, QuizGameDto quizGameDto) {

        QuizGameResult quizGameResult = QuizGameResult.builder()
                .eventId(UUID.fromString(quizGameDto.getEventId()))
                .id(UUID.randomUUID())
                .playerId(playerId)
                .questionCount(quizGameDto.getQuestionCount())
                .correctAnswerCount(quizGameDto.getCorrectAnswerCount())
                .build();

        VoucherDto voucherDto = null;
        if(quizGameDto.getCorrectAnswerCount().equals(quizGameDto.getQuestionCount())) {
            voucherDto = voucherClient.distributeVoucher(UUID.fromString(quizGameDto.getEventId()), playerId);
        }

        quizGameResultRepository.save(quizGameResult);
        return voucherDto;
    }

    @Override
    public void deleteQuiz(UUID quizId) {
        quizRepository.deleteById(quizId);
    }


}
