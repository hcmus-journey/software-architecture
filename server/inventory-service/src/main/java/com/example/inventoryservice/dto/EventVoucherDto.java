package com.example.inventoryservice.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
@Builder
public class EventVoucherDto {

    private UUID eventId;

    private Integer redeemedVouchers;

    private Integer totalVouchers;

    private Double discountPercentage;

}
