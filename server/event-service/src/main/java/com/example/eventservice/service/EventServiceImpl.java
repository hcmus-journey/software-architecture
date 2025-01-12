package com.example.eventservice.service;

import com.example.eventservice.client.GameClient;
import com.example.eventservice.client.VoucherClient;
import com.example.eventservice.dto.*;
import com.example.eventservice.entity.Event;
import com.example.eventservice.entity.QuizGameEvent;
import com.example.eventservice.entity.ShakeGameEvent;
import com.example.eventservice.exception.BadRequestException;
import com.example.eventservice.mapper.EventMapper;
import com.example.eventservice.repository.EventRepository;
import com.example.eventservice.repository.QuizGameEventRepository;
import com.example.eventservice.repository.ShakeGameEventRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class EventServiceImpl implements EventService {

    final private VoucherClient voucherClient;

    final private GameClient gameClient;

    final private EventRepository eventRepository;

    final private QuizGameEventRepository quizGameEventRepository;

    final private ShakeGameEventRepository shakeGameEventRepository;

    @Override
    public UUID createEvent(UUID brandId, EventDto eventDto) {
        Event newEvent = EventMapper.INSTANCE.convertToEntity(eventDto);

        newEvent.setBrandId(brandId);

        newEvent.setCreatedAt(LocalDate.now());

        newEvent.setStatus("PENDING");

        UUID eventId = UUID.randomUUID();

        newEvent.setEventId(eventId);

        eventRepository.save(newEvent);

        EventVoucherDto eventVoucherDto = EventVoucherDto.builder()
                .eventId(newEvent.getEventId())
                .redeemedVouchers(0)
                .totalVouchers(eventDto.getTotalVouchers())
                .discountPercentage(eventDto.getDiscountPercentage())
                .build();

        voucherClient.createEventVoucherDetails(eventVoucherDto);

        return eventId;
    }

    @Override
    public void updateEvent(UUID eventId, EventDto eventDto) {

        Event event = eventRepository.findByEventId(eventId);

        if(event == null) {
            throw new BadRequestException("Event not found");
        }

        if(event.getStartTime().isBefore(LocalDate.now())) {
            throw new BadRequestException("Event is already started");
        }

        event.setName(eventDto.getName());

        event.setImageUrl(eventDto.getImageUrl());

        event.setStartTime(eventDto.getStartTime());

        event.setEndTime(eventDto.getEndTime());

        event.setDescription(eventDto.getDescription());

        event.setStatus("PENDING");

        eventRepository.save(event);

        EventVoucherDto eventVoucherDto = EventVoucherDto.builder()
                .eventId(event.getEventId())
                .redeemedVouchers(0)
                .totalVouchers(eventDto.getTotalVouchers())
                .discountPercentage(eventDto.getDiscountPercentage())
                .build();

        voucherClient.updateEventVoucherDetails(eventVoucherDto);
    }

    @Override
    public void updateEventStatus(UUID eventId, String status){
        Event event = eventRepository.findByEventId(eventId);

        if(event == null) {
            throw new BadRequestException("Event not found");
        }

        event.setStatus(status);

        eventRepository.save(event);
    }

    @Override
    public void deleteEvent(UUID eventId) {
        Event event = eventRepository.findByEventId(eventId);

        if(event == null) {
            throw new BadRequestException("Event not found");
        }

        if(event.getStartTime().isBefore(LocalDate.now())) {
            throw new BadRequestException("Event is already started");
        }

        eventRepository.delete(event);
    }

    @Override
    public EventDto getEvent(UUID eventId) {
        return null;
    }

    @Override
    public List<EventDto> getEvents(UUID brandId) {
        List<Event> events = eventRepository.findByBrandId(brandId);

        if (events == null) {
            throw new BadRequestException("Events not found");
        }

        List<EventDto> eventDtos = events.stream()
                .map(EventMapper.INSTANCE::convertToDto)
                .toList();

        for(EventDto eventDto : eventDtos) {
            EventVoucherDto eventVoucherDto = voucherClient.getEventVoucherDetails(eventDto.getEventId().toString());
            eventDto.setTotalVouchers(eventVoucherDto.getTotalVouchers());
            eventDto.setRedeemedVouchers(eventVoucherDto.getRedeemedVouchers());
            eventDto.setDiscountPercentage(eventVoucherDto.getDiscountPercentage());
        }

        return eventDtos;
    }

    @Override
    public void addQuizGameEvent(UUID eventId, QuizGameEventDto quizGameEventDto) {
        QuizGameEvent quizGameEvent = EventMapper.INSTANCE.convertToEntity(quizGameEventDto);

        quizGameEvent.setEventId(eventId);

        GameDto gameDto = gameClient.getQuizGameInfo();

        quizGameEvent.setGameId(gameDto.getGameId());

        quizGameEventRepository.save(quizGameEvent);
    }

    @Override
    public void addShakeGameEvent(UUID eventId, ShakeGameEventDto shakeGameEventDto) {
        ShakeGameEvent shakeGameEvent = EventMapper.INSTANCE.convertToEntity(shakeGameEventDto);

        shakeGameEvent.setEventId(eventId);

        GameDto gameDto = gameClient.getShakeGameInfo();

        shakeGameEvent.setGameId(gameDto.getGameId());

        shakeGameEventRepository.save(shakeGameEvent);
    }
}
