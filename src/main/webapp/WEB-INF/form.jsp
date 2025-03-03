
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

</head>
<body>





<form action="studentRegistration"  method="POST">

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

    <label>ClassRoom</label>
    <select name="classroom" title="classroom" >
        <option name="classroom" value="A">A</option>
        <option name="classroom" value="B">B</option>
        <option name="classroom" value="C">C</option>
        <option name="classroom" value="D">D</option>
    </select>

    <label>Password</label>
    <input type="password" name="password"  title="password" required/>

  <input type="submit" value="Register" name="action"/>


</form>





</body>
</html>
