<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:16
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Assignment" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Submission" %>
<%@ page import="java.util.UUID" %>
<html>
<head>
    <title>View Assignments</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/styles.css">
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

        tr:hover {
            background-color: #f8fafc;
            transition: background-color 0.3s ease;
        }

        .button {
            display: inline-block;
            padding: 0.5rem 1rem;
            background: var(--primary);
            color: black;
            text-decoration: none;
            border-radius: 5px;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .button:hover {
            background: #00f2fe;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
        }

        tr:last-child td {
            border-bottom: none;
        }

        @media (max-width: 768px) {
            table {
                display: block;
                overflow-x: auto;
                white-space: nowrap;
            }

            th, td {
                padding: 0.75rem;
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

        .status-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 15px;
            font-size: 0.875rem;
            font-weight: 500;
        }

        .status-submitted {
            background: #C6F6D5;
            color: #22543D;
        }

        .status-pending {
            background: #FED7D7;
            color: #822727;
        }

        .button.disabled {
            background: #CBD5E0;
            cursor: not-allowed;
            pointer-events: none;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <a href="studentHome" class="nav-brand">Student Portal</a>
            <ul class="nav-links">
                <li><a href="studentHome">Dashboard</a></li>
                <li><a href="viewAssignments" class="active">Assignments</a></li>
                <li><a href="studentProfile">Profile</a></li>
                <li><a href="logout" class="logout-btn">Logout</a></li>
            </ul>
        </div>
    </nav>

    <div class="container">
        <h2>Assignments</h2>
        <table>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Course</th>
                <th>Instructor</th>
                <th>Post Time</th>
                <th>Deadline</th>
                <th>Status</th>
                <th>Action</th>
            </tr>
            <%
                List<Assignment> assignments = (List<Assignment>) request.getAttribute("assignments");
                UUID currentStudentId = (UUID) session.getAttribute("studentId");
                
                if (assignments != null) {
                    for (Assignment assignment : assignments) {
                        boolean hasSubmitted = false;
                        for (Submission submission : assignment.getSubmissions()) {
                            if (submission.getStudent().getId().equals(currentStudentId)) {
                                hasSubmitted = true;
                                break;
                            }
                        }
            %>
            <tr>
                <td><%= assignment.getTitle() %></td>
                <td><%= assignment.getDescription() %></td>
                <td><%= assignment.getCourse()%></td>
                <td><%= assignment.getTeacher().getName()%></td>
                <td><%= assignment.getPosttime() %></td>
                <td><%= assignment.getDeadline() %></td>
                <td>
                    <% if (hasSubmitted) { %>
                        <span class="status-badge status-submitted">Submitted</span>
                    <% } else { %>
                        <span class="status-badge status-pending">Pending</span>
                    <% } %>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/submitAssignment?assignmentId=<%= assignment.getId() %>" 
                       class="button <%= hasSubmitted ? "disabled" : "" %>">
                        <%= hasSubmitted ? "Submitted" : "Submit" %>
                    </a>
                </td>
            </tr>
            <%
                    }
                }
            %>
        </table>
    </div>
</body>
</html>