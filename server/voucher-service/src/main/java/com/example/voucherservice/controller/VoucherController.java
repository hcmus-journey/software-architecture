package com.example.voucherservice.controller;

import com.example.voucherservice.dto.EventVoucherDto;
import com.example.voucherservice.security.JwtUtil;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/vouchers")
@AllArgsConstructor
public class VoucherController {

    final private EventVoucherService eventVoucherService;

    final private JwtUtil jwtUtil;

    @RequestMapping(method = RequestMethod.POST)
    public ResponseEntity<Map<String, String>> createEventVoucher(
            @Valid @RequestBody EventVoucherDto eventVoucherDto,
            @RequestHeader("Authorization") String authorizationHeader) {

        // Get the brand ID from the JWT token
        UUID brandId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        // Create the event
        eventService.createEvent(brandId, eventDto);

        return ResponseEntity.ok(Map.of("message", "Event created successfully"));
    }
}
