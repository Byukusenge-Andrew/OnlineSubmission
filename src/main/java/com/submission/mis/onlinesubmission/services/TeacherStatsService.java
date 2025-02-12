package com.submission.mis.onlinesubmission.services;

/**
 * Service class for managing teacher statistics.
 */
public class
TeacherStatsService {
    private static TeacherStatsService instance;

    private TeacherStatsService() {}

    public static TeacherStatsService getInstance() {
        if (instance == null) {
            instance = new TeacherStatsService();
        }
        return instance;
    }

    public TeacherStats createStats(int totalAssignments, int activeAssignments, int totalSubmissions) {
        return new TeacherStats(totalAssignments, activeAssignments, totalSubmissions);
    }

    public int calculatePendingAssignments(TeacherStats stats) {
        return stats.getTotalAssignments() - stats.getActiveAssignments();
    }
} 