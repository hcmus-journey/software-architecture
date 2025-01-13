package com.example.inventoryservice.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.example.inventoryservice.constants.SecurityConstants;
import com.example.inventoryservice.exception.BadRequestException;
import lombok.RequiredArgsConstructor;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.UUID;

@Component
@RequiredArgsConstructor
public class JwtUtil {

    private final JwtProperties jwtProperties;

    public Algorithm getAlgorithm(String secretKey) {
        return Algorithm.HMAC256(secretKey.getBytes());
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

    public String extractTokenFromAuthorizationHeader(String authorizationHeader) {
        return authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);
    }

    public UUID getUserIdFromAuthorizationHeader(String authorizationHeader) {
        try {
            String token = extractTokenFromAuthorizationHeader(authorizationHeader);
            return UUID.fromString(JWT.require(getAlgorithm(jwtProperties.getAccessTokenSecretKey()))
                    .build()
                    .verify(token)
                    .getSubject());
        } catch (Exception e) {
            throw new BadRequestException("Invalid token");
        }
    }

    public UserRole getUserRoleFromAuthorizationHeader(String authorizationHeader) {
        try {
            String token = extractTokenFromAuthorizationHeader(authorizationHeader);
            return UserRole.valueOf(JWT.require(getAlgorithm(jwtProperties.getAccessTokenSecretKey()))
                    .build()
                    .verify(token)
                    .getClaim("role")
                    .asString());
        } catch (Exception e) {
            throw new BadRequestException("Invalid token");
        }
    }
}
