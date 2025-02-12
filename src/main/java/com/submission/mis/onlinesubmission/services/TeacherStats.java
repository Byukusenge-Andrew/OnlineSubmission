package com.submission.mis.onlinesubmission.services;

/**
 * Data class representing teacher statistics.
 */
public class TeacherStats {
    private final int totalAssignments;
    private final int activeAssignments;
    private final int totalSubmissions;

    public TeacherStats(int totalAssignments, int activeAssignments, int totalSubmissions) {
        this.totalAssignments = totalAssignments;
        this.activeAssignments = activeAssignments;
        this.totalSubmissions = totalSubmissions;
    }

    public int getTotalAssignments() { return totalAssignments; }
    public int getActiveAssignments() { return activeAssignments; }
    public int getTotalSubmissions() { return totalSubmissions; }
}
