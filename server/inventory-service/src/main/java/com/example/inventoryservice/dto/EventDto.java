package com.example.inventoryservice.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Setter
@Getter
public class EventDto {

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private UUID eventId;

    @NotEmpty(message = "Name is required")
    private String name;

    @NotEmpty(message = "Image URL is required")
    private String imageUrl;

    @NotNull(message = "Start time is required")
    private LocalDate startTime;

    @NotNull(message = "End time is required")
    private LocalDate endTime;

    @NotEmpty(message = "Description is required")
    private String description;

    @NotNull(message = "Total vouchers is required")
    private Integer totalVouchers;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private Integer redeemedVouchers;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private String status;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private LocalDate createdAt;

    @NotNull(message = "Discount percentage is required")
    @Min(value = 0, message = "Discount percentage must be at least 0")
    @Max(value = 100, message = "Discount percentage must be at most 100")
    private Double discountPercentage;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private List<GameDto> games;
}
