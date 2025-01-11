package com.example.gameservice.mapper;

import com.example.gameservice.dto.GameDto;
import com.example.gameservice.entity.Game;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface GameMapper {
    GameMapper INSTANCE = Mappers.getMapper(GameMapper.class);

    GameDto convertToGameDto(Game game);
}
