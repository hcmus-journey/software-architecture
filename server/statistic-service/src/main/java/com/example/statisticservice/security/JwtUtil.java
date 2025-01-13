package com.example.statisticservice.security;

import com.auth0.jwt.JWT;
import com.auth0.jwt.algorithms.Algorithm;
import com.example.statisticservice.constants.SecurityConstants;
import com.example.statisticservice.exception.BadRequestException;
import lombok.RequiredArgsConstructor;
import org.apache.logging.log4j.util.Strings;
import org.springframework.stereotype.Component;

import java.util.UUID;

@Component
@RequiredArgsConstructor
public class JwtUtil {

    private final JwtProperties jwtProperties;

    public Algorithm getAlgorithm(String secretKey) {
        return Algorithm.HMAC256(secretKey.getBytes());
    }
    
    public String extractTokenFromAuthorizationHeader(String authorizationHeader) {
        return authorizationHeader.replace(SecurityConstants.TOKEN_PREFIX, Strings.EMPTY);
    }

    public  UUID getUserIdFromAuthorizationHeader(String authorizationHeader) {
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
}
