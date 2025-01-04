package com.example.accountservice.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.UUID;

@Entity
@Setter
@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "brands")
public class Brand {

    @Id
    @Column(name = "brand_id")
    @GeneratedValue(strategy = GenerationType.UUID)
    private UUID brandId;

    @Column(name = "name")
    private String name;

    @Column(name = "business_field")
    private String businessField;

    @Column(name = "image_url")
    private String imageUrl;

    @Column(name = "address")
    private String address;

    @Column(name = "gps_latitude")
    private Double gpsLatitude;

    @Column(name = "gps_longitude")
    private Double gpsLongitude;

    @OneToOne
    @JoinColumn(name = "brand_id", referencedColumnName = "user_id")
    private User user;
}
