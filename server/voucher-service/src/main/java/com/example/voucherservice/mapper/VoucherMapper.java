package com.example.voucherservice.mapper;

import com.example.voucherservice.dto.EventVoucherDto;
import com.example.voucherservice.dto.VoucherDto;
import com.example.voucherservice.entity.EventVoucher;
import com.example.voucherservice.entity.Voucher;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface VoucherMapper {
    VoucherMapper INSTANCE = Mappers.getMapper(VoucherMapper.class);

    EventVoucherDto convertToEventVoucherDto(EventVoucher eventVoucher);

    EventVoucher convertToEventVoucher(EventVoucherDto eventVoucherDto);

    VoucherDto convertToVoucherDto(Voucher voucher);

    Voucher convertToVoucher(VoucherDto voucherDto);
}
