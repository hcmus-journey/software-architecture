package com.example.accountservice.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.UUID;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class BrandProfileDto {

    @JsonProperty(access = JsonProperty.Access.READ_ONLY)
    private UUID brandId;

    @NotEmpty(message = "Name is required")
    private String name;

    @NotEmpty(message = "Business field is required")
    private String businessField;

    private String imageUrl;

    @NotEmpty(message = "Address is required")
    private String address;

    private Double gpsLatitude;

    private Double gpsLongitude;
}
