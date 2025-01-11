package com.example.voucherservice.mapper;

import com.example.voucherservice.dto.EventVoucherDto;
import com.example.voucherservice.entity.EventVoucher;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface EventVoucherMapper {
    EventVoucherMapper INSTANCE = Mappers.getMapper(EventVoucherMapper.class);

    EventVoucherDto convertToEventVoucherDto(EventVoucher eventVoucher);

    EventVoucher convertToEventVoucher(EventVoucherDto eventVoucherDto);
}
