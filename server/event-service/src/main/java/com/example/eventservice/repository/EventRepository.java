package com.example.eventservice.repository;

import com.example.eventservice.entity.Event;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.UUID;

@Repository
public interface EventRepository extends JpaRepository<Event, UUID> {
    Event findByEventId(UUID eventId);
    List<Event> findByBrandId(UUID brandId);

    List<Event> findAllByStatus(@Size(max = 255) @NotNull String status);
}
