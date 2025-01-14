package com.example.eventservice.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
public class BrandDto {

        private String brandId;

        private String name;

        private String imageUrl;
}
