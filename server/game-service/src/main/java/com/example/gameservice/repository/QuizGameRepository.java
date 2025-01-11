package com.example.gameservice.repository;

import com.example.gameservice.entity.QuizGame;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface QuizGameRepository extends MongoRepository<QuizGame, UUID> {

}
