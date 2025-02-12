<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        <header class="header">
            <nav class="nav-container">
                <div class="nav-start">
                    <a href="${pageContext.request.contextPath}/" class="nav-brand">
                        <i class="fas fa-graduation-cap"></i>
                        Assignment Portal
                    </a>
                </div>
                <div class="nav-middle">
                    <span class="welcome-text">
                        Welcome, <strong>${sessionScope.studentName}</strong>
                    </span>
                </div>
                <div class="nav-end">
                    <a href="${pageContext.request.contextPath}/viewAssignments" class="btn btn-secondary">
                        <i class="fas fa-tasks"></i> View Assignments
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </nav>
        </header>

        <main class="main-content">
            <div class="stats-grid">
                <div class="stat-card bg-primary-light">
                    <div class="stat-icon">
                        <i class="fas fa-book"></i>
                    </div>
                    <div class="stat-content">
                        <h3>Total Assignments</h3>
                        <p class="stat-value">${totalAssignments}</p>
                    </div>
                </div>
                
                <div class="stat-card bg-success-light">
                    <div class="stat-icon">
                        <i class="fas fa-check-circle"></i>
                    </div>
                    <div class="stat-content">
                        <h3>Submitted</h3>
                        <p class="stat-value">${submittedAssignments}</p>
                    </div>
                </div>
                
                <div class="stat-card bg-warning-light">
                    <div class="stat-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <div class="stat-content">
                        <h3>Pending</h3>
                        <p class="stat-value">${pendingAssignments}</p>
                    </div>
                </div>
                
                <div class="stat-card ${hasOverdue ? 'bg-error-light' : 'bg-surface-100'}">
                    <div class="stat-icon">
                        <i class="fas fa-exclamation-triangle"></i>
                    </div>
                    <div class="stat-content">
                        <h3>Overdue</h3>
                        <p class="stat-value">${overdueAssignments}</p>
                    </div>
                </div>
            </div>

            <div class="card mt-6">
                <div class="card-header">
                    <h2 class="card-title">
                        <i class="fas fa-chart-line"></i>
                        Overall Progress
                    </h2>
                </div>
                <div class="card-body">
                    <div class="progress-container">
                        <div class="progress-bar">
                            <div class="progress-fill" style="width: ${completionRate}%"></div>
                        </div>
                        <p class="progress-text">
                            Completion Rate: ${String.format("%.1f", completionRate)}%
                        </p>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
