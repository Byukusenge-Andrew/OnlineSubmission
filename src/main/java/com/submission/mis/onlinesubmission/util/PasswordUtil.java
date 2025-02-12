package com.submission.mis.onlinesubmission.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 * Utility class for handling password hashing and verification.
 */
public class PasswordUtil {

    /**
     * Hashes a plain text password using BCrypt.
     * @param plainPassword The plain text password to hash.
     * @return The hashed password.
     */
    public static String hashPassword(String plainPassword) {
        return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
    }

    /**
     * Verifies a plain text password against a hashed password.
     * @param plainPassword The plain text password to verify.
     * @param hashedPassword The hashed password to compare against.
     * @return true if the password matches, false otherwise.
     */
    public static boolean verifyPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}