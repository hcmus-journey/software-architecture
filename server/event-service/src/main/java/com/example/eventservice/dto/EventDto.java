package com.example.eventservice.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

import java.time.Instant;
import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
public class EventDto {

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private UUID eventId;

    @NotEmpty(message = "Name is required")
    private String name;

    @NotEmpty(message = "Image URL is required")
    private String imageUrl;

    @NotEmpty(message = "Start time is required")
    private Instant startTime;

    @NotEmpty(message = "End time is required")
    private Instant endTime;

    @NotEmpty(message = "Description is required")
    private String description;

    @NotEmpty(message = "Total vouchers is required")
    private Integer totalVouchers;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private Integer distributedVouchers;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private String status;

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private Instant createdAt;

    @NotEmpty(message = "Discount percentage is required")
    private Double discountPercentage;
}
