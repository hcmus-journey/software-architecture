package com.example.voucherservice;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@EnableFeignClients
@SpringBootApplication
public class VoucherServiceApplication {

	public static void main(String[] args) {
		SpringApplication.run(VoucherServiceApplication.class, args);
	}

}
