package com.example.voucherservice.dto;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.ColumnDefault;

import java.util.UUID;

@Getter
@Setter
@AllArgsConstructor
public class EventVoucherDto {

    private UUID eventId;

    private Integer redeemedVouchers;

    private Integer totalVouchers;

    private Double discountPercentage;

}
