<%@ page import="com.submission.mis.onlinesubmission.models.Student" %>
<%@ page import="java.util.List" %>
<!-- teacherForm.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Teacher Registration</title>
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
<form action="teacherRegistration" method="post">
    <%--@declare id="course"--%><input type="hidden" name="action" value="register"/>
    <label for="fname">First Name:</label>
    <input type="text" id="fname" name="fname" required/><br/>

    <label for="lname">Last Name:</label>
    <input type="text" id="lname" name="lname" required/><br/>

    <label for="email">Email:</label>
    <input type="email" id="email" name="email" required/><br/>

    <label for="course">Course:</label>
<%--    <input type="text" id="course" name="course" required>    --%>
        <select name="course" title="Select course" required>
            <option>DSA</option>
            <option>Math</option>
            <option>English</option>
            <option>Networking</option>
            <option>Java</option>
            <option>Physics</option>
        </select>

    <label for="password">Password:</label>
    <input type="password" id="password" name="password" required/><br/>

    <label for="hireDate">Hire Date:</label>
    <input type="date" id="hireDate" name="hireDate" required/><br/>

    <input type="submit" value="Register" name="action"/>
</form>
<h2>
    ${message2}
</h2>


</body>
</html>
