package com.submission.mis.onlinesubmission.models;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import org.hibernate.annotations.GenericGenerator;

import java.time.LocalDate;
import java.util.UUID;

/**
 * Entity class representing a Student in the system.
 * Contains personal information and authentication details.
 */
@Entity
public class Student {
    /** Unique identifier for the student */
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
        name = "UUID",
        strategy = "org.hibernate.id.UUIDGenerator"
    )
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    /** Student's first name */
    private String firstName;

    /** Student's last name */
    private String lastName;


    /** Student's email address (used for login) */
    private String email;

    /** Student's age */
    private int age;

    /** Student's date of birth */
    private LocalDate birthDate;

    /** Student's hashed password */
    @Column(nullable = false)
    private String password;

    /** Default constructor required by JPA */
    public Student() {}

//    public Student(int id, String firstName, String lastName, String email, int age, LocalDate birthDate) {
//        this.id = id;
//        this.firstName = firstName;
//        this.lastName = lastName;
//        this.email = email;
//        this.age = age;
//        this.birthDate = birthDate;
//    }

    /**
     * Creates a new Student with the specified details.
     * @param firstName The student's first name
     * @param lastName The student's last name
     * @param email The student's email address
     * @param password The student's password (will be hashed)
     * @param age The student's age
     * @param birthDate The student's date of birth
     */
    public Student(String firstName, String lastName, String email, String password, int age, LocalDate birthDate) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.age = age;
        this.birthDate = birthDate;
        this.password = password;
    }

//    public Student(String firstName, String lastName, String email,String password, LocalDate birthDate) {
//        this.firstName = firstName;
//        this.lastName = lastName;
//        this.email = email;
//        this.password = password;
//        this.birthDate = birthDate;
//    }

    /**
     * Gets the student's unique identifier.
     * @return The UUID of the student
     */
    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    /**
     * Gets the student's first name.
     * @return The student's first name
     */
    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets the student's last name.
     * @return The student's last name
     */
    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the student's email address.
     * @return The student's email address
     */
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    /**
     * Gets the student's age.
     * @return The student's age
     */
    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    /**
     * Gets the student's date of birth.
     * @return The student's date of birth
     */
    public LocalDate getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    /**
     * Gets the student's hashed password.
     * @return The student's hashed password
     */
    public String getPassword() {
        return password;
    }
}