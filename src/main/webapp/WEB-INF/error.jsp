<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Login Error</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body>
    <div class="container">
        <h2>Login Error</h2>
        <div class="error-message">
            Invalid username or password. Please try again.
        </div>
        <p>
            <a href="${pageContext.request.contextPath}/index.jsp">Return to Home</a>
        </p>
    </div>
</body>
</html> 