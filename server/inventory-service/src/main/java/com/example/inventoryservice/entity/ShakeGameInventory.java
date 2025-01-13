package com.example.inventoryservice.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;
import java.util.UUID;

@Getter
@Setter
@Entity
@Table(name = "shake_game_inventories")
public class ShakeGameInventory {
    @Id
    @Column(name = "inventory_id", nullable = false)
    private UUID inventoryId;

    @NotNull
    @Column(name = "player_id", nullable = false)
    private UUID playerId;

    @NotNull
    @Column(name = "event_id", nullable = false)
    private UUID eventId;

    @NotNull
    @Column(name = "collected_coin", nullable = false)
    private Integer collectedCoin;

    @Column(name = "game_id")
    private UUID gameId;
}