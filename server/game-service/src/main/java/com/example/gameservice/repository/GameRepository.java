package com.example.gameservice.repository;

import com.example.gameservice.entity.Game;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface GameRepository extends MongoRepository<Game, UUID> {
    List<Game> findByType(String type);
}
