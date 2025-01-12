package com.example.gameservice.repository;

import com.example.gameservice.entity.ShakeGameResult;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface ShakeGameResultRepository extends MongoRepository<ShakeGameResult, UUID> {
}
