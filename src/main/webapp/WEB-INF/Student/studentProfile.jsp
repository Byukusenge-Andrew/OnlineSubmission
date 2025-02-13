<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Student" %>
<%@ page import="com.submission.mis.onlinesubmission.services.StudentStatsService.StudentStats" %>
<%
    Student student = (Student) request.getAttribute("student");
    StudentStats stats = (StudentStats) request.getAttribute("stats");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Student Profile</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="app-container">
        <nav class="navbar">
            <div class="nav-container">
                <div class="nav-start">
                    <a href="${pageContext.request.contextPath}/studentHome" class="nav-link">
                        <i class="fas fa-home"></i> Home
                    </a>
                    <a href="${pageContext.request.contextPath}/viewAssignments" class="nav-link">
                        <i class="fas fa-tasks"></i> Assignments
                    </a>
                    <a href="${pageContext.request.contextPath}/studentProfile" class="nav-link active">
                        <i class="fas fa-user"></i> Profile
                    </a>
                </div>
                <div class="nav-end">
                    <span class="welcome-text">Welcome, <%= student.getFirstName() %></span>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>
        </nav>

        <div class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2><i class="fas fa-user-graduate"></i> Student Profile</h2>
                </div>
                <div class="card-body">
                    <div class="profile-info">
                        <h3>Personal Information</h3>
                        <p><strong>Name:</strong> <%= student.getFirstName() + " " + student.getLastName() %></p>
                        <p><strong>Email:</strong> <%= student.getEmail() %></p>
                        <p><strong>Age:</strong> <%= student.getAge() %></p>
                        <p><strong>Birth Date:</strong> <%= student.getBirthDate() %></p>
                    </div>
                    
                    <div class="stats-section mt-6">
                        <h3>Assignment Statistics</h3>
                        <div class="stats-grid">
                            <div class="stat-card bg-primary-light">
                                <div class="stat-icon"><i class="fas fa-tasks"></i></div>
                                <div class="stat-content">
                                    <h3>Total Assignments</h3>
                                    <div class="stat-value"><%= stats.getTotalAssignments() %></div>
                                </div>
                            </div>
                            
                            <div class="stat-card bg-success-light">
                                <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                                <div class="stat-content">
                                    <h3>Submitted</h3>
                                    <div class="stat-value"><%= stats.getSubmittedAssignments() %></div>
                                </div>
                            </div>
                            
                            <div class="stat-card bg-warning-light">
                                <div class="stat-icon"><i class="fas fa-clock"></i></div>
                                <div class="stat-content">
                                    <h3>Pending</h3>
                                    <div class="stat-value"><%= stats.getPendingAssignments() %></div>
                                </div>
                            </div>
                            
                            <div class="stat-card bg-error-light">
                                <div class="stat-icon"><i class="fas fa-exclamation-circle"></i></div>
                                <div class="stat-content">
                                    <h3>Overdue</h3>
                                    <div class="stat-value"><%= stats.getOverdueAssignments() %></div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="progress-container mt-6">
                            <h3>Completion Rate</h3>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: <%= stats.getCompletionRate() %>%"></div>
                            </div>
                            <p class="progress-text"><%= String.format("%.1f%%", stats.getCompletionRate()) %> Complete</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 