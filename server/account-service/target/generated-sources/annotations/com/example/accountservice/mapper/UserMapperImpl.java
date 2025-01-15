package com.example.accountservice.mapper;

import com.example.accountservice.dto.SignUpRequest;
import com.example.accountservice.dto.UserDto;
import com.example.accountservice.entity.User;
import com.example.accountservice.entity.UserRole;
import com.example.accountservice.entity.UserStatus;
import java.time.LocalDateTime;
import java.util.UUID;
import javax.annotation.processing.Generated;

@Generated(
    value = "org.mapstruct.ap.MappingProcessor",
    date = "2025-01-13T01:44:57+0700",
    comments = "version: 1.5.5.Final, compiler: javac, environment: Java 23.0.1 (Oracle Corporation)"
)
public class UserMapperImpl implements UserMapper {

    @Override
    public User convertToUser(SignUpRequest signUpRequest) {
        if ( signUpRequest == null ) {
            return null;
        }

        User.UserBuilder user = User.builder();

        user.username( signUpRequest.getUsername() );
        user.password( signUpRequest.getPassword() );
        if ( signUpRequest.getRole() != null ) {
            user.role( Enum.valueOf( UserRole.class, signUpRequest.getRole() ) );
        }

        return user.build();
    }

    @Override
    public User convertToUser(UserDto userDto) {
        if ( userDto == null ) {
            return null;
        }

        User.UserBuilder user = User.builder();

        user.userId( userDto.getUserId() );
        user.username( userDto.getUsername() );
        user.role( userDto.getRole() );
        user.status( userDto.getStatus() );
        user.createdAt( userDto.getCreatedAt() );
        user.updatedAt( userDto.getUpdatedAt() );

        return user.build();
    }

    @Override
    public UserDto convertToUserDto(User user) {
        if ( user == null ) {
            return null;
        }

        UUID userId = null;
        String username = null;
        UserRole role = null;
        UserStatus status = null;
        LocalDateTime createdAt = null;
        LocalDateTime updatedAt = null;

        userId = user.getUserId();
        username = user.getUsername();
        role = user.getRole();
        status = user.getStatus();
        createdAt = user.getCreatedAt();
        updatedAt = user.getUpdatedAt();

        UserDto userDto = new UserDto( userId, username, role, status, createdAt, updatedAt );

        return userDto;
    }
}
