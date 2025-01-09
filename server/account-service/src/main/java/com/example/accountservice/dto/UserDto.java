package com.example.accountservice.dto;

import com.example.accountservice.entity.UserRole;
import com.example.accountservice.entity.UserStatus;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@AllArgsConstructor
@Setter
@Getter
public class UserDto {

    private UUID userId;

    private String username;

    private UserRole role;

    private UserStatus status;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
