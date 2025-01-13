package com.example.inventoryservice.mapper;

import com.example.inventoryservice.dto.ShakeGameInventoryDto;
import com.example.inventoryservice.entity.ShakeGameInventory;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface InventoryMapper {
    InventoryMapper INSTANCE = Mappers.getMapper(InventoryMapper.class);

    ShakeGameInventoryDto convertToDto(ShakeGameInventory shakeGameInventory);
}
