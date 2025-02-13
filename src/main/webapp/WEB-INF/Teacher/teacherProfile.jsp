<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Teacher" %>
<%@ page import="com.submission.mis.onlinesubmission.services.TeacherStats" %>
<%
    Teacher teacher = (Teacher) request.getAttribute("teacher");
    TeacherStats stats = (TeacherStats) request.getAttribute("stats");
    Long totalStudents = (Long) request.getAttribute("totalStudents");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Teacher Profile</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="app-container">
        <div class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2><i class="fas fa-chalkboard-teacher"></i> Teacher Profile</h2>
                </div>
                <div class="card-body">
                    <div class="profile-info">
                        <h3>Personal Information</h3>
                        <p><strong>Name:</strong> <%= teacher.getFirstName() + " " + teacher.getLastName() %></p>
                        <p><strong>Email:</strong> <%= teacher.getEmail() %></p>
                        <p><strong>Course:</strong> <%= teacher.getCourse() %></p>
                        <p><strong>Hire Date:</strong> <%= teacher.getHireDate() %></p>
                    </div>
                    
                    <div class="stats-section mt-6">
                        <h3>Teaching Statistics</h3>
                        <div class="stats-grid">
                            <div class="stat-card bg-primary-light">
                                <div class="stat-icon"><i class="fas fa-book"></i></div>
                                <div class="stat-content">
                                    <h3>Total Assignments</h3>
                                    <div class="stat-value"><%= stats.getTotalAssignments() %></div>
                                </div>
                            </div>
                            
                            <div class="stat-card bg-success-light">
                                <div class="stat-icon"><i class="fas fa-user-graduate"></i></div>
                                <div class="stat-content">
                                    <h3>Total Students</h3>
                                    <div class="stat-value"><%= totalStudents %></div>
                                </div>
                            </div>
                            
                            <div class="stat-card bg-warning-light">
                                <div class="stat-icon"><i class="fas fa-clock"></i></div>
                                <div class="stat-content">
                                    <h3>Active Assignments</h3>
                                    <div class="stat-value"><%= stats.getActiveAssignments() %></div>
                                </div>
                            </div>
                            
                            <div class="stat-card bg-info-light">
                                <div class="stat-icon"><i class="fas fa-file-alt"></i></div>
                                <div class="stat-content">
                                    <h3>Total Submissions</h3>
                                    <div class="stat-value"><%= stats.getTotalSubmissions() %></div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 