package com.example.statisticservice.service;

import com.example.statisticservice.client.AccountClient;
import com.example.statisticservice.client.EventClient;
import com.example.statisticservice.client.GameClient;
import com.example.statisticservice.dto.StatisticForAdminDto;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@AllArgsConstructor
public class StatisticServiceImpl implements StatisticService {

    final private GameClient gameClient;

    final private AccountClient accountClient;

    final private EventClient eventClient;

    @Override
    public StatisticForAdminDto getStatisticForAdmin() {
        List<Long> totalQuizAndShakeGameAttempts = gameClient.getTotalQuizAndShakeGameAttempts();

        List<Long> totalPlayersAndBrands = accountClient.getTotalPlayersAndBrands();

        List<Long> totalShakeAndQuizGameEvents = eventClient.getTotalQuizEventsAndShakeEvents();


        return StatisticForAdminDto.builder()
                .totalPlayers(totalPlayersAndBrands.get(0))
                .totalBrands(totalPlayersAndBrands.get(1))
                .totalShakeGameEvents(totalShakeAndQuizGameEvents.get(0))
                .totalQuizGameEvents(totalShakeAndQuizGameEvents.get(1))
                .quizGameAttempts(totalQuizAndShakeGameAttempts.get(0))
                .shakeGameAttempts(totalQuizAndShakeGameAttempts.get(1))
                .build();
    }
}
