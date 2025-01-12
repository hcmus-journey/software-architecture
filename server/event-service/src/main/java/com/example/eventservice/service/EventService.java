package com.example.eventservice.service;

import com.example.eventservice.dto.EventDto;
import com.example.eventservice.dto.QuizGameEventDto;
import com.example.eventservice.dto.ShakeGameEventDto;
import com.example.eventservice.security.UserRole;

import java.util.List;
import java.util.UUID;

public interface EventService {
    UUID createEvent(UUID brandId, EventDto eventDto);

    void updateEvent(UUID eventId, EventDto eventDto);

    void updateEventStatus(UUID eventId, String status);

    void deleteEvent(UUID eventId);

    EventDto getEvent(UUID eventId);

    List<EventDto> getEvents(UserRole userRole, UUID userId);

    void addQuizGameEvent(UUID eventId, QuizGameEventDto quizGameEventDto);

    void addShakeGameEvent(UUID eventId, ShakeGameEventDto shakeGameEventDto);
}
