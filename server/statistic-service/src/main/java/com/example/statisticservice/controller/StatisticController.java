package com.example.statisticservice.controller;

import com.example.statisticservice.dto.StatisticForAdminDto;
import com.example.statisticservice.service.StatisticService;
import io.swagger.v3.oas.annotations.Operation;
import lombok.AllArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@AllArgsConstructor
@RestController
@RequestMapping("/statistics")
public class StatisticController {
    final private StatisticService statisticService;

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    @Operation(tags = "Admin", description = "Get statistics")
    public ResponseEntity<StatisticForAdminDto> getStatisticForAdmin() {
        return ResponseEntity.ok(statisticService.getStatisticForAdmin());
    }
}
