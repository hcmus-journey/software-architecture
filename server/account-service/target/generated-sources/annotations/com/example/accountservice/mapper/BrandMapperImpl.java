package com.example.accountservice.mapper;

import com.example.accountservice.dto.BrandProfileDto;
import com.example.accountservice.entity.Brand;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-01-13T01:44:57+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23.0.1 (Oracle Corporation)"
)
public class BrandMapperImpl implements BrandMapper {

    @Override
    public Brand convertToBrand(BrandProfileDto brandProfileDto) {
        if ( brandProfileDto == null ) {
            return null;
        }

        Brand.BrandBuilder brand = Brand.builder();

        brand.name( brandProfileDto.getName() );
        brand.businessField( brandProfileDto.getBusinessField() );
        brand.imageUrl( brandProfileDto.getImageUrl() );
        brand.address( brandProfileDto.getAddress() );
        brand.gpsLatitude( brandProfileDto.getGpsLatitude() );
        brand.gpsLongitude( brandProfileDto.getGpsLongitude() );

        return brand.build();
    }

    @Override
    public BrandProfileDto convertToBrandProfileDto(Brand brand) {
        if ( brand == null ) {
            return null;
        }

        BrandProfileDto brandProfileDto = new BrandProfileDto();

        brandProfileDto.setName( brand.getName() );
        brandProfileDto.setBusinessField( brand.getBusinessField() );
        brandProfileDto.setImageUrl( brand.getImageUrl() );
        brandProfileDto.setAddress( brand.getAddress() );
        brandProfileDto.setGpsLatitude( brand.getGpsLatitude() );
        brandProfileDto.setGpsLongitude( brand.getGpsLongitude() );

        return brandProfileDto;
    }
}
