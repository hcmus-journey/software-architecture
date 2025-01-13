package com.example.inventoryservice.controller;

import com.example.inventoryservice.dto.ShakeGameInventoryDto;
import com.example.inventoryservice.security.JwtUtil;
import com.example.inventoryservice.service.InventoryService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/inventories")
@AllArgsConstructor
public class InventoryController {
    final private JwtUtil jwtUtil;

    final private InventoryService inventoryService;

    @RequestMapping(value = "/collect-coin", method = RequestMethod.POST)
    @Operation(hidden = true)
    public void collectCoin(@RequestParam UUID playerId, @RequestParam UUID eventId) {

        inventoryService.collectCoin(playerId, eventId);
    }

    @RequestMapping(method = RequestMethod.GET)
    public ResponseEntity<List<ShakeGameInventoryDto>> getShakeGameInventory(@RequestHeader("Authorization") String token) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(token);

        return ResponseEntity.ok(inventoryService.getInventory(playerId));
    }

}
