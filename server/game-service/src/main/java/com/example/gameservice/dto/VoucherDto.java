package com.example.gameservice.dto;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
public class VoucherDto {

    private UUID voucherId;

    private UUID playerId;

    private UUID eventId;

    private String code;

    private VoucherStatus status;

    private LocalDateTime receivedAt;

    private Double discount;

}