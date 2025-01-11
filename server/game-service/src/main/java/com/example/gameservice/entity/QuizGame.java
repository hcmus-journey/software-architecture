package com.example.gameservice.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
@Document(collection = "quiz_games")
public class QuizGame {
    @Id
    private UUID id;

    @Field(name = "event_id")
    private UUID eventId;

    @Field(name = "game_id")
    private UUID gameId;

    @Field(name = "question_count")
    private Integer questionCount;
}
