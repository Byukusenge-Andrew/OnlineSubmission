<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Assignment</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
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

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        body {
            background: linear-gradient(to right, #4facfe, #00f2fe);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            width: 90%;
            max-width: 600px;
            animation: fadeIn 0.5s ease-in-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        h2 {
            color: #333;
            text-align: center;
            margin-bottom: 20px;
            font-size: 24px;
        }
        .error-message {
            background: #ffebee;
            color: #c62828;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
            text-align: center;
            animation: shake 0.5s ease-in-out;
        }
        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-10px); }
            50% { transform: translateX(10px); }
            75% { transform: translateX(-10px); }
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            color: #555;
            margin-bottom: 5px;
            font-weight: 500;
        }
        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        .form-group input:focus,
        .form-group textarea:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            outline: none;
        }
        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: background 0.3s, transform 0.3s;
        }
        input[type="submit"]:hover {
            background: #0056b3;
            transform: translateY(-2px);
        }
        @media (max-width: 768px) {
            .container {
                padding: 20px;
            }
            h2 {
                font-size: 22px;
            }
        }
    </style>
    <script>
        function validateForm() {
            var title = document.forms["assignmentForm"]["title"].value;
            var description = document.forms["assignmentForm"]["description"].value;
            var postTime = new Date(document.forms["assignmentForm"]["postTime"].value);
            var deadline = new Date(document.forms["assignmentForm"]["deadline"].value);
            var today = new Date();

            if (title.length < 3) {
                alert("Title must be at least 3 characters long");
                return false;
            }
            if (description.length < 10) {
                alert("Description must be at least 10 characters long");
                return false;
            }
            if (deadline < today) {
                alert("Deadline cannot be in the past");
                return false;
            }

            return true;
        }
    </script

</head>
<body>
<div class="container">
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
    <h2>Add New Assignment</h2>

    <% if(request.getAttribute("error") != null) { %>
    <div class="error-message">
        ${error}
    </div>
    <% } %>

    <form action="addAssignment" method="post" onsubmit="return validateForm()" name="assignmentForm">
        <input type="hidden" name="action" value="addAssignment"/>

        <div class="form-group">
            <label for="title">Title:</label>
            <input type="text" id="title" name="title" value="${title}" required minlength="3"/>
        </div>

        <div class="form-group">
            <label for="description">Description:</label>
            <textarea id="description" name="description" required minlength="10">${description}</textarea>
        </div>



        <div class="form-group">
            <label for="deadline">Deadline:</label>
            <input type="date" id="deadline" name="deadline" value="${deadline}" required/>
        </div>

        <input type="submit" value="Add Assignment" name="action"/>
    </form>
</div>
</body>
</html>