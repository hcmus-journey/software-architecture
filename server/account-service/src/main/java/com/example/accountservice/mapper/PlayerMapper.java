package com.example.accountservice.mapper;

import com.example.accountservice.dto.PlayerProfileDto;
import com.example.accountservice.entity.Player;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface PlayerMapper {
    PlayerMapper INSTANCE = Mappers.getMapper(PlayerMapper.class);

    Player convertToPlayer(PlayerProfileDto playerProfileDto);
}
