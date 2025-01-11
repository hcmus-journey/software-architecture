package com.example.eventservice.controller;

import com.example.eventservice.dto.EventDto;
import com.example.eventservice.security.JwtUtil;
import com.example.eventservice.service.EventService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/events")
@AllArgsConstructor
public class EventController {

    final private EventService eventService;

    final private JwtUtil jwtUtil;

    @RequestMapping(method = RequestMethod.POST)
    @Operation(tags = "Brand", summary = "Create a new event")
    public ResponseEntity<Map<String, String>> createEvent(
            @Valid @RequestBody EventDto eventDto,
            @RequestHeader("Authorization") String authorizationHeader) {

        // Get the brand ID from the JWT token
        UUID brandId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        // Create the event
        eventService.createEvent(brandId, eventDto);

        return ResponseEntity.ok(Map.of("message", "Event created successfully"));
    }
}
