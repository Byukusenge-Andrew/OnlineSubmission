<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 07/02/2025
  Time: 13:24
  To change this template use File | Settings | File Templates.
--%>
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
    <title>Teacher Login</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=JetBrains+Mono:wght@400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body class="bg-surface-50">
    <div class="app-container">
        <header class="header">
            <nav class="nav-container">
                <a href="${pageContext.request.contextPath}/" class="nav-brand">
                    <i class="fas fa-graduation-cap"></i>
                    Assignment Portal
                </a>
                <div class="nav-links">
                    <a href="${pageContext.request.contextPath}/teacherRegistration" class="btn btn-secondary">Register</a>
                </div>
            </nav>
        </header>

        <main class="main-content">
            <div class="card max-w-md mx-auto">
                <div class="card-header">
                    <h1 class="text-xl font-semibold text-center">Teacher Login</h1>
                </div>
                
                <div class="card-body">
                    <form action="teacherLogin" method="post">
                        <input type="hidden" name="action" value="login"/>
                        
                        <div class="form-group">
                            <label class="form-label" for="email">
                                <i class="fas fa-envelope text-surface-500"></i>
                                Email
                            </label>
                            <input type="email" id="email" name="email" 
                                   class="form-control" required 
                                   placeholder="Enter your email"/>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="password">
                                <i class="fas fa-lock text-surface-500"></i>
                                Password
                            </label>
                            <input type="password" id="password" name="password" 
                                   class="form-control" required
                                   placeholder="Enter your password"/>
                        </div>

                        <button type="submit" class="btn btn-primary w-full">
                            <i class="fas fa-sign-in-alt"></i>
                            Login
                        </button>
                    </form>

                    <% if (request.getAttribute("message") != null) { %>
                        <div class="alert alert-success mt-4">
                            <i class="fas fa-check-circle"></i>
                            ${message}
                        </div>
                    <% } %>

                    <% if (request.getAttribute("error") != null) { %>
                        <div class="alert alert-error mt-4">
                            <i class="fas fa-exclamation-circle"></i>
                            ${error}
                        </div>
                    <% } %>
                </div>

                <div class="card-footer text-center">
                    <p class="text-surface-600">Don't have an account?</p>
                    <a href="teacherRegistration" class="btn btn-secondary mt-2">
                        <i class="fas fa-user-plus"></i>
                        Register Now
                    </a>
                </div>
            </div>
        </main>
    </div>

    <style>
        .max-w-md {
            max-width: 28rem;
        }
        .mx-auto {
            margin-left: auto;
            margin-right: auto;
        }
        .mt-2 {
            margin-top: 0.5rem;
        }
        .mt-4 {
            margin-top: 1rem;
        }
        .w-full {
            width: 100%;
        }
        .text-center {
            text-align: center;
        }
    </style>
</body>
</html>