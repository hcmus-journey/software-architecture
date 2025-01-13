package com.example.accountservice.controller;

import com.example.accountservice.dto.UserDto;
import com.example.accountservice.entity.UserRole;
import com.example.accountservice.entity.UserStatus;
import com.example.accountservice.service.AdminService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@RequestMapping("/api/admin")
@RestController
@AllArgsConstructor
public class AdminController {

    private final AdminService adminService;

    @GetMapping("/users")
    @Operation(tags = "Admin", description = "Get all users")
    public ResponseEntity<List<UserDto>> getAllUser() {
        return ResponseEntity.ok(adminService.getAllUsers());
    }

    @PostMapping("/users/{userId}/status")
    @Operation(tags = "Admin", description = "Set user status. Available status: BANNED, ACTIVE, INACTIVE")
    public ResponseEntity<Map<String, String>> setUserStatus(@Valid @PathVariable String userId, @RequestParam UserStatus status) {

        adminService.setStatus(UUID.fromString(userId) , status);

        return ResponseEntity.ok(Map.of("message", "User status has been set"));
    }

    @PostMapping("/users/{userId}/role")
    @Operation(tags = "Admin", description = "Set user role. Available role: ADMIN, USER")
    public ResponseEntity<Map<String, String>> setUserRole(@Valid @PathVariable String userId, @RequestParam UserRole role) {

        adminService.setRole(UUID.fromString(userId), role);

        return ResponseEntity.ok(Map.of("message", "User role has been set"));
    }

    @GetMapping("/users/total-players-brands")
    @Operation(hidden = true)
    public ResponseEntity<List<Long>> getTotalPlayersAndBrands() {

        return ResponseEntity.ok(adminService.getTotalPlayersAndBrands());
    }
}
