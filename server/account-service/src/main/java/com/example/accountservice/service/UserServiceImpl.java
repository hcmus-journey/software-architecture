package com.example.accountservice.service;

import com.example.accountservice.dto.*;
import com.example.accountservice.entity.User;
import com.example.accountservice.entity.UserRole;
import com.example.accountservice.entity.UserStatus;
import com.example.accountservice.exception.BadRequestException;
import com.example.accountservice.mapper.UserMapper;
import com.example.accountservice.repository.UserRepository;
import com.example.accountservice.security.JwtUtil;
import lombok.AllArgsConstructor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.EnumSet;
import java.util.Optional;
import java.util.Set;

@Service
@AllArgsConstructor
public class UserServiceImpl implements UserService{

    private final UserRepository userRepository;

    private final BCryptPasswordEncoder bCryptPasswordEncoder;

    private final JwtUtil jwtUtil;

    @Override
    public LoginResponse login(LoginRequest loginRequest) {
        // Extract the username and password from the request
        String username = loginRequest.getUsername();
        String password = loginRequest.getPassword();

        // Fetch the user and handle the case when the user is not found
        User user = Optional.ofNullable(userRepository.findByUsername(username))
                .orElseThrow(() -> new BadRequestException("User not found!"));

        // Validate the password
        if (!bCryptPasswordEncoder.matches(password, user.getPassword())) {
            throw new BadRequestException("Invalid password!");
        }

        // Generate access and refresh tokens
        String accessToken = jwtUtil.generateAccessToken(user);
        String refreshToken = jwtUtil.generateRefreshToken(user);

        // Return response with generated tokens
        return new LoginResponse(accessToken, refreshToken);
    }

    @Override
    public SignUpResponse signUp(SignUpRequest signUpRequest) {
        // Define allowed roles
        final Set<UserRole> ALLOWED_ROLES = EnumSet.of(UserRole.BRAND, UserRole.PLAYER);

        // Extract the username and role from the request
        String username = signUpRequest.getUsername();
        String userRoleStr = signUpRequest.getRole();

        // Check if the username already exists
        if (userRepository.existsByUsername(username)) {
            throw new BadRequestException("Username already exists!");
        }

        // Validate and map the role
        UserRole userRole;
        try {
            userRole = UserRole.valueOf(userRoleStr.toUpperCase());
        } catch (IllegalArgumentException e) {
            throw new BadRequestException("Invalid role provided!");
        }

        // Ensure the role is allowed
        if (!ALLOWED_ROLES.contains(userRole)) {
            throw new BadRequestException("Role not allowed!");
        }

        // Map the request to a User entity and initialize its fields
        User user = UserMapper.INSTANCE.convertToUser(signUpRequest);
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRole(userRole); // Assign the validated role as an Enum
        user.setStatus(UserStatus.INACTIVE);

        LocalDateTime now = LocalDateTime.now();
        user.setCreatedAt(now);
        user.setUpdatedAt(now);

        // Save the user to the repository
        userRepository.save(user);

        // Return a success response
        return new SignUpResponse("Registration successful!");
    }

    @Override
    public RefreshTokenResponse refreshToken(RefreshTokenRequest refreshTokenRequest) {

        // Extract the refresh token from the request
        String refreshToken = refreshTokenRequest.getRefreshToken();

        // Validate the refresh token
        if (!jwtUtil.validateRefreshToken(refreshToken)) {
            throw new BadRequestException("Invalid token!");
        }

        // Extract username from the refresh token
        String username = jwtUtil.getUserNameFromRefreshToken(refreshToken);

        // Fetch the user and throw an exception if not found
        User user = Optional.ofNullable(userRepository.findByUsername(username))
                .orElseThrow(() -> new BadRequestException("Invalid token!"));

        // Generate and return a new access token
        return new RefreshTokenResponse(jwtUtil.generateAccessToken(user));
    }
}
