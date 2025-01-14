package com.example.inventoryservice.dto;

import lombok.Getter;
import lombok.Setter;

import java.util.UUID;

@Setter
@Getter
public class GiftCoinRequest {
    private UUID eventId;

    private Integer coins;

    private String receiverId;
}
