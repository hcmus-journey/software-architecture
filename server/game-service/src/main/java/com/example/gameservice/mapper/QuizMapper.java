package com.example.gameservice.mapper;

import com.example.gameservice.dto.QuizDto;
import com.example.gameservice.entity.Quiz;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface QuizMapper {
    QuizMapper INSTANCE = org.mapstruct.factory.Mappers.getMapper(QuizMapper.class);

    QuizDto convertToQuizDto(Quiz quiz);
}
