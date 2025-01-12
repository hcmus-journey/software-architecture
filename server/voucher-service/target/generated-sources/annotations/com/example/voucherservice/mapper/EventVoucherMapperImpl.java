package com.example.voucherservice.mapper;

import com.example.voucherservice.dto.EventVoucherDto;
import com.example.voucherservice.entity.EventVoucher;
import java.util.UUID;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-01-13T02:02:32+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23.0.1 (Oracle Corporation)"
)
public class EventVoucherMapperImpl implements EventVoucherMapper {

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
}
