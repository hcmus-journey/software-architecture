package com.example.gameservice.mapper;

import com.example.gameservice.dto.QuizDto;
import com.example.gameservice.entity.Option;
import com.example.gameservice.entity.Quiz;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-01-13T01:55:53+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23.0.1 (Oracle Corporation)"
)
public class QuizMapperImpl implements QuizMapper {

    @Override
    public QuizDto convertToQuizDto(Quiz quiz) {
        if ( quiz == null ) {
            return null;
        }

        UUID quizId = null;
        String content = null;
        List<Option> options = null;

        quizId = quiz.getQuizId();
        content = quiz.getContent();
        List<Option> list = quiz.getOptions();
        if ( list != null ) {
            options = new ArrayList<Option>( list );
        }

        QuizDto quizDto = new QuizDto( quizId, content, options );

        return quizDto;
    }
}
