package com.example.gameservice.repository;

import com.example.gameservice.entity.ShakeGameResult;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface ShakeGameResultRepository extends MongoRepository<ShakeGameResult, UUID> {
}
