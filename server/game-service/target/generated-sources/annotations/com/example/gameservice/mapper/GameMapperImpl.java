package com.example.gameservice.mapper;

import com.example.gameservice.dto.GameDto;
import com.example.gameservice.entity.Game;
import java.util.UUID;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-01-13T01:55:53+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23.0.1 (Oracle Corporation)"
)
public class GameMapperImpl implements GameMapper {

    @Override
    public GameDto convertToGameDto(Game game) {
        if ( game == null ) {
            return null;
        }

        UUID gameId = null;
        String description = null;
        String imageUrl = null;
        String name = null;
        String type = null;

        gameId = game.getGameId();
        description = game.getDescription();
        imageUrl = game.getImageUrl();
        name = game.getName();
        type = game.getType();

        GameDto gameDto = new GameDto( gameId, description, imageUrl, name, type );

        return gameDto;
    }
}
