package com.example.eventservice.service;

import com.example.eventservice.dto.EventDto;
import com.example.eventservice.entity.Event;
import com.example.eventservice.mapper.EventMapper;
import com.example.eventservice.repository.EventRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class EventServiceImpl implements EventService {

    final private EventRepository eventRepository;

    @Override
    public void createEvent(UUID brandId, EventDto eventDto) {
        Event newEvent = EventMapper.INSTANCE.eventDtoToEvent(eventDto);

        newEvent.setBrandId(brandId);

        eventRepository.save(newEvent);
    }

    @Override
    public void updateEvent(UUID brandId, EventDto eventDto) {

    }

    @Override
    public void deleteEvent(UUID eventId) {

    }

    @Override
    public EventDto getEvent(UUID eventId) {
        return null;
    }

    @Override
    public List<EventDto> getEvents(UUID brandId) {
        return List.of();
    }

    @Override
    public void distributeVoucher(UUID eventId) {

    }
}
