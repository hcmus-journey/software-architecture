package com.example.accountservice.service;

import com.example.accountservice.dto.UserDto;
import com.example.accountservice.entity.User;
import com.example.accountservice.entity.UserRole;
import com.example.accountservice.entity.UserStatus;
import com.example.accountservice.mapper.UserMapper;
import com.example.accountservice.repository.UserRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class AdminServiceImpl implements AdminService{

    final private UserRepository userRepository;

    @Override
    public void deleteUser(UUID userId) {
        userRepository.deleteById(userId);
    }

    @Override
    public void setRole(UUID userId, UserRole role) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with ID: " + userId));
        user.setRole(role);
        userRepository.save(user);
    }

    @Override
    public void setStatus(UUID userId, UserStatus status) {
        User user = userRepository.findById(userId)
                .orElseThrow(() -> new IllegalArgumentException("User not found with ID: " + userId));
        user.setStatus(status);
        userRepository.save(user);
    }

    @Override
    public List<UserDto> getAllUsers() {
        return userRepository.findAll().stream().map(UserMapper.INSTANCE::convertToUserDto).toList();
    }

    @Override
    public List<Long> getTotalPlayersAndBrands() {
        List<Long> totalPlayersAndBrands = new ArrayList<>();
        totalPlayersAndBrands.add(userRepository.countByRole(UserRole.PLAYER));
        totalPlayersAndBrands.add(userRepository.countByRole(UserRole.BRAND));
        return totalPlayersAndBrands;
    }
}
