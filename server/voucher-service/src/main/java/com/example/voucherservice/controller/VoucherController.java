package com.example.voucherservice.controller;

import com.example.voucherservice.dto.EventVoucherDto;
import com.example.voucherservice.dto.UseVoucherRequest;
import com.example.voucherservice.dto.VoucherDto;
import com.example.voucherservice.security.JwtUtil;
import com.example.voucherservice.service.EventVoucherService;
import com.example.voucherservice.service.VoucherService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController
@RequestMapping("/api/vouchers")
@AllArgsConstructor
public class VoucherController {

    final private EventVoucherService eventVoucherService;

    final private VoucherService voucherService;

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

    @RequestMapping(value = "", method = RequestMethod.POST)
    @Operation(hidden = true)
    public ResponseEntity<VoucherDto> distributeVoucher(@RequestParam UUID eventId, @RequestParam UUID playerId) {
        VoucherDto voucherDto = voucherService.distributeVoucher(eventId, playerId);

        return ResponseEntity.ok(voucherDto);
    }

    @RequestMapping(method = RequestMethod.GET)
    @Operation(tags = "Player", description = "Get all vouchers for a player")
    public ResponseEntity<List<VoucherDto>> getVouchers(
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);
        return ResponseEntity.ok(voucherService.getVouchers(playerId));
    }

    @RequestMapping(value = "/{voucherId}", method = RequestMethod.GET)
    @Operation(tags = "Player", description = "Get voucher by voucher id")
    public ResponseEntity<VoucherDto> getVoucher(
            @PathVariable String voucherId,
            @RequestHeader("Authorization") String authorizationHeader) {

        return ResponseEntity.ok(voucherService.getVoucher(UUID.fromString(voucherId)));
    }

    @RequestMapping(value = "/use", method = RequestMethod.PUT)
    @Operation(tags = "Brand", description = "Get voucher from player and mark it as used")
    public ResponseEntity<VoucherDto> applyDiscount(
            @RequestBody UseVoucherRequest useVoucherRequest,
            @RequestHeader("Authorization") String authorizationHeader) {
        VoucherDto voucherDto = voucherService
                .useVoucher(
                        UUID.fromString(useVoucherRequest.getEventId()),
                        useVoucherRequest.getVoucherCode()
                );
        return ResponseEntity.ok(voucherDto);
    }

}
