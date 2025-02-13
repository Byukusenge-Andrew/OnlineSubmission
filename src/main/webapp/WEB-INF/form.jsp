<%@ page import="com.submission.mis.onlinesubmission.models.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.LocalDate" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 06/02/2025
  Time: 14:36
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<html>
<head>
    <title>Registration</title>
    <link rel="stylesheet" href="css/styles.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f4;
            margin: 20px;
            padding: 20px;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            max-width: 400px;
            background: white;
            padding: 20px;
            margin: auto;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-top: 10px;
        }

        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 8px;
            margin-top: 5px;
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            background: #28a745;
            border: none;
            color: white;
            font-size: 16px;
            margin-top: 15px;
            cursor: pointer;
            border-radius: 5px;
        }

        input[type="submit"]:hover {
            background: #218838;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            overflow: hidden;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background: #007bff;
            color: white;
        }

        tr:nth-child(even) {
            background: #f9f9f9;
        }

        tr:hover {
            background: #f1f1f1;
        }

        .no-data {
            text-align: center;
            font-size: 18px;
            color: #666;
            padding: 20px;
        }

        .error-message {
            color: red;
            margin-top: 10px;
            text-align: center;
        }
    </style>
</head>
<body>

<h2>${formName}</h2>

<% if(request.getAttribute("error") != null) { %>
    <div class="error-message">
        ${error}
    </div>
<% } %>

<form action="studentRegistration" method="POST">
    <label>First Name</label>
    <input type="text" name="firstname" title="FirstName" 
           value="${firstname}" required pattern="[A-Za-z\s-']{2,50}"
           title="Name must contain only letters, spaces, hyphens or apostrophes"/>

    <label>Last Name</label>
    <input type="text" name="lastname" title="LastName" 
           value="${lastname}" required pattern="[A-Za-z\s-']{2,50}"
           title="Name must contain only letters, spaces, hyphens or apostrophes"/>

    <label>Date of Birth</label>
    <input type="date" name="dob" title="dob" 
           value="${dob}" required max="<%= LocalDate.now().minusYears(16) %>"/>

    <label>Email</label>
    <input type="email" name="email" title="Email" 
           value="${email}" required/>

    <label>Password</label>
    <input type="password" name="password"  title="password" required/>

    <input type="submit" value="Register" name="action"/>
</form>




</body>
</html>
