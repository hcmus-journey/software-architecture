package com.example.eventservice.controller;

import com.example.eventservice.dto.EventDto;
import com.example.eventservice.dto.QuizGameEventDto;
import com.example.eventservice.dto.ShakeGameEventDto;
import com.example.eventservice.security.JwtUtil;
import com.example.eventservice.service.EventService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/events")
@AllArgsConstructor
public class EventController {

    final private EventService eventService;

    final private JwtUtil jwtUtil;

    @RequestMapping(method = RequestMethod.POST)
    @Operation(tags = "Brand", summary = "Create an new event")
    public ResponseEntity<Map<String, String>> createEvent(
            @Valid @RequestBody EventDto eventDto,
            @RequestHeader("Authorization") String authorizationHeader) {

        // Get the brand ID from the JWT token
        UUID brandId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        // Create the event
        UUID eventId = eventService.createEvent(brandId, eventDto);

        return ResponseEntity.ok(Map.of("eventId", eventId.toString()));
    }

    @RequestMapping(method = RequestMethod.GET)
    @Operation(tags = "Brand", summary = "Get all events")
    public ResponseEntity<List<EventDto>> getAllEvents(
            @RequestHeader("Authorization") String authorizationHeader) {

        // Get the brand ID from the JWT token
        UUID brandId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        // Get all events
        List<EventDto> events = eventService.getEvents(brandId);

        return ResponseEntity.ok(events);
    }

    @RequestMapping(value = "/{eventId}", method = RequestMethod.PUT)
    @Operation(tags = "Brand", summary = "Update an event")
    public ResponseEntity<Void> updateEvent(
            @Valid @RequestBody EventDto eventDto,
            @PathVariable String eventId,
            @RequestHeader("Authorization") String authorizationHeader) {

        eventService.updateEvent(UUID.fromString(eventId), eventDto);

        return ResponseEntity.ok().build();
    }

    @RequestMapping(value = "/{eventId}", method = RequestMethod.GET)
    @Operation(tags = "Brand", summary = "Get an event")
    public ResponseEntity<EventDto> getEvent(
            @PathVariable String eventId,
            @RequestHeader("Authorization") String authorizationHeader) {

        EventDto eventDto = eventService.getEvent(UUID.fromString(eventId));

        return ResponseEntity.ok(eventDto);
    }


    @RequestMapping(value = "{eventId}/quiz-game", method = RequestMethod.POST)
    @Operation(tags = "Brand", summary = "Add quiz game to event")
    public ResponseEntity<Map<String, String>> addQuizGameToEvent(
            @Valid @RequestBody QuizGameEventDto quizGameEventDto,
            @PathVariable String eventId,
            @RequestHeader("Authorization") String authorizationHeader) {

        eventService.addQuizGameEvent(UUID.fromString(eventId), quizGameEventDto);

        return ResponseEntity.ok(Map.of("message", "Game added successfully"));
    }

    @RequestMapping(value = "{eventId}/shake-game", method = RequestMethod.POST)
    @Operation(tags = "Brand", summary = "Add shake phone game to event")
    public ResponseEntity<Map<String, String>> addShakeGameToEvent(
            @Valid @RequestBody ShakeGameEventDto shakeGameEventDto,
            @PathVariable String eventId,
            @RequestHeader("Authorization") String authorizationHeader) {

        eventService.addShakeGameEvent(UUID.fromString(eventId), shakeGameEventDto);

        return ResponseEntity.ok(Map.of("message", "Game added successfully"));
    }

    @RequestMapping(value = "{eventId}/status", method = RequestMethod.PATCH)
    @Operation(tags = "Admin", summary = "Update event status")
    public ResponseEntity<Map<String, String>> updateEventStatus(
            @PathVariable String eventId,
            @Schema(allowableValues = {"ACCEPTED", "NOT_ACCEPTED"}) @RequestPart String status,
            @RequestHeader("Authorization") String authorizationHeader) {

        eventService.updateEventStatus(UUID.fromString(eventId), status);

        return ResponseEntity.ok(Map.of("message", "Event status updated successfully"));
    }
}
