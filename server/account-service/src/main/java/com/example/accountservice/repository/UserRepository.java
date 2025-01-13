package com.example.accountservice.repository;

import com.example.accountservice.entity.User;
import com.example.accountservice.entity.UserRole;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.UUID;

@Repository
public interface UserRepository extends JpaRepository<User, UUID> {
    User findByUsername(String username);
    boolean existsByUsername(String username);
    User findByUserId(UUID userId);
    Long countByRole(UserRole role);
}
