<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 07/02/2025
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Student Login</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        /* CSS Styles for Student Login Page */

        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        .container {
            background-color: #ffffff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }

        h2 {
            text-align: center;
            color: #333333;
        }

        .form-group {
            margin-bottom: 15px;
        }

        label {
            display: block;
            margin-bottom: 5px;
            color: #555555;
        }

        .input-field {
            width: 100%;
            padding: 8px;
            border: 1px solid #cccccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        .submit-button {
            width: 100%;
            padding: 10px;
            background-color: #34e80c;
            border: none;
            border-radius: 4px;
            color: white;
            font-size: 16px;
            cursor: pointer;
        }

        .submit-button:hover {
            background-color: #0056b3;
        }

        .message {
            text-align: center;
            padding: 10px;
            margin-top: 10px;
            border-radius: 4px;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Student Login</h2>

    <form action="studentLogin" method="post" class="login-form">
        <input type="hidden" name="action" value="login"/>

        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" class="input-field" required/>
        </div>

        <div class="form-group">
            <label for="password">Password:</label>
            <input type="password" id="password" name="password" class="input-field" required/>
        </div>

        <div class="form-group">
            <input type="submit" value="Login" class="submit-button" name="action"/>
        </div>
    </form>

    <% if(request.getAttribute("message") != null) { %>
    <div class="message ${message.contains('success') ? 'success' : 'error'}">
        ${message}
    </div>
    <% } %>
</div>
</body>
</html>
