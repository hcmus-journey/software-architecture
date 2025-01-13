package com.example.statisticservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@EnableFeignClients
@SpringBootApplication
public class StatisticServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(StatisticServiceApplication.class, args);
	}

}
