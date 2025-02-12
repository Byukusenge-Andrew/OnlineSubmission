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
</head>
<body>
    <div class="container">
        <h2>Student Login</h2>
        
        <form action="studentLogin" method="post" class="login-form">
            <input type="hidden" name="action" value="login"/>
            
            <div class="form-group">
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" required/>
            </div>

            <div class="form-group">
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" required/>
            </div>

            <div class="form-group">
                <input type="submit" value="Login" name="action"/>
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
