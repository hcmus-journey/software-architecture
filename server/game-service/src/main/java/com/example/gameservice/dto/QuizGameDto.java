package com.example.gameservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.web.bind.annotation.RequestPart;

@Getter
@Setter
@AllArgsConstructor
public class QuizGameDto {
    private String eventId;

    private Integer questionCount;

    private Integer correctAnswerCount;
}
