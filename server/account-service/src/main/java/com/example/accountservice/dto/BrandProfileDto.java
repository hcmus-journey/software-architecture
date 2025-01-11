package com.example.accountservice.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class BrandProfileDto {

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
