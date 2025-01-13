package com.example.voucherservice.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "vouchers")
public class Voucher {
    @Id
    @GeneratedValue(strategy = GenerationType.UUID)
    @Column(name = "voucher_id", nullable = false)
    private UUID voucherId;

    @NotNull
    @Column(name = "player_id", nullable = false)
    private UUID playerId;

    @NotNull
    @Column(name = "event_id", nullable = false)
    private UUID eventId;

    @Size(max = 255)
    @NotNull
    @Column(name = "code", nullable = false)
    private String code;

    @NotNull
    @Enumerated(EnumType.STRING)
    @Column(name = "status", nullable = false)
    private VoucherStatus status;

    @NotNull
    @Column(name = "received_at", nullable = false)
    private LocalDateTime receivedAt;

    @NotNull
    @Column(name = "expired_at", nullable = false)
    private LocalDateTime expiredAt;

    @NotNull
    @Column(name = "discount")
    private Double discount;

}