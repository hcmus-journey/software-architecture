package com.example.gameservice.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
public class GameDto {

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private UUID gameId;

    private String description;

    private String imageUrl;

    private String name;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private String type;
}
