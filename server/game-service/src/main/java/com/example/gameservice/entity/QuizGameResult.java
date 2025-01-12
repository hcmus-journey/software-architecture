package com.example.gameservice.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.UUID;

@Setter
@Getter
@Builder
@AllArgsConstructor
@Document(collection = "quiz_game_results")
public class QuizGameResult {
    @Id
    private UUID id;

    @Field(name = "event_id")
    private UUID eventId;

    @Field(name = "player_id")
    private UUID playerId;

    @Field(name = "question_count")
    private Integer questionCount;

    @Field(name = "correct_answer_count")
    private Integer correctAnswerCount;
}
