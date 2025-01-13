package com.example.gameservice.repository;

import com.example.gameservice.entity.Quiz;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface QuizRepository extends MongoRepository<Quiz, UUID> {

}
