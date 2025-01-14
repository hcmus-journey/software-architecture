package com.example.inventoryservice.controller;

import com.example.inventoryservice.dto.GiftCoinRequest;
import com.example.inventoryservice.dto.ShakeGameInventoryDto;
import com.example.inventoryservice.dto.VoucherDto;
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
    public ResponseEntity<List<ShakeGameInventoryDto>> getShakeGameInventory(
            @RequestHeader("Authorization") String token) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(token);

        return ResponseEntity.ok(inventoryService.getInventory(playerId));
    }

    @RequestMapping(value = "/{inventoryId}/exchange-coin", method = RequestMethod.POST)
    @Operation(tags = "Player", summary = "Exchange coin", description = "Exchange coin for voucher")
    public ResponseEntity<VoucherDto> exchangeCoin(
            @PathVariable String inventoryId,
            @RequestHeader("Authorization") String token) {
        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(token);
        return ResponseEntity.ok(inventoryService.exchangeCoin(playerId, UUID.fromString(inventoryId)));
    }

    @RequestMapping(value = "/{inventoryId}/gift-coin", method = RequestMethod.POST)
    @Operation(tags = "Player", summary = "Gift coin", description = "Gift coin to another player")
    public ResponseEntity<Void> giftCoin(
            @PathVariable String inventoryId,
            @RequestBody GiftCoinRequest giftCoinRequest,
            @RequestHeader("Authorization") String token) {
        UUID currentUserId = jwtUtil.getUserIdFromAuthorizationHeader(token);
        inventoryService.giftCoin(currentUserId, giftCoinRequest, UUID.fromString(inventoryId));
        return ResponseEntity.ok().build();
    }
}
