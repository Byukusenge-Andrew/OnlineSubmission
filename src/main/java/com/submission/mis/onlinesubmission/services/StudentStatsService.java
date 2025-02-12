package com.submission.mis.onlinesubmission.services;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import org.hibernate.Session;

import com.submission.mis.onlinesubmission.models.Assignment;
import com.submission.mis.onlinesubmission.util.HibernateUtil;

public class StudentStatsService {
    private static StudentStatsService instance;

    private StudentStatsService() {}

    public static StudentStatsService getInstance() {
        if (instance == null) {
            instance = new StudentStatsService();
        }
        return instance;
    }

    public StudentStats getStudentStats(UUID studentId) {
        Session session = HibernateUtil.getSession();
        try {
            // Get total available assignments
            Long totalAssignments = session.createQuery(
                "select count(*) from Assignment", Long.class)
                .uniqueResult();

            // Get submitted assignments count
            Long submittedAssignments = session.createQuery(
                "select count(*) from Submission where student.id = :studentId", Long.class)
                .setParameter("studentId", studentId)
                .uniqueResult();

            // Get pending assignments (not submitted and not past deadline)
            Long pendingAssignments = session.createQuery(
                "select count(*) from Assignment a where a.deadline >= :today " +
                "and not exists (select 1 from Submission s where s.assignment = a and s.student.id = :studentId)", 
                Long.class)
                .setParameter("today", LocalDate.now())
                .setParameter("studentId", studentId)
                .uniqueResult();

            // Get overdue assignments (not submitted and past deadline)
            Long overdueAssignments = session.createQuery(
                "select count(*) from Assignment a where a.deadline < :today " +
                "and not exists (select 1 from Submission s where s.assignment = a and s.student.id = :studentId)", 
                Long.class)
                .setParameter("today", LocalDate.now())
                .setParameter("studentId", studentId)
                .uniqueResult();

            return new StudentStats(
                totalAssignments.intValue(),
                submittedAssignments.intValue(),
                pendingAssignments.intValue(),
                overdueAssignments.intValue()
            );
        } catch (Exception e) {
            System.err.println("Error retrieving student stats: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to retrieve student statistics", e);
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public boolean validateAssignment(UUID assignmentId) {
        Session session = HibernateUtil.getSession();
        try {
            Assignment assignment = session.get(Assignment.class, assignmentId);
            return assignment != null;
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public TeacherAssignmentStats getTeacherAssignments() {
        Session session = HibernateUtil.getSession();
        try {
            List<Assignment> assignments = session.createQuery(
                "from Assignment a order by a.deadline", Assignment.class)
                .getResultList();

            Long totalStudents = session.createQuery(
                "select count(*) from Student", Long.class)
                .uniqueResult();

            return new TeacherAssignmentStats(assignments, totalStudents.intValue());
        } catch (Exception e) {
            System.err.println("Error retrieving assignments: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Failed to retrieve assignments", e);
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public static class StudentStats {
        private final int totalAssignments;
        private final int submittedAssignments;
        private final int pendingAssignments;
        private final int overdueAssignments;

        public StudentStats(int totalAssignments, int submittedAssignments, 
                          int pendingAssignments, int overdueAssignments) {
            this.totalAssignments = totalAssignments;
            this.submittedAssignments = submittedAssignments;
            this.pendingAssignments = pendingAssignments;
            this.overdueAssignments = overdueAssignments;
        }

        public int getTotalAssignments() { return totalAssignments; }
        public int getSubmittedAssignments() { return submittedAssignments; }
        public int getPendingAssignments() { return pendingAssignments; }
        public int getOverdueAssignments() { return overdueAssignments; }
        
        public double getCompletionRate() {
            return totalAssignments == 0 ? 0 : 
                (submittedAssignments * 100.0) / totalAssignments;
        }

        public boolean hasOverdueAssignments() {
            return overdueAssignments > 0;
        }
    }

    public static class TeacherAssignmentStats {
        private final List<Assignment> assignments;
        private final int totalStudents;

        public TeacherAssignmentStats(List<Assignment> assignments, int totalStudents) {
            this.assignments = assignments;
            this.totalStudents = totalStudents;
        }

        public List<Assignment> getAssignments() {
            return assignments;
        }

        public int getTotalStudents() {
            return totalStudents;
        }
    }
} 