package com.example.voucherservice.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "event_vouchers")
public class EventVoucher {
    @Id
    @Column(name = "event_id", nullable = false)
    private UUID eventId;

    @NotNull
    @ColumnDefault("0")
    @Column(name = "redeemed_vouchers", nullable = false)
    private Integer redeemedVouchers;

    @NotNull
    @Column(name = "total_vouchers", nullable = false)
    private Integer totalVouchers;

    @NotNull
    @Column(name = "discount_percentage", nullable = false)
    private Double discountPercentage;

}