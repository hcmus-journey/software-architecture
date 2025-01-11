package com.example.eventservice.mapper;

import com.example.eventservice.dto.EventDto;
import com.example.eventservice.entity.Event;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface EventMapper {
    EventMapper INSTANCE = Mappers.getMapper(EventMapper.class);

    EventDto eventToEventDto(Event event);

    Event eventDtoToEvent(EventDto eventDto);
}
