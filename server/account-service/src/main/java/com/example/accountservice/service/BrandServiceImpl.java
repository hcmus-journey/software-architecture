package com.example.accountservice.service;

import com.example.accountservice.dto.BrandProfileDto;
import com.example.accountservice.entity.Brand;
import com.example.accountservice.entity.User;
import com.example.accountservice.entity.UserStatus;
import com.example.accountservice.mapper.BrandMapper;
import com.example.accountservice.repository.BrandRepository;
import com.example.accountservice.repository.UserRepository;
import jakarta.transaction.Transactional;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Service
@AllArgsConstructor
public class BrandServiceImpl implements BrandService {

    final private BrandRepository brandRepository;
    private final UserRepository userRepository;

    @Override
    public void updateProfile(UUID brandID, BrandProfileDto brandProfileDto) {

        Brand brand = BrandMapper.INSTANCE.convertToBrand(brandProfileDto);

        brand.setBrandId(brandID);

        brandRepository.save(brand);
    }

    @Transactional
    @Override
    public void activeBrand(UUID brandID, BrandProfileDto brandProfileDto) {
        Brand brand = BrandMapper.INSTANCE.convertToBrand(brandProfileDto);

        User user = userRepository.findByUserId(brandID);
        if (user == null) {
            throw new IllegalArgumentException("User not found with ID: " + brandID);
        }

        brand.setBrandId(brandID);

        brandRepository.save(brand);

        user.setStatus(UserStatus.ACTIVE);

        userRepository.save(user);
    }

    @Override
    public BrandProfileDto getBrandProfile(UUID playerId) {
        return BrandMapper.INSTANCE.convertToBrandProfileDto(brandRepository.findByBrandId(playerId));
    }
}
