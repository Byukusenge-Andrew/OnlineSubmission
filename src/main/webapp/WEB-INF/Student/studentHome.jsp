<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Student" %>
<%
    Student student = (Student) request.getAttribute("currentStudent");
    if (student == null) {
        response.sendRedirect(request.getContextPath() + "/studentLogin");
        return;
    }
    int totalAssignments = (Integer) request.getAttribute("totalAssignments");
    int submittedAssignments = (Integer) request.getAttribute("submittedAssignments");
    int pendingAssignments = (Integer) request.getAttribute("pendingAssignments");
    int overdueAssignments = (Integer) request.getAttribute("overdueAssignments");
    double completionRate = (Double) request.getAttribute("completionRate");
    boolean hasOverdue = (Boolean) request.getAttribute("hasOverdue");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-surface-50">
    <div class="app-container">
        <nav class="navbar">
            <div class="nav-container">
                <div class="nav-start">
                    <a href="${pageContext.request.contextPath}/studentHome" class="nav-link active">
                        <i class="fas fa-home"></i> Home
                    </a>
                    <a href="${pageContext.request.contextPath}/viewAssignments" class="nav-link">
                        <i class="fas fa-tasks"></i> Assignments
                    </a>
                    <a href="${pageContext.request.contextPath}/studentProfile" class="nav-link">
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

        <main class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2><i class="fas fa-tachometer-alt"></i> Student Dashboard</h2>
                </div>
                <div class="card-body">
                    <div class="stats-grid">
                        <div class="stat-card bg-primary-light">
                            <div class="stat-icon"><i class="fas fa-tasks"></i></div>
                            <div class="stat-content">
                                <h3>Total Assignments</h3>
                                <div class="stat-value"><%= totalAssignments %></div>
                            </div>
                        </div>
                        
                        <div class="stat-card bg-success-light">
                            <div class="stat-icon"><i class="fas fa-check-circle"></i></div>
                            <div class="stat-content">
                                <h3>Submitted</h3>
                                <div class="stat-value"><%= submittedAssignments %></div>
                            </div>
                        </div>
                        
                        <div class="stat-card bg-warning-light">
                            <div class="stat-icon"><i class="fas fa-clock"></i></div>
                            <div class="stat-content">
                                <h3>Pending</h3>
                                <div class="stat-value"><%= pendingAssignments %></div>
                            </div>
                        </div>
                        
                        <div class="stat-card <%= hasOverdue ? "bg-error-light" : "bg-success-light" %>">
                            <div class="stat-icon">
                                <i class="fas <%= hasOverdue ? "fa-exclamation-circle" : "fa-check-double" %>"></i>
                            </div>
                            <div class="stat-content">
                                <h3>Overdue</h3>
                                <div class="stat-value"><%= overdueAssignments %></div>
                            </div>
                        </div>
                    </div>

                    <div class="progress-container mt-6">
                        <h3>Overall Progress</h3>
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: <%= completionRate %>%"></div>
                        </div>
                        <p class="progress-text"><%= String.format("%.1f%%", completionRate) %> Complete</p>
                    </div>

                    <div class="action-buttons mt-6">
                        <a href="${pageContext.request.contextPath}/viewAssignments" class="btn btn-primary">
                            <i class="fas fa-tasks"></i> View Assignments
                        </a>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
