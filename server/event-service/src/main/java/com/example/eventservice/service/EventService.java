package com.example.eventservice.service;

import com.example.eventservice.dto.EventDto;

import java.util.List;
import java.util.UUID;

public interface EventService {
    void createEvent(UUID brandId, EventDto eventDto);
    void updateEvent(UUID brandId, EventDto eventDto);
    void deleteEvent(UUID eventId);
    EventDto getEvent(UUID eventId);
    List<EventDto> getEvents(UUID brandId);
    void distributeVoucher(UUID eventId);
}
