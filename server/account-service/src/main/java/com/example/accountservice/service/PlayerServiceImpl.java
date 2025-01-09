package com.example.accountservice.service;

import com.example.accountservice.dto.PlayerProfileDto;
import com.example.accountservice.entity.Player;
import com.example.accountservice.entity.User;
import com.example.accountservice.entity.UserStatus;
import com.example.accountservice.mapper.PlayerMapper;
import com.example.accountservice.repository.PlayerRepository;
import com.example.accountservice.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@AllArgsConstructor
public class PlayerServiceImpl implements PlayerService {

    final PlayerRepository playerRepository;
    final UserRepository userRepository;

    @Override
    public void updateProfile(UUID playerId, PlayerProfileDto playerProfileDto) {
        Player player = PlayerMapper.INSTANCE.convertToPlayer(playerProfileDto);
        player.setPlayerId(playerId);
        playerRepository.save(player);
    }

    @Transactional
    @Override
    public void activePlayer(UUID playerId, PlayerProfileDto playerProfileDto) {
        Player player = PlayerMapper.INSTANCE.convertToPlayer(playerProfileDto);

        player.setPlayerId(playerId);

        User user = userRepository.findByUserId(playerId);

        if (user == null) {
            throw new IllegalArgumentException("User not found with ID: " + playerId);
        }

        user.setStatus(UserStatus.ACTIVE);

        userRepository.save(user);

        playerRepository.save(player);
    }
}
