package com.example.voucherservice.repository;

import com.example.voucherservice.entity.EventVoucher;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface EventVoucherRepository extends JpaRepository<EventVoucher, UUID> {
    EventVoucher findByEventId(UUID eventId);
}
