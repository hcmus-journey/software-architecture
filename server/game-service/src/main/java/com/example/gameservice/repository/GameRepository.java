package com.example.gameservice.repository;

import com.example.gameservice.entity.Game;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.UUID;

public interface GameRepository extends MongoRepository<Game, UUID> {
}
