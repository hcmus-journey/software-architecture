package com.example.statisticservice.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Builder
public class StatisticForAdminDto {
    private Long totalPlayers;
    private Long totalBrands;
    private Long totalShakeGameEvents;
    private Long totalQuizGameEvents;
    private Long quizGameAttempts;
    private Long shakeGameAttempts;
}
