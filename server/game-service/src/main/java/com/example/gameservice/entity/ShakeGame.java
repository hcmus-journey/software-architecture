package com.example.gameservice.entity;



import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.UUID;

@Document(collection = "shake_games")
public class ShakeGame {
    @Id
    private UUID id;

    @Field(name = "event_id")
    private UUID eventId;

    @Field(name = "game_id")
    private UUID gameId;

    @Field(name = "required_coins")
    private Integer requiredCoins;

    @Field(name = "coin_drop_rate")
    private Double coinDropRate;
}
