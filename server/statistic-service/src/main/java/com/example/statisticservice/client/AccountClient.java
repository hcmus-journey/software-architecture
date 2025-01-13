package com.example.statisticservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@FeignClient(name = "account-service")
public interface AccountClient {
    @GetMapping("/api/admin/users/total-players-brands")
    List<Long> getTotalPlayersAndBrands();
}
