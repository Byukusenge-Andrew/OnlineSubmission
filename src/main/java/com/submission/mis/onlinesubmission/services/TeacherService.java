package com.submission.mis.onlinesubmission.services;

import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.submission.mis.onlinesubmission.models.Submission;
import com.submission.mis.onlinesubmission.models.Teacher;
import com.submission.mis.onlinesubmission.util.HibernateUtil;
import com.submission.mis.onlinesubmission.util.PasswordUtil;

/**
 * Service class for managing Teacher-related operations.
 * Implements singleton pattern and provides methods for CRUD operations and authentication.
 */
public class TeacherService {
    /** Singleton instance of the service */
    private static TeacherService instance;


    /** Private constructor to prevent direct instantiation */
    private TeacherService() {}

    /**
     * Gets the singleton instance of TeacherService.
     * @return The TeacherService instance
     */
    public static TeacherService getInstance() {
        if (instance == null) {
            instance = new TeacherService();
        }
        return instance;
    }

    /**
     * menthod add teacher to database
     * @param teacher
     * @throws Exception
     */

    public void addTeacher(Teacher teacher) throws Exception {
        HibernateUtil.executeInTransaction(session -> {
            String hashedPassword = PasswordUtil.hashPassword(teacher.getPassword());
            teacher.setPassword(hashedPassword);
            session.persist(teacher);
        });
    }

    /**
     * Retrieves a list of submissions for a given assignment ID.
     *
     * @param assignmentId The UUID of the assignment.
     * @return A list of submissions associated with the assignment.
     */
    public List<Submission> getSubmissionsByAssignmentId(UUID assignmentId) {
        Session session = HibernateUtil.getSession();
        try {
            Query<Submission> query = session.createQuery(
                    "FROM Submission WHERE assignment.id = :assignmentId", Submission.class);
            query.setParameter("assignmentId", assignmentId);
            return query.list();
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public Teacher loginAndGetTeacher(String email, String password) {
        Session session = HibernateUtil.getSession();
        try {
            Teacher teacher = session.createQuery("from Teacher where email = :email", Teacher.class)
                    .setParameter("email", email)
                    .uniqueResult();
            
            if (teacher != null && PasswordUtil.verifyPassword(password, teacher.getPassword())) {
                return teacher;
            }
            return null;
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public List<Teacher> getAllTeachers() {
        Session session = HibernateUtil.getSession();
        try {
            return session.createQuery("from Teacher", Teacher.class).list();
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public Teacher getTeacherById(UUID teacherId) {
        Session session = HibernateUtil.getSession();
        try {
            return session.get(Teacher.class, teacherId);
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public boolean emailExists(String email) {
        Session session = HibernateUtil.getSession();
        try {
            Long count = session.createQuery("select count(*) from Teacher where email = :email", Long.class)
                    .setParameter("email", email)
                    .uniqueResult();
            return count != null && count > 0;
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public Long numberOfStudents() {
        Session session = HibernateUtil.getSession();
        try{
            Long count = session.createQuery("select  count(*) from Student", Long.class).uniqueResult();
            return count;
        }finally {
            HibernateUtil.closeSession(session);
        }

    }

    @Deprecated
    public boolean login(String email, String password) {
        return loginAndGetTeacher(email, password) != null;
    }

   
}
