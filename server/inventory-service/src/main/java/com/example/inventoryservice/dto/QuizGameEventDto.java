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
public class QuizGameEventDto {
    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private UUID eventId;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private UUID gameId;

    @NotNull(message = "Question count is required")
    private Integer questionCount;
}
