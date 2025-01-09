package com.example.accountservice.service;

import com.example.accountservice.dto.GetUsersResponse;
import com.example.accountservice.entity.UserRole;
import com.example.accountservice.entity.UserStatus;

import java.util.UUID;

public interface AdminService {
    void deleteUser(UUID userId);
    void setRole(UUID userId, UserRole role);
    void setStatus(UUID userId, UserStatus status);
    GetUsersResponse getAllUsers();
}
