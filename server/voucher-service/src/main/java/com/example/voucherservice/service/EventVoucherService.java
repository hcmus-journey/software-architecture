package com.example.voucherservice.service;

import com.example.voucherservice.dto.EventVoucherDto;

import java.util.UUID;

public interface EventVoucherService {
    void createEventVoucher(EventVoucherDto eventVoucherDto);
    void deleteEventVoucher(UUID eventId);
    void updateEventVoucher(EventVoucherDto eventVoucherDto);
    EventVoucherDto getEventVoucher(UUID eventId);
}
