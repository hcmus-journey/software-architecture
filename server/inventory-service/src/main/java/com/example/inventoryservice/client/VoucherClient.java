package com.example.inventoryservice.client;


import com.example.inventoryservice.dto.EventVoucherDto;
import jakarta.validation.Valid;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.*;

@FeignClient(name = "voucher-service")
public interface VoucherClient {
    @PostMapping("/api/vouchers/event-voucher-detail")
    void createEventVoucherDetails(
            @Valid @RequestBody EventVoucherDto eventVoucherDto);

    @RequestMapping(value = "/api/vouchers/event-voucher-detail/{id}", method = RequestMethod.DELETE)
    void deleteEventVoucherDetails(@PathVariable String id);

    @PutMapping("/api/vouchers/event-voucher-detail")
    void updateEventVoucherDetails(
            @Valid @RequestBody EventVoucherDto eventVoucherDto);

    @GetMapping("/api/vouchers/event-voucher-detail/{id}")
    EventVoucherDto getEventVoucherDetails(@PathVariable String id);
}
