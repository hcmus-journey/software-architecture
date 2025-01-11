package com.example.accountservice.controller;


import com.example.accountservice.dto.*;
import com.example.accountservice.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import jakarta.validation.Valid;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
@AllArgsConstructor
public class AuthController {

    private final UserService userService;

    @PostMapping("/sign-up")
    @Operation(tags = "Authentication", description = "Sign up to the system")
    public ResponseEntity<SignUpResponse> brandSignUpRequest(@Valid @RequestBody SignUpRequest signUpRequest) {

        final SignUpResponse signUpResponse = userService.signUp(signUpRequest);

        return ResponseEntity.ok(signUpResponse);
    }

    @PostMapping("/login")
    @Operation(tags = "Authentication", description = "Login to the system")
    public ResponseEntity<LoginResponse> adminLoginRequest(@Valid @RequestBody LoginRequest loginRequest) {

        final LoginResponse loginResponse = userService.login(loginRequest);

        return ResponseEntity.ok(loginResponse);
    }

    @PostMapping("/refresh-token")
    @Operation(tags = "Authentication", description = "Refresh access token")
    public ResponseEntity<RefreshTokenResponse> refreshToken(@Valid @RequestBody RefreshTokenRequest refreshTokenRequest) {
        return ResponseEntity.ok(userService.refreshToken(refreshTokenRequest));
    }
}
