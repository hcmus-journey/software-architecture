package com.example.eventservice.mapper;

import com.example.eventservice.dto.EventDto;
import com.example.eventservice.dto.QuizGameEventDto;
import com.example.eventservice.dto.ShakeGameEventDto;
import com.example.eventservice.entity.Event;
import com.example.eventservice.entity.QuizGameEvent;
import com.example.eventservice.entity.ShakeGameEvent;
import java.util.UUID;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-01-13T01:52:22+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23.0.1 (Oracle Corporation)"
)
public class EventMapperImpl implements EventMapper {

    @Override
    public EventDto convertToDto(Event event) {
        if ( event == null ) {
            return null;
        }

        EventDto eventDto = new EventDto();

        eventDto.setEventId( event.getEventId() );
        eventDto.setName( event.getName() );
        eventDto.setImageUrl( event.getImageUrl() );
        eventDto.setStartTime( event.getStartTime() );
        eventDto.setEndTime( event.getEndTime() );
        eventDto.setDescription( event.getDescription() );
        eventDto.setStatus( event.getStatus() );
        eventDto.setCreatedAt( event.getCreatedAt() );

        return eventDto;
    }

    @Override
    public Event convertToEntity(EventDto eventDto) {
        if ( eventDto == null ) {
            return null;
        }

        Event event = new Event();

        event.setEventId( eventDto.getEventId() );
        event.setName( eventDto.getName() );
        event.setImageUrl( eventDto.getImageUrl() );
        event.setStartTime( eventDto.getStartTime() );
        event.setEndTime( eventDto.getEndTime() );
        event.setDescription( eventDto.getDescription() );
        event.setStatus( eventDto.getStatus() );
        event.setCreatedAt( eventDto.getCreatedAt() );

        return event;
    }

    @Override
    public ShakeGameEventDto convertToDto(ShakeGameEvent shakeGameEvent) {
        if ( shakeGameEvent == null ) {
            return null;
        }

        UUID eventId = null;
        UUID gameId = null;
        Integer requiredCoins = null;
        Double coinDropRate = null;

        eventId = shakeGameEvent.getEventId();
        gameId = shakeGameEvent.getGameId();
        requiredCoins = shakeGameEvent.getRequiredCoins();
        coinDropRate = shakeGameEvent.getCoinDropRate();

        ShakeGameEventDto shakeGameEventDto = new ShakeGameEventDto( eventId, gameId, requiredCoins, coinDropRate );

        return shakeGameEventDto;
    }

    @Override
    public ShakeGameEvent convertToEntity(ShakeGameEventDto shakeGameEventDto) {
        if ( shakeGameEventDto == null ) {
            return null;
        }

        ShakeGameEvent shakeGameEvent = new ShakeGameEvent();

        shakeGameEvent.setEventId( shakeGameEventDto.getEventId() );
        shakeGameEvent.setGameId( shakeGameEventDto.getGameId() );
        shakeGameEvent.setRequiredCoins( shakeGameEventDto.getRequiredCoins() );
        shakeGameEvent.setCoinDropRate( shakeGameEventDto.getCoinDropRate() );

        return shakeGameEvent;
    }

    @Override
    public QuizGameEventDto convertToDto(QuizGameEvent quizGameEvent) {
        if ( quizGameEvent == null ) {
            return null;
        }

        UUID eventId = null;
        UUID gameId = null;
        Integer questionCount = null;

        eventId = quizGameEvent.getEventId();
        gameId = quizGameEvent.getGameId();
        questionCount = quizGameEvent.getQuestionCount();

        QuizGameEventDto quizGameEventDto = new QuizGameEventDto( eventId, gameId, questionCount );

        return quizGameEventDto;
    }

    @Override
    public QuizGameEvent convertToEntity(QuizGameEventDto quizGameEventDto) {
        if ( quizGameEventDto == null ) {
            return null;
        }

        QuizGameEvent quizGameEvent = new QuizGameEvent();

        quizGameEvent.setEventId( quizGameEventDto.getEventId() );
        quizGameEvent.setGameId( quizGameEventDto.getGameId() );
        quizGameEvent.setQuestionCount( quizGameEventDto.getQuestionCount() );

        return quizGameEvent;
    }
}
