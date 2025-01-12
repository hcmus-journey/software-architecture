package com.example.voucherservice.controller;

import com.example.voucherservice.dto.EventVoucherDto;
import com.example.voucherservice.security.JwtUtil;
import com.example.voucherservice.service.EventVoucherService;
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

    @RequestMapping(value = "/event-voucher-detail", method = RequestMethod.POST)
    @Operation(hidden = true)
    public ResponseEntity<Map<String, String>> createEventVoucherDetails(
            @Valid @RequestBody EventVoucherDto eventVoucherDto) {

        eventVoucherService.createEventVoucher(eventVoucherDto);

        return ResponseEntity.ok(Map.of("message", "Event voucher created successfully"));
    }

    @RequestMapping(value = "/event-voucher-detail/{id}", method = RequestMethod.DELETE)
    @Operation(hidden = true)
    public ResponseEntity<Void> deleteEventVoucherDetails(
            @PathVariable String id) {
        eventVoucherService.deleteEventVoucher(UUID.fromString(id));

        return ResponseEntity.ok().build();
    }

    @RequestMapping(value = "/event-voucher-detail", method = RequestMethod.PUT)
    @Operation(hidden = true)
    public ResponseEntity<Void> deleteEventVoucherDetails(
            @Valid @RequestBody EventVoucherDto eventVoucherDto) {
        eventVoucherService.updateEventVoucher(eventVoucherDto);
        return ResponseEntity.ok().build();
    }

    @RequestMapping(value = "/event-voucher-detail/{id}", method = RequestMethod.GET)
    @Operation(hidden = true)
    public ResponseEntity<EventVoucherDto> getEventVoucherDetails(
            @PathVariable String id) {
        EventVoucherDto eventVoucherDto = eventVoucherService.getEventVoucher(UUID.fromString(id));

        return ResponseEntity.ok(eventVoucherDto);
    }
}
