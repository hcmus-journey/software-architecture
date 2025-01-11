package com.example.accountservice.service;

import com.example.accountservice.dto.BrandProfileDto;

import java.util.UUID;

public interface BrandService {
    void updateProfile(UUID brandID, BrandProfileDto brandProfileDto);
    void activeBrand(UUID brandID, BrandProfileDto brandProfileDto);
}
