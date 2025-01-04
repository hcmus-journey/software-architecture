package com.example.accountservice.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.example.accountservice.entity.User;
import com.example.accountservice.exception.BadRequestException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
@RequiredArgsConstructor
public class JwtUtil {

    private final JwtProperties jwtProperties;

    private String generateToken(User user, long expirationTimeMs, Algorithm algorithm) {
        return JWT.create()
                .withSubject(user.getUserId().toString())
                .withIssuer(jwtProperties.getIssuer())
                .withClaim("username", user.getUsername())
                .withClaim("role", user.getRole().name())
                .withClaim("id", user.getUserId().toString())
                .withIssuedAt(new Date())
                .withExpiresAt(new Date(System.currentTimeMillis() + expirationTimeMs))
                .sign(algorithm);
    }

    public Algorithm getAlgorithm(String secretKey) {
        return Algorithm.HMAC256(secretKey.getBytes());
    }

    public String generateAccessToken(User user) {
        return generateToken(user,
                jwtProperties.getAccessTokenExpirationMinute() * 60 * 1000,
                getAlgorithm(jwtProperties.getAccessTokenSecretKey())
        );
    }

    public String generateRefreshToken(User user) {
        return generateToken(user,
                jwtProperties.getRefreshTokenExpirationDay() * 24 * 60 * 60 * 1000,
                getAlgorithm(jwtProperties.getRefreshTokenSecretKey())
        );

    }

    public Claim getClaimFromToken(String token, String claimName, Algorithm algorithm) {
        try {
            return JWT.require(algorithm)
                    .build()
                    .verify(token)
                    .getClaim(claimName);
        } catch (Exception e) {
            throw new BadRequestException("Invalid token");
        }
    }

    public boolean validateToken(String token, Algorithm algorithm) {
        Claim expirationClaim = getClaimFromToken(token, "exp", algorithm);
        return !expirationClaim.asDate().before(new Date());
    }

    public boolean validateRefreshToken(String token) {
        return validateToken(token, getAlgorithm(jwtProperties.getRefreshTokenSecretKey()));
    }

    public String getUserNameFromRefreshToken(String refreshToken) {
        return getClaimFromToken(refreshToken, "username", getAlgorithm(jwtProperties.getRefreshTokenSecretKey())).asString();
    }
}
