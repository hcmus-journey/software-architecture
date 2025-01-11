package com.example.voucherservice.service;

import com.example.voucherservice.dto.EventVoucherDto;
import com.example.voucherservice.entity.EventVoucher;
import com.example.voucherservice.mapper.EventVoucherMapper;
import com.example.voucherservice.repository.EventVoucherRepository;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@AllArgsConstructor
public class EventVoucherServiceImpl implements EventVoucherService {

    final EventVoucherRepository eventVoucherRepository;

    @Override
    public void createEventVoucher(EventVoucherDto eventVoucherDto) {
        EventVoucher eventVoucher = EventVoucherMapper.INSTANCE.convertToEventVoucher(eventVoucherDto);

    }
}
