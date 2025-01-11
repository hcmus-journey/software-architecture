package com.example.voucherservice.service;

import com.example.voucherservice.entity.EventVoucher;

import java.util.List;
import java.util.UUID;

public interface VoucherService {
    String generateVoucherCode();
    void distributeVoucher(UUID eventId, UUID playerId);
    void useVoucher(UUID voucherId);
    void deleteVoucher(UUID eventId);
    EventVoucher getVoucher(UUID eventId);
    List<EventVoucher> getVouchers();
}
