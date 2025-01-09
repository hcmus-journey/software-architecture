package com.example.accountservice.service;

import com.example.accountservice.dto.PlayerProfileDto;

import java.util.UUID;

public interface PlayerService {
    void updateProfile(UUID playerId, PlayerProfileDto playerProfileDto);
    void activePlayer(UUID playerId, PlayerProfileDto playerProfileDto);
}
