package com.example.voucherservice.client;


import com.example.voucherservice.dto.EventDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "event-service")
public interface EventClient {
    @GetMapping("/api/events/{eventId}")
    EventDto getEvent(@PathVariable String eventId);
}
