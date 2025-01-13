package com.example.voucherservice.service;

import com.example.voucherservice.dto.VoucherDto;
import com.example.voucherservice.entity.EventVoucher;

import java.util.List;
import java.util.UUID;

public interface VoucherService {
    String generateVoucherCode();
    VoucherDto distributeVoucher(UUID eventId, UUID playerId);
    void useVoucher(UUID voucherId);
    void deleteVoucher(UUID eventId);
    VoucherDto getVoucher(UUID voucherId);
    List<VoucherDto> getVouchers(UUID playerId);
}
