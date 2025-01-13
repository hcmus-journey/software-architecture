package com.example.statisticservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@FeignClient(name = "event-service")
public interface EventClient {
    @GetMapping("/api/events/total")
    List<Long> getTotalQuizEventsAndShakeEvents();
}
