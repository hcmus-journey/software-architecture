package com.example.gameservice.repository;

import com.example.gameservice.entity.QuizGameResult;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface QuizGameResultRepository extends MongoRepository<QuizGameResult, UUID> {

}
