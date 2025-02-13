<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Assignment" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Teacher" %>
<%
    Assignment prevAssignment = (Assignment) request.getAttribute("PrevAssignment");
    if (prevAssignment == null) {
        response.sendRedirect(request.getContextPath() + "/teacherAssignments");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Assignment</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
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
<body>
    <div class="app-container">
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

        <div class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2><i class="fas fa-edit"></i> Update Assignment</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/updateAssignment" method="post" class="form">
                        <input type="hidden" name="action" value="updateAssignment">
                        <input type="hidden" name="assignmentId" value="<%= prevAssignment.getId() %>">

                        <div class="form-group">
                            <label for="title">
                                <i class="fas fa-heading"></i> Title
                            </label>
                            <input type="text" id="title" name="title" required 
                                   value="<%= prevAssignment.getTitle() %>">
                        </div>

                        <div class="form-group">
                            <label for="description">
                                <i class="fas fa-align-left"></i> Description
                            </label>
                            <textarea id="description" name="description" required 
                                      rows="4"><%= prevAssignment.getDescription() %></textarea>
                        </div>

                        <div class="form-group">
                            <label for="course">
                                <i class="fas fa-book"></i> Course
                            </label>
                            <input type="text" id="course" name="course" required 
                                   value="<%= prevAssignment.getCourse() %>">
                        </div>

                        <div class="form-group">
                            <label for="deadline">
                                <i class="fas fa-calendar"></i> Deadline
                            </label>
                            <input type="date" id="deadline" name="deadline" required 
                                   value="<%= prevAssignment.getDeadline() %>">
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Update Assignment
                            </button>
                            <a href="${pageContext.request.contextPath}/teacherAssignments" 
                               class="btn btn-outline">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>