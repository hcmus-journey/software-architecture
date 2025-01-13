package com.example.gameservice.client;

import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.UUID;

@FeignClient(name = "inventory-service")
public interface InventoryClient {
    @PostMapping("/api/inventories/collect-coin")
    void collectCoin(@RequestParam UUID playerId, @RequestParam UUID eventId);
}
