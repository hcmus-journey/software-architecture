package com.example.accountservice.mapper;

import com.example.accountservice.dto.PlayerProfileDto;
import com.example.accountservice.entity.Player;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-01-13T01:44:56+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23.0.1 (Oracle Corporation)"
)
public class PlayerMapperImpl implements PlayerMapper {

    @Override
    public Player convertToPlayer(PlayerProfileDto playerProfileDto) {
        if ( playerProfileDto == null ) {
            return null;
        }

        Player.PlayerBuilder player = Player.builder();

        player.name( playerProfileDto.getName() );
        player.email( playerProfileDto.getEmail() );
        player.phoneNumber( playerProfileDto.getPhoneNumber() );
        player.avatarUrl( playerProfileDto.getAvatarUrl() );
        player.birthday( playerProfileDto.getBirthday() );
        player.gender( playerProfileDto.getGender() );

        return player.build();
    }

    @Override
    public PlayerProfileDto convertToPlayerProfileDto(Player player) {
        if ( player == null ) {
            return null;
        }

        PlayerProfileDto playerProfileDto = new PlayerProfileDto();

        playerProfileDto.setName( player.getName() );
        playerProfileDto.setEmail( player.getEmail() );
        playerProfileDto.setPhoneNumber( player.getPhoneNumber() );
        playerProfileDto.setAvatarUrl( player.getAvatarUrl() );
        playerProfileDto.setBirthday( player.getBirthday() );
        playerProfileDto.setGender( player.getGender() );

        return playerProfileDto;
    }
}
