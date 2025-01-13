package com.example.voucherservice.dto;

import jakarta.validation.constraints.NotEmpty;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UseVoucherRequest {

    @NotEmpty(message = "Event ID is required")
    private String eventId;

    @NotEmpty(message = "Voucher code is required")
    private String voucherCode;

}
