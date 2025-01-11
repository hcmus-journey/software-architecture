package com.example.gameservice.dto;

import com.example.gameservice.entity.Option;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.List;
import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
public class QuizDto {

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private UUID quizId;

    private String content;

    private List<Option> options;
}
