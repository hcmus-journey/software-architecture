package com.example.eventservice.mapper;

import com.example.eventservice.dto.EventDto;
import com.example.eventservice.dto.QuizGameEventDto;
import com.example.eventservice.dto.ShakeGameEventDto;
import com.example.eventservice.entity.Event;
import com.example.eventservice.entity.QuizGameEvent;
import com.example.eventservice.entity.ShakeGameEvent;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface EventMapper {
    EventMapper INSTANCE = Mappers.getMapper(EventMapper.class);

    EventDto convertToDto(Event event);

    Event convertToEntity(EventDto eventDto);

    ShakeGameEventDto convertToDto(ShakeGameEvent shakeGameEvent);

    ShakeGameEvent convertToEntity(ShakeGameEventDto shakeGameEventDto);

    QuizGameEventDto convertToDto(QuizGameEvent quizGameEvent);

    QuizGameEvent convertToEntity(QuizGameEventDto quizGameEventDto);
}
