package com.example.gameservice.entity;

import lombok.*;
import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.data.mongodb.core.mapping.Field;

import java.util.List;
import java.util.UUID;

@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Document(value = "quizzes")
public class Quiz {
    @Id
    @Field(value = "_id")
    public UUID quizId;

    @Field(value = "content")
    public String content;

    @Field(value = "options")
    public List<Option> options;
}