package com.example.accountservice.controller;

import com.example.accountservice.dto.BrandProfileDto;
import com.example.accountservice.security.JwtUtil;
import com.example.accountservice.service.BrandService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;
import java.util.UUID;

@RequestMapping("/api/brand")
@RestController
@AllArgsConstructor
public class BrandController {

    final private JwtUtil jwtUtil;

    final private BrandService brandService;

    @RequestMapping(path = "/profile", method = RequestMethod.PUT)
    @Operation(tags = "Brand", description = "Update brand profile")
    public ResponseEntity<Map<String, String>> updateProfileRequest(
            @Valid @RequestBody BrandProfileDto brandProfileDto,
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        brandService.updateProfile(playerId, brandProfileDto);

        return ResponseEntity.ok(Map.of("message", "Profile updated successfully"));
    }

    @RequestMapping(path = "/active", method = RequestMethod.POST)
    @Operation(tags = "Brand", description = "Activate brand")
    public ResponseEntity<Map<String, String>> activeBrandRequest(
            @Valid @RequestBody BrandProfileDto brandProfileDto,
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        brandService.activeBrand(playerId, brandProfileDto);

        return ResponseEntity.ok(Map.of("message", "Brand activated successfully"));
    }

    @RequestMapping(path = "/profile", method = RequestMethod.GET)
    @Operation(tags = "Brand", description = "Get brand profile")
    public ResponseEntity<BrandProfileDto> getBrandProfile(
            @RequestHeader("Authorization") String authorizationHeader) {

        UUID playerId = jwtUtil.getUserIdFromAuthorizationHeader(authorizationHeader);

        BrandProfileDto brandProfileDto = brandService.getBrandProfile(playerId);

        return ResponseEntity.ok(brandProfileDto);
    }

    @RequestMapping(path = "/{brandId}", method = RequestMethod.GET)
    @Operation(hidden = true)
    public ResponseEntity<BrandProfileDto> getBrandInfo(
            @PathVariable String brandId) {

        BrandProfileDto brandProfileDto = brandService.getBrandProfile(UUID.fromString(brandId));

        return ResponseEntity.ok(brandProfileDto);
    }
}
