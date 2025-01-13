package com.example.gameservice.repository;

import com.example.gameservice.entity.QuizGameResult;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RestController;

import java.util.UUID;

@Repository
public interface QuizGameResultRepository extends MongoRepository<QuizGameResult, UUID> {

}
