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
    </script>
</head>
<body>
<div class="container">
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