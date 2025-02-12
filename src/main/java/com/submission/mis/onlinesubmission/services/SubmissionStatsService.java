package com.submission.mis.onlinesubmission.services;

import com.submission.mis.onlinesubmission.models.Assignment;
import com.submission.mis.onlinesubmission.util.HibernateUtil;
import org.hibernate.Session;

import java.time.LocalDate;
import java.util.UUID;

public class SubmissionStatsService {
    private static SubmissionStatsService instance;

    private SubmissionStatsService() {}

    public static SubmissionStatsService getInstance() {
        if (instance == null) {
            instance = new SubmissionStatsService();
        }
        return instance;
    }

    public SubmissionStats getSubmissionStats(UUID assignmentId) {
        Session session = HibernateUtil.getSession();
        try {
            Assignment assignment = session.get(Assignment.class, assignmentId);
            if (assignment == null) {
                return null;
            }

            long totalStudents = session.createQuery("select count(*) from Student", Long.class)
                    .uniqueResult();
            
            long submittedCount = session.createQuery(
                    "select count(*) from Submission where assignment.id = :assignmentId", Long.class)
                    .setParameter("assignmentId", assignmentId)
                    .uniqueResult();

            return new SubmissionStats(
                totalStudents,
                submittedCount,
                assignment.getDeadline().isBefore(LocalDate.now())
            );
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public double getSubmissionProgress(UUID assignmentId) {
        Session session = HibernateUtil.getSession();
        try {
            Long totalStudents = session.createQuery("select count(*) from Student", Long.class)
                    .uniqueResult();
            
            if (totalStudents == 0) return 0.0;

            Long submittedCount = session.createQuery(
                    "select count(*) from Submission where assignment.id = :assignmentId", Long.class)
                    .setParameter("assignmentId", assignmentId)
                    .uniqueResult();

            return (submittedCount.doubleValue() / totalStudents.doubleValue()) * 100;
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public static class SubmissionStats {
        private final long totalStudents;
        private final long submittedCount;
        private final boolean isPastDeadline;

        public SubmissionStats(long totalStudents, long submittedCount, boolean isPastDeadline) {
            this.totalStudents = totalStudents;
            this.submittedCount = submittedCount;
            this.isPastDeadline = isPastDeadline;
        }

        public long getTotalStudents() { return totalStudents; }
        public long getSubmittedCount() { return submittedCount; }
        public long getPendingCount() { return totalStudents - submittedCount; }
        public boolean isPastDeadline() { return isPastDeadline; }
        public double getSubmissionPercentage() {
            return totalStudents == 0 ? 0 : (submittedCount * 100.0) / totalStudents;
        }
    }
} 