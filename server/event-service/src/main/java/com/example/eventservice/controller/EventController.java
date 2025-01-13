package com.example.eventservice.controller;

import com.example.eventservice.dto.EventDto;
import com.example.eventservice.dto.QuizGameEventDto;
import com.example.eventservice.dto.ShakeGameEventDto;
import com.example.eventservice.dto.UpdateEventStatusRequest;
import com.example.eventservice.security.JwtUtil;
import com.example.eventservice.security.UserRole;
import com.example.eventservice.service.EventService;
import io.swagger.v3.oas.annotations.Operation;
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
    @Operation(tags = {"Brand", "Player", "Admin"}, summary = "Get all events")
    public ResponseEntity<List<EventDto>> getAllEvents(
            @RequestHeader("Authorization") String authorizationHeader) {

        UserRole userRole = jwtUtil.getUserRoleFromAuthorizationHeader(authorizationHeader);

        // Get the brand ID from the JWT token
        UUID userId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);
        // Get all events
        List<EventDto> events = eventService.getEvents(userRole, userId);

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
    @Operation(tags = {"Brand", "Player", "Admin"}, summary = "Get an event")
    public ResponseEntity<EventDto> getEvent(
            @PathVariable String eventId) {

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
            @RequestBody UpdateEventStatusRequest request,
            @RequestHeader("Authorization") String authorizationHeader) {

        eventService.updateEventStatus(UUID.fromString(eventId), request.getStatus());

        return ResponseEntity.ok(Map.of("message", "Event status updated successfully"));
    }

    @RequestMapping(value ="/favorite", method = RequestMethod.GET)
    @Operation(tags = "Player", summary = "Get all favorite events")
    public ResponseEntity<List<EventDto>> getFavoriteEvents(
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        List<EventDto> events = eventService.getFavoriteEvents(playerId);

        return ResponseEntity.ok(events);
    }

    @RequestMapping(value ="{eventId}/favorite", method = RequestMethod.POST)
    @Operation(tags = "Player", summary = "Add event to favorite")
    public ResponseEntity<Void> addFavoriteEvent(
            @PathVariable String eventId,
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        eventService.addFavoriteEvent(playerId, UUID.fromString(eventId));

        return ResponseEntity.ok().build();
    }

    @RequestMapping(value ="{eventId}/favorite", method = RequestMethod.DELETE)
    @Operation(tags = "Player", summary = "Remove event from favorite")
    public ResponseEntity<Void> deleteFavoriteEvent(
            @PathVariable String eventId,
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        eventService.removeFavoriteEvent(playerId, UUID.fromString(eventId));

        return ResponseEntity.ok().build();
    }

    @RequestMapping(value ="/{eventId}/quiz-game-event", method = RequestMethod.GET)
    @Operation(hidden = true)
    public ResponseEntity<QuizGameEventDto> getQuizGameEvent(
            @PathVariable String eventId) {

        QuizGameEventDto quizGameEventDto = eventService.getQuizGameEvent(UUID.fromString(eventId));

        return ResponseEntity.ok(quizGameEventDto);
    }

    @RequestMapping(value ="/{eventId}/shake-game-event", method = RequestMethod.GET)
    @Operation(hidden = true)
    public ResponseEntity<ShakeGameEventDto> getShakeGameEvent(
            @PathVariable String eventId) {

        ShakeGameEventDto shakeGameEventDto = eventService.getShakeGameEvent(UUID.fromString(eventId));

        return ResponseEntity.ok(shakeGameEventDto);
    }

}
