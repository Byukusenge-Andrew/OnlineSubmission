<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title} - Online Submission System</title>
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3B82F6',
                        secondary: '#10B981',
                        accent: '#8B5CF6',
                        danger: '#EF4444',
                        warning: '#F59E0B',
                        info: '#3B82F6',
                        success: '#10B981',
                    }
                }
            }
        }
    </script>
    <!-- Additional styles -->
    <style type="text/tailwindcss">
        @layer components {
            .btn {
                @apply px-4 py-2 rounded font-medium transition-colors duration-200;
            }
            .btn-primary {
                @apply bg-primary text-white hover:bg-blue-700;
            }
            .btn-secondary {
                @apply bg-secondary text-white hover:bg-green-700;
            }
            .btn-danger {
                @apply bg-danger text-white hover:bg-red-700;
            }
            .form-input {
                @apply w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent;
            }
            .form-label {
                @apply block text-sm font-medium text-gray-700 mb-1;
            }
            .card {
                @apply bg-white rounded-lg shadow-md overflow-hidden;
            }
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen">
    <nav class="bg-primary shadow-md">
        <div class="max-w-7xl mx-auto px-4">
            <div class="flex justify-between h-16">
                <div class="flex">
                    <a href="${pageContext.request.contextPath}/index.jsp" class="flex items-center text-white font-bold text-xl">
                        Online Submission
                    </a>
                </div>
                
                <div class="flex items-center">
                    <% if (session != null && session.getAttribute("userType") != null) { %>
                        <% if (session.getAttribute("userType").equals("student")) { %>
                            <a href="${pageContext.request.contextPath}/studentHome" 
                               class="text-white hover:text-gray-200 px-3 py-2">Home</a>
                            <a href="${pageContext.request.contextPath}/viewAssignments" 
                               class="text-white hover:text-gray-200 px-3 py-2">Assignments</a>
                            <a href="${pageContext.request.contextPath}/studentProfile" 
                               class="text-white hover:text-gray-200 px-3 py-2">Profile</a>
                            <a href="${pageContext.request.contextPath}/logout" 
                               class="text-white hover:text-gray-200 px-3 py-2 ml-4">Logout</a>
                        <% } else if (session.getAttribute("userType").equals("teacher")) { %>
                            <a href="${pageContext.request.contextPath}/teacherHome" 
                               class="text-white hover:text-gray-200 px-3 py-2">Home</a>
                            <a href="${pageContext.request.contextPath}/teacherAssignments" 
                               class="text-white hover:text-gray-200 px-3 py-2">Assignments</a>
                            <a href="${pageContext.request.contextPath}/teacherProfile" 
                               class="text-white hover:text-gray-200 px-3 py-2">Profile</a>
                            <a href="${pageContext.request.contextPath}/logout" 
                               class="text-white hover:text-gray-200 px-3 py-2 ml-4">Logout</a>
                        <% } %>
                    <% } %>
                </div>
            </div>
        </div>
    </nav>
    <main class="max-w-7xl mx-auto px-4 py-6"> 