package com.submission.mis.onlinesubmission.util;

import java.time.LocalDate;
import java.util.regex.Pattern;

/**
 * Utility class for validating various types of input data.
 */
public class ValidationUtil {

    // Regex pattern for validating names (only alphabetic characters)
    private static final Pattern NAME_PATTERN = Pattern.compile("^[A-Za-z]+$");

    // Regex pattern for validating email addresses
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$");

    // Regex pattern for validating passwords (at least 8 characters, including uppercase, lowercase, number, and special character)
    private static final Pattern PASSWORD_PATTERN = Pattern.compile("^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$");

    /**
     * Validates if the provided name is valid.
     * @param name The name to validate.
     * @return true if the name is valid, false otherwise.
     */
    public static boolean isValidName(String name) {
        return name != null && NAME_PATTERN.matcher(name).matches();
    }

    /**
     * Validates if the provided email is valid.
     * @param email The email to validate.
     * @return true if the email is valid, false otherwise.
     */
    public static boolean isValidEmail(String email) {
        return email != null && EMAIL_PATTERN.matcher(email).matches();
    }

    /**
     * Validates if the provided password is valid.
     * @param password The password to validate.
     * @return true if the password is valid, false otherwise.
     */
    public static boolean isValidPassword(String password) {
        return password != null && PASSWORD_PATTERN.matcher(password).matches();
    }

    /**
     * Validates if the provided date is a valid past date.
     * @param date The date to validate.
     * @return true if the date is in the past, false otherwise.
     */
    public static boolean isValidPastDate(LocalDate date) {
        return date != null && date.isBefore(LocalDate.now());
    }

    /**
     * Validates if the provided date is a valid future date.
     * @param date The date to validate.
     * @return true if the date is in the future, false otherwise.
     */
    public static boolean isValidFutureDate(LocalDate date) {
        return date != null && date.isAfter(LocalDate.now());
    }

    /**
     * Sanitizes the input by trimming whitespace.
     * @param input The input to sanitize.
     * @return The sanitized input.
     */
    public static String sanitizeInput(String input) {
        return input == null ? null : input.trim();
    }
}