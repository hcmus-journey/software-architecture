package com.example.gameservice.repository;

import com.example.gameservice.entity.Quiz;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface QuizRepository extends MongoRepository<Quiz, UUID> {

}
