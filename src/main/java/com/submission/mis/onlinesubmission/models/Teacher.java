package com.submission.mis.onlinesubmission.models;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.Column;
import org.hibernate.annotations.GenericGenerator;

import java.time.LocalDate;
import java.util.UUID;

/**
 * Entity class representing a Teacher in the system.
 * Contains personal information, authentication details, and teaching credentials.
 */
@Entity
public class Teacher {

    /** Unique identifier for the teacher */
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
        name = "UUID",
        strategy = "org.hibernate.id.UUIDGenerator"
    )
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    /** Teacher's first name */
    private String firstName;

    /** Teacher's last name */
    private String lastName;

    /** Teacher's email address (used for login) */
    private String email;

    /** Course */
    private String course;

    /** Teacher's hashed password */
    @Column(nullable = false)
    private String password;

    /** Date when the teacher was hired */
    private LocalDate hireDate;

    /** Default constructor required by JPA */
    public Teacher() {}

    /**
     * Creates a new Teacher with the specified details.
     * @param firstName The teacher's first name
     * @param lastName The teacher's last name
     * @param email The teacher's email address
     * @param password The teacher's password (will be hashed)
     * @param hireDate The date when the teacher was hired
     * @param course The teacher's course
     */
    public Teacher(String firstName, String lastName, String email,String course, String password, LocalDate hireDate) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.hireDate = hireDate;
        this.course = course;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public LocalDate getHireDate() {
        return hireDate;
    }

    public void setHireDate(LocalDate hireDate) {
        this.hireDate = hireDate;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public String getName(){
        return firstName + " " + lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
