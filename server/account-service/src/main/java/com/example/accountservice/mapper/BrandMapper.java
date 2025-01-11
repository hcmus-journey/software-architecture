package com.example.accountservice.mapper;

import com.example.accountservice.dto.BrandProfileDto;
import com.example.accountservice.entity.Brand;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface BrandMapper {
    BrandMapper INSTANCE = Mappers.getMapper(BrandMapper.class);

    Brand convertToBrand(BrandProfileDto brandProfileDto);
}
