package com.example.eventservice.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "quiz_game_events")
public class QuizGameEvent {
    @Id
    @Column(name = "event_id", nullable = false)
    private UUID eventId;

    @Column(name = "game_id", nullable = false)
    private UUID gameId;

    @Column(name = "question_count", nullable = false)
    private Integer questionCount;

}