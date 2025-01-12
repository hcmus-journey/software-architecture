package com.example.gameservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
public class ShakeGameDto {
    private UUID eventId;

    private Integer requiredCoins;

    private Double coinDropRate;
}
