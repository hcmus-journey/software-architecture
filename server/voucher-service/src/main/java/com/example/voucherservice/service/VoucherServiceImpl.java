package com.example.voucherservice.service;

import com.example.voucherservice.client.EventClient;
import com.example.voucherservice.dto.EventDto;
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

import java.time.LocalDateTime;
import java.util.List;
import java.util.UUID;

@Service
@AllArgsConstructor
public class VoucherServiceImpl implements VoucherService{

    final private EventVoucherRepository eventVoucherRepository;

    final private VoucherRepository voucherRepository;

    final private EventClient eventClient;

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

        newVoucher.setReceivedAt(LocalDateTime.now());

        newVoucher.setDiscount(eventVoucher.getDiscountPercentage());

        EventDto eventDto = eventClient.getEvent(eventId.toString());

        System.out.println(eventDto.getEndTime().atStartOfDay());

        newVoucher.setExpiredAt(eventDto.getEndTime().atStartOfDay());

        voucherRepository.save(newVoucher);

        return VoucherMapper.INSTANCE.convertToVoucherDto(newVoucher);
    }

    @Override
     public VoucherDto useVoucher(UUID eventId, String voucherCode) {
        Voucher voucher = voucherRepository.findByEventIdAndCode(eventId, voucherCode);
        if(voucher == null) {
            throw new BadRequestException("Voucher not found");
        }

        if(voucher.getStatus() == VoucherStatus.USED) {
            throw new BadRequestException("Voucher already used");
        }

        voucher.setStatus(VoucherStatus.USED);

        voucherRepository.save(voucher);

        return VoucherMapper.INSTANCE.convertToVoucherDto(voucher);
    }

    @Override
    public void deleteVoucher(UUID eventId) {

    }


    @Override
    public VoucherDto getVoucher(UUID voucherId) {
        return VoucherMapper.INSTANCE
                .convertToVoucherDto(voucherRepository.findByVoucherId(voucherId));
    }

    @Override
    public List<VoucherDto> getVouchers(UUID playerId) {
        return voucherRepository.findByPlayerId(playerId)
                .stream()
                .map(VoucherMapper.INSTANCE::convertToVoucherDto)
                .toList();
    }
}
