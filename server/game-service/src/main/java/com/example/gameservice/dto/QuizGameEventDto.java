package com.example.gameservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
public class QuizGameEventDto {
    private UUID eventId;

    private UUID gameId;

    private Integer questionCount;
}
