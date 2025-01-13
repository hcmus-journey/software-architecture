package com.example.voucherservice.repository;

import com.example.voucherservice.entity.Voucher;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface VoucherRepository extends JpaRepository<Voucher, UUID> {
    Voucher findByVoucherId(UUID voucherId);
    List<Voucher> findByEventId(UUID eventId);
    List<Voucher> findByPlayerId(UUID playerId);
    Voucher findByEventIdAndCode(UUID eventId, String code);
}
