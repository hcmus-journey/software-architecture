package com.example.gameservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
public class QuizGameDto {
    private Integer questionCount;

    private UUID eventId;

}
