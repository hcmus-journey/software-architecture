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
@Document(value = "games")
public class Game {
    @Id
    @Field(value = "_id")
    public UUID gameId;

    @Field(value = "description")
    public String description;

    @Field(value = "type")
    public String type;

    @Field(value = "image_url")
    public String imageUrl;

    @Field(value = "name")
    public String name;

}