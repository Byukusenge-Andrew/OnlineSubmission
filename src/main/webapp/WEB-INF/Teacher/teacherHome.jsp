<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
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
                        Welcome, <strong>${sessionScope.teacherName}</strong>
                    </span>
                </div>
                <div class="nav-end">
                    <a href="${pageContext.request.contextPath}/addAssignment" class="btn btn-secondary">
                        <i class="fas fa-plus"></i> New Assignment
                    </a>
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-danger">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </nav>
        </header>

        <main class="main-content">
            <!-- Stats Overview -->
            <div>
                <ul>
                    <li>names: ${sessionScope.teacherId}</li>
                </ul>
            </div>
            <div class="stats-grid">
                <div class="stat-card bg-primary-light">
                    <div class="stat-icon">
                        <i class="fas fa-book-open"></i>
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
                
                <div class="stat-card bg-error-light">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-content">
                        <h3>Total Students</h3>
                        <p class="stat-value">${totalStudents}</p>
                    </div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="card-grid">
                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">
                            <i class="fas fa-tasks"></i>
                            Quick Actions
                        </h2>
                    </div>
                    <div class="card-body">
                        <div class="quick-actions">
                            <a href="${pageContext.request.contextPath}/addAssignment" class="action-btn">
                                <i class="fas fa-plus-circle"></i>
                                Create Assignment
                            </a>
                            <a href="${pageContext.request.contextPath}/teacherAssignments" class="action-btn">
                                <i class="fas fa-list"></i>
                                View Assignments
                            </a>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="card-header">
                        <h2 class="card-title">
                            <i class="fas fa-chart-bar"></i>
                            Submission Progress
                        </h2>
                    </div>
                    <div class="card-body">
                        <div class="progress-container">
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: ${submissionPercentage}%"></div>
                            </div>
                            <p class="progress-text">
                                ${submittedStudents} out of ${totalStudents} students submitted
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>

    <style>
        .nav-container {
            display: grid;
            grid-template-columns: 1fr auto 1fr;
            align-items: center;
            gap: 2rem;
        }

        .welcome-text {
            color: var(--surface-600);
            font-size: 1.1rem;
        }

        .nav-end {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            padding: 1.5rem;
            border-radius: var(--radius-lg);
            display: flex;
            align-items: center;
            gap: 1rem;
            transition: transform var(--transition-normal);
        }

        .stat-card:hover {
            transform: translateY(-4px);
        }

        .stat-icon {
            font-size: 2rem;
            color: var(--primary-600);
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 600;
            color: var(--primary-700);
        }

        .card-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .action-btn {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            padding: 1rem;
            background: var(--surface-50);
            border-radius: var(--radius-md);
            color: var(--surface-900);
            text-decoration: none;
            transition: all var(--transition-fast);
        }

        .action-btn:hover {
            background: var(--primary-50);
            color: var(--primary-700);
            transform: translateY(-2px);
        }

        .progress-container {
            padding: 1rem;
        }

        .progress-bar {
            height: 1rem;
            background: var(--surface-200);
            border-radius: var(--radius-full);
            overflow: hidden;
            margin-bottom: 1rem;
        }

        .progress-fill {
            height: 100%;
            background: var(--primary-600);
            border-radius: var(--radius-full);
            transition: width 1s ease-in-out;
        }

        .progress-text {
            text-align: center;
            color: var(--surface-600);
            font-size: 0.875rem;
        }

        @media (max-width: 768px) {
            .nav-container {
                grid-template-columns: 1fr;
                gap: 1rem;
                padding: 1rem;
            }

            .nav-end {
                justify-content: center;
            }

            .welcome-text {
                text-align: center;
            }
        }
    </style>
</body>
</html>