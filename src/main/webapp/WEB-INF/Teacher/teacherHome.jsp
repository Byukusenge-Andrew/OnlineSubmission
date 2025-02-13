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
    <style>
        body {
            font-family: 'Inter', sans-serif;
            background: #f5f7fa;
            margin: 0;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        nav {
            margin-bottom: 2rem;
        }

        nav ul {
            list-style: none;
            padding: 0;
            display: flex;
            gap: 1rem;
            flex-wrap: wrap;
        }

        nav ul li a {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background: var(--primary);
            color: white;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        nav ul li a:hover {
            background: var(--secondary);
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        h2 {
            color: #2d3748;
            font-size: 2rem;
            margin-bottom: 1.5rem;
            text-align: center;
        }

        table {
            width: 100%;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border-collapse: collapse;
            margin-bottom: 2rem;
            overflow: hidden;
        }

        th {
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            color: white;
            padding: 1rem;
            text-align: left;
            font-weight: 600;
        }

        td {
            padding: 1rem;
            border-bottom: 1px solid #e2e8f0;
            color: #4a5568;
        }

        .submission-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .submission-list li {
            padding: 0.5rem 0;
            border-bottom: 1px solid #edf2f7;
        }

        .submission-list li:last-child {
            border-bottom: none;
        }

        .download-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .download-link:hover {
            color: var(--secondary);
        }

        .submission-time {
            font-size: 0.875rem;
            color: #718096;
        }

        .actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .button {
            padding: 0.5rem 1rem;
            border-radius: 5px;
            text-decoration: none;
            color: white;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .button.edit {
            background: #48bb78;
        }

        .button.delete {
            background: #f56565;
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        .owner-info {
            font-size: 0.875rem;
            color: #718096;
        }

        @media (max-width: 768px) {
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            .actions {
                flex-direction: column;
            }

            nav ul {
                flex-direction: column;
            }

            nav ul li a {
                width: 100%;
                text-align: center;
            }
        }

        /* Navigation Styles */
        .navbar {
            background: white;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
            margin-bottom: 2rem;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .nav-brand {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary);
            text-decoration: none;
        }

        .nav-links {
            display: flex;
            gap: 1.5rem;
            list-style: none;
            margin: 0;
            padding: 0;
        }

        .nav-links a {
            color: #4a5568;
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            color: var(--primary);
            background: #f7fafc;
        }

        .nav-links .active {
            color: var(--primary);
            background: #f7fafc;
        }

        .logout-btn {
            background: #f56565;
            color: white !important;
        }

        .logout-btn:hover {
            background: #e53e3e !important;
        }

        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 1rem;
            }

            .nav-links {
                flex-direction: column;
                width: 100%;
                text-align: center;
            }
        }

        .submission-stats {
            background: white;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 1rem;
        }

        .stat-item {
            text-align: center;
            padding: 1rem;
            background: #F7FAFC;
            border-radius: 6px;
        }

        .stat-value {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #4A5568;
            font-size: 0.875rem;
        }

        .progress-bar {
            width: 100%;
            height: 8px;
            background: #EDF2F7;
            border-radius: 4px;
            margin-top: 1rem;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            transition: width 0.3s ease;
        }

        .all-submitted {
            background: #C6F6D5;
            color: #22543D;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            margin-top: 1rem;
            text-align: center;
            font-weight: 500;
        }
    </style>
</head>
<body class="bg-surface-50">
    <div class="app-container">
        <header class="header">
            <nav class="navbar">
                <div class="nav-container">
                    <a href="teacherHome" class="nav-brand">Teacher Portal</a>
                    <ul class="nav-links">
                        <li><a href="teacherHome">Dashboard</a></li>
                        <li><a href="teacherAssignments" class="active">Assignments</a></li>
                        <li><a href="addAssignment">Add Assignment</a></li>
                        <li><a href="teacherProfile">Profile</a></li>
                        <li><a href="logout" class="logout-btn">Logout</a></li>
                    </ul>
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