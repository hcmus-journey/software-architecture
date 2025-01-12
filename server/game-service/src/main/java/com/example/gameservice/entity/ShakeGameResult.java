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
@Document(collection = "shake_game_results")
public class ShakeGameResult {
    @Id
    private UUID id;

    @Field(name = "event_id")
    private UUID eventId;

    @Field(name = "player_id")
    private UUID playerId;

    @Field(name = "is_drop")
    private Boolean isDrop;
}
