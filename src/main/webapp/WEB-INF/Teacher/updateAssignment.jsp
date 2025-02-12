<%@ page import="com.submission.mis.onlinesubmission.models.Assignment" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:22
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Assignment</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
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
            max-width: 800px;
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
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        table td:first-child {
            font-weight: 500;
            color: #555;
            width: 30%;
        }
        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            transition: border-color 0.3s, box-shadow 0.3s;
        }
        input[type="text"]:focus,
        input[type="date"]:focus,
        textarea:focus {
            border-color: #007bff;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
            outline: none;
        }
        textarea {
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
            table td {
                display: block;
                width: 100%;
                text-align: left;
            }
            table td:first-child {
                font-weight: 600;
                margin-top: 10px;
            }
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Update Assignment</h2>
    <form action="updateAssignment" method="post">
        <input type="hidden" name="action" value="updateAssignment"/>
        <%
            Assignment prevAssignment = (Assignment) request.getAttribute("PrevAssignment");
        %>
        <input type="hidden" name="assignmentId" value="${param.assignmentId}"/>
        <table>
            <tr>
                <td><strong>Previous Title:</strong></td>
                <td>${prevAssignment.getTitle()}</td>
            </tr>
            <tr>
                <td>New Title:</td>
                <td><input type="text" name="title" value="${prevAssignment.getTitle()}" required/></td>
            </tr>
            <tr>
                <td><strong>Previous Description:</strong></td>
                <td>${prevAssignment.getDescription()}</td>
            </tr>
            <tr>
                <td>New Description:</td>
                <td><textarea name="description" required>${prevAssignment.getDescription()}</textarea></td>
            </tr>
            <tr>
                <td><strong>Previous Deadline:</strong></td>
                <td>${prevAssignment.getDeadline()}</td>
            </tr>
            <tr>
                <td>New Deadline:</td>
                <td><input type="date" name="deadline" value="${prevAssignment.getDeadline()}" required/></td>
            </tr>
        </table>
        <input type="submit" value="Update Assignment"/>
    </form>
</div>
</body>
</html>