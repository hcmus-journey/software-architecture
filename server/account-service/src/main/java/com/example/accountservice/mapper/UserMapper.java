package com.example.accountservice.mapper;

import com.example.accountservice.dto.SignUpRequest;
import com.example.accountservice.entity.User;
import org.mapstruct.Mapper;
import org.mapstruct.ReportingPolicy;
import org.mapstruct.factory.Mappers;

@Mapper(unmappedTargetPolicy = ReportingPolicy.IGNORE)
public interface UserMapper {
    UserMapper INSTANCE = Mappers.getMapper(UserMapper.class);

    User convertToUser(SignUpRequest signUpRequest);
}
