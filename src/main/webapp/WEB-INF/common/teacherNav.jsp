<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<nav class="bg-secondary text-white shadow-md">
    <div class="container mx-auto px-4">
        <div class="flex justify-between items-center py-4">
            <div class="flex items-center space-x-4">
                <a href="${pageContext.request.contextPath}/teacherHome" class="text-xl font-bold">Online Submission</a>
            </div>
            <div class="flex items-center space-x-6">
                <a href="${pageContext.request.contextPath}/teacherHome" class="hover:text-gray-200">Dashboard</a>
                <a href="${pageContext.request.contextPath}/teacherAssignments" class="hover:text-gray-200">Assignments</a>
                <a href="${pageContext.request.contextPath}/teacherProfile" class="hover:text-gray-200">Profile</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn bg-red-600 hover:bg-red-700 text-white text-sm px-3 py-1 rounded">Logout</a>
            </div>
        </div>
    </div>
</nav> 