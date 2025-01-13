package com.example.eventservice.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UpdateEventStatusRequest {
    @NotEmpty(message = "Status is required")
    @Schema(description = "The status of the event", allowableValues = {"ACCEPTED", "NOT_ACCEPTED"})
    private String status;
}
