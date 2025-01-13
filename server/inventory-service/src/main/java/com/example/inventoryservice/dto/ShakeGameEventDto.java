package com.example.inventoryservice.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
public class ShakeGameEventDto {
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private UUID eventId;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private UUID gameId;

    @NotNull(message = "Name is required")
    private Integer requiredCoins;

    @NotNull(message = "Coin drop rate is required")
    private Double coinDropRate;
}
