package com.example.inventoryservice.dto;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@Builder
public class ShakeGameInventoryDto {

    private UUID inventoryId;

    private UUID eventId;

    private String eventName;

    private Integer collectedCoins;

    private Integer requiredCoins;
}