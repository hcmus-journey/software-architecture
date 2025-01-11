package com.example.gameservice.exception;

import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@RestControllerAdvice
public class ValidationAdvice {
    // Exception handler for validation errors
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public final ResponseEntity<ValidationErrorResponse> handleMethodArgumentNotValidException(MethodArgumentNotValidException exception) {
        final List<FieldError> fieldErrors = exception.getBindingResult().getFieldErrors();
        final List<String> errorList = fieldErrors.stream()
                .map(DefaultMessageSourceResolvable::getDefaultMessage)
                .collect(Collectors.toList());

        final ValidationErrorResponse validationErrorResponse = new ValidationErrorResponse(
                HttpStatus.BAD_REQUEST, LocalDateTime.now(), errorList);

        return ResponseEntity.status(validationErrorResponse.getStatus()).body(validationErrorResponse);
    }

    // Exception handler for empty or malformed request body
    @ExceptionHandler(HttpMessageNotReadableException.class)
    public final ResponseEntity<ValidationErrorResponse> handleHttpMessageNotReadableException(HttpMessageNotReadableException exception) {
        // Creating a generic error message for missing or invalid body
        String errorMessage = "Request body is missing or malformed";

        // Returning a bad request response with the error message
        ValidationErrorResponse validationErrorResponse = new ValidationErrorResponse(
                HttpStatus.BAD_REQUEST, LocalDateTime.now(), List.of(errorMessage));

        return ResponseEntity.status(validationErrorResponse.getStatus()).body(validationErrorResponse);
    }
}
