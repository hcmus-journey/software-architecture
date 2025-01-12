package com.example.voucherservice.service;

import com.example.voucherservice.dto.VoucherDto;
import com.example.voucherservice.entity.EventVoucher;
import com.example.voucherservice.entity.Voucher;
import com.example.voucherservice.entity.VoucherStatus;
import com.example.voucherservice.exception.BadRequestException;
import com.example.voucherservice.mapper.VoucherMapper;
import com.example.voucherservice.repository.EventVoucherRepository;
import com.example.voucherservice.repository.VoucherRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class VoucherServiceImpl implements VoucherService{

    final private EventVoucherRepository eventVoucherRepository;

    final private VoucherRepository voucherRepository;

    @Override
    public String generateVoucherCode() {
        return UUID.randomUUID().toString().replace("-", "").substring(0, 8);
    }

    @Override
    public VoucherDto distributeVoucher(UUID eventId, UUID playerId) {
        EventVoucher eventVoucher = eventVoucherRepository.findByEventId(eventId);
        if(eventVoucher == null) {
            throw new BadRequestException("Event voucher not found");
        }

        if(eventVoucher.getRedeemedVouchers() >= eventVoucher.getTotalVouchers()) {
            throw new BadRequestException("Voucher is out of stock");
        }

        eventVoucher.setRedeemedVouchers(eventVoucher.getRedeemedVouchers() + 1);

        eventVoucherRepository.save(eventVoucher);

        Voucher newVoucher = new Voucher();

        newVoucher.setEventId(eventId);

        newVoucher.setPlayerId(playerId);

        newVoucher.setCode(generateVoucherCode());

        newVoucher.setStatus(VoucherStatus.AVAILABLE);

        newVoucher.setReceivedAt(LocalDate.now());

        newVoucher.setDiscount(eventVoucher.getDiscountPercentage());

        voucherRepository.save(newVoucher);

        return VoucherMapper.INSTANCE.convertToVoucherDto(newVoucher);
    }

    @Override
    public void useVoucher(UUID voucherId) {
        Voucher voucher = voucherRepository.findByVoucherId(voucherId);
        if(voucher == null) {
            throw new BadRequestException("Voucher not found");
        }

        voucher.setStatus(VoucherStatus.USED);

        voucherRepository.save(voucher);
    }

    @Override
    public void deleteVoucher(UUID eventId) {

    }

    @Override
    public EventVoucher getVoucher(UUID eventId) {
        return null;
    }

    @Override
    public List<EventVoucher> getVouchers() {
        return List.of();
    }
}
