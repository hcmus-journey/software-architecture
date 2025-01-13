package com.example.inventoryservice.security;


import lombok.Getter;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Getter
@Setter
@Configuration
@ConfigurationProperties(prefix = "jwt")
public class JwtProperties {

    private String issuer;

    private String accessTokenSecretKey;

    private String refreshTokenSecretKey;

    private long accessTokenExpirationMinute;

    private long refreshTokenExpirationDay;

}
