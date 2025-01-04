package com.example.accountservice.service;

import com.example.accountservice.dto.*;

public interface UserService {
    LoginResponse login(LoginRequest loginRequest);
    SignUpResponse signUp(SignUpRequest signUpRequest);
    RefreshTokenResponse refreshToken(RefreshTokenRequest refreshTokenRequest);
}
