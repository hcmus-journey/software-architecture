package com.example.gameservice.entity;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

@Setter
@Getter
@AllArgsConstructor
@Document
public class Option {

    @Field(value = "content")
    private String content;

    @Field(value = "isCorrect")
    private Boolean isCorrect;
}