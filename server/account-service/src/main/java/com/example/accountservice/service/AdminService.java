package com.example.accountservice.service;

import com.example.accountservice.dto.UserDto;
import com.example.accountservice.entity.UserRole;
import com.example.accountservice.entity.UserStatus;

import java.util.List;
import java.util.UUID;

public interface AdminService {
    void deleteUser(UUID userId);
    void setRole(UUID userId, UserRole role);
    void setStatus(UUID userId, UserStatus status);
    List<UserDto> getAllUsers();
}
