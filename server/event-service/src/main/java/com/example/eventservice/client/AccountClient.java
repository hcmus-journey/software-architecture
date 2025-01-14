package com.example.eventservice.client;

import com.example.eventservice.dto.BrandDto;
import org.springframework.cloud.openfeign.FeignClient;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

@FeignClient(name = "account-service")
public interface AccountClient {
    @GetMapping("/api/brand/{brandId}")
    BrandDto getBrandInfo(@PathVariable String brandId);
}
