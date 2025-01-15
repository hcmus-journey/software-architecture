package com.example.voucherservice.mapper;

import com.example.voucherservice.dto.EventVoucherDto;
import com.example.voucherservice.dto.VoucherDto;
import com.example.voucherservice.entity.EventVoucher;
import com.example.voucherservice.entity.Voucher;
import java.util.UUID;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-01-13T11:36:02+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23.0.1 (Oracle Corporation)"
)
public class VoucherMapperImpl implements VoucherMapper {

    @Override
    public EventVoucherDto convertToEventVoucherDto(EventVoucher eventVoucher) {
        if ( eventVoucher == null ) {
            return null;
        }

        UUID eventId = null;
        Integer redeemedVouchers = null;
        Integer totalVouchers = null;
        Double discountPercentage = null;

        eventId = eventVoucher.getEventId();
        redeemedVouchers = eventVoucher.getRedeemedVouchers();
        totalVouchers = eventVoucher.getTotalVouchers();
        discountPercentage = eventVoucher.getDiscountPercentage();

        EventVoucherDto eventVoucherDto = new EventVoucherDto( eventId, redeemedVouchers, totalVouchers, discountPercentage );

        return eventVoucherDto;
    }

    @Override
    public EventVoucher convertToEventVoucher(EventVoucherDto eventVoucherDto) {
        if ( eventVoucherDto == null ) {
            return null;
        }

        EventVoucher eventVoucher = new EventVoucher();

        eventVoucher.setEventId( eventVoucherDto.getEventId() );
        eventVoucher.setRedeemedVouchers( eventVoucherDto.getRedeemedVouchers() );
        eventVoucher.setTotalVouchers( eventVoucherDto.getTotalVouchers() );
        eventVoucher.setDiscountPercentage( eventVoucherDto.getDiscountPercentage() );

        return eventVoucher;
    }

    @Override
    public VoucherDto convertToVoucherDto(Voucher voucher) {
        if ( voucher == null ) {
            return null;
        }

        VoucherDto voucherDto = new VoucherDto();

        voucherDto.setVoucherId( voucher.getVoucherId() );
        voucherDto.setPlayerId( voucher.getPlayerId() );
        voucherDto.setEventId( voucher.getEventId() );
        voucherDto.setCode( voucher.getCode() );
        voucherDto.setStatus( voucher.getStatus() );
        voucherDto.setReceivedAt( voucher.getReceivedAt() );
        voucherDto.setDiscount( voucher.getDiscount() );

        return voucherDto;
    }

    @Override
    public Voucher convertToVoucher(VoucherDto voucherDto) {
        if ( voucherDto == null ) {
            return null;
        }

        Voucher voucher = new Voucher();

        voucher.setVoucherId( voucherDto.getVoucherId() );
        voucher.setPlayerId( voucherDto.getPlayerId() );
        voucher.setEventId( voucherDto.getEventId() );
        voucher.setCode( voucherDto.getCode() );
        voucher.setStatus( voucherDto.getStatus() );
        voucher.setReceivedAt( voucherDto.getReceivedAt() );
        voucher.setDiscount( voucherDto.getDiscount() );

        return voucher;
    }
}
