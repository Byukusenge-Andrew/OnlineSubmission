package com.submission.mis.onlinesubmission.services;

import java.util.List;
import java.util.UUID;

import org.hibernate.Session;

import com.submission.mis.onlinesubmission.models.Student;
import com.submission.mis.onlinesubmission.util.HibernateUtil;
import com.submission.mis.onlinesubmission.util.PasswordUtil;

/**
 * Service class for managing Student-related operations.
 * Implements singleton pattern and provides methods for CRUD operations and authentication.
 */
public class StudentService {
    /** Singleton instance of the service */
    private static StudentService instance;

    /** Private constructor to prevent direct instantiation */
    private StudentService() {}

    /**
     * Gets the singleton instance of StudentService.
     * @return The StudentService instance
     */
    public static StudentService getInstance() {
        if (instance == null) {
            instance = new StudentService();
        }
        return instance;
    }

    /**
     * Adds a new student to the database with a hashed password.
     * @param student The student to add
     */
    public void addStudent(Student student) throws Exception {
        HibernateUtil.executeInTransaction(session -> {
            String hashedPassword = PasswordUtil.hashPassword(student.getPassword());
            student.setPassword(hashedPassword);
            session.persist(student);
            System.out.println("Student added: " + student);
        });
    }

    /**
     * Authenticates a student using email and password.
     * @param email The student's email
     * @param password The student's password (plain text)
     * @return The authenticated Student object or null if authentication fails
     */
    public Student loginAndGetStudent(String email, String password) {
        Session session = HibernateUtil.getSession();
        try {
            Student student = session.createQuery("from Student where email = :email", Student.class)
                    .setParameter("email", email)
                    .uniqueResult();
            
            if (student != null && PasswordUtil.verifyPassword(password, student.getPassword())) {
                System.out.println("Logged in successfully");
                return student;

            }
            System.out.println("No such student");
            return null;
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    /**
     * Retrieves all students from the database.
     * @return List of all students
     */
    public List<Student> getAllStudents() {
        Session session = HibernateUtil.getSession();
        try {
            return session.createQuery("from Student", Student.class).list();
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    /**
     * Retrieves a student by their UUID.
     * @param studentId The UUID of the student to retrieve
     * @return The Student object or null if not found
     */
    public Student getStudentById(UUID studentId) {
        Session session = HibernateUtil.getSession();
        try {
            return session.get(Student.class, studentId);
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    /**
     * Checks if an email is already registered in the system.
     * @param email The email to check
     * @return true if the email exists, false otherwise
     */
    public boolean emailExists(String email) {
        Session session = HibernateUtil.getSession();
        try {
            Long count = session.createQuery("select count(*) from Student where email = :email", Long.class)
                    .setParameter("email", email)
                    .uniqueResult();
            return count != null && count > 0;
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    /**
     * @deprecated Use {@link #loginAndGetStudent(String, String)} instead
     */
    @Deprecated
    public boolean login(String email, String password) {
        return loginAndGetStudent(email, password) != null;
    }

}