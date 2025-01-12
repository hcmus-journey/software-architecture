package com.example.voucherservice.service;

import com.example.voucherservice.dto.EventVoucherDto;
import com.example.voucherservice.entity.EventVoucher;
import com.example.voucherservice.mapper.VoucherMapper;
import com.example.voucherservice.repository.EventVoucherRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@AllArgsConstructor
public class EventVoucherServiceImpl implements EventVoucherService {

    final EventVoucherRepository eventVoucherRepository;

    @Override
    public void createEventVoucher(EventVoucherDto eventVoucherDto) {
        EventVoucher eventVoucher = VoucherMapper.INSTANCE.convertToEventVoucher(eventVoucherDto);
        eventVoucherRepository.save(eventVoucher);
    }

    @Override
    public void deleteEventVoucher(UUID eventId) {
        eventVoucherRepository.deleteById(eventId);
    }

    @Override
    public void updateEventVoucher(EventVoucherDto eventVoucherDto) {
        EventVoucher eventVoucher = VoucherMapper.INSTANCE.convertToEventVoucher(eventVoucherDto);
        eventVoucherRepository.save(eventVoucher);
    }

    @Override
    public EventVoucherDto getEventVoucher(UUID eventId) {
        return VoucherMapper.INSTANCE.convertToEventVoucherDto(eventVoucherRepository.findByEventId(eventId));
    }


}
