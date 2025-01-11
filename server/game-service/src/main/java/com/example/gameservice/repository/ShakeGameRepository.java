package com.example.gameservice.repository;

import com.example.gameservice.entity.ShakeGame;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface ShakeGameRepository extends MongoRepository<ShakeGame, UUID> {
}
