<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Teacher Dashboard" />
</jsp:include>

<jsp:include page="../common/teacherNav.jsp" />

<div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-6">Welcome, ${sessionScope.teacherName}!</h1>
    
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <!-- Stats Cards -->
        <div class="card p-6 bg-white rounded-lg shadow-md">
            <h3 class="text-lg font-semibold text-gray-700 mb-2">Total Assignments</h3>
            <p class="text-3xl font-bold text-primary">${totalAssignments}</p>
        </div>
        
        <div class="card p-6 bg-white rounded-lg shadow-md">
            <h3 class="text-lg font-semibold text-gray-700 mb-2">Active Assignments</h3>
            <p class="text-3xl font-bold text-success">${activeAssignments}</p>
        </div>
        
        <div class="card p-6 bg-white rounded-lg shadow-md">
            <h3 class="text-lg font-semibold text-gray-700 mb-2">Total Submissions</h3>
            <p class="text-3xl font-bold text-accent">${totalSubmissions}</p>
        </div>
        
        <div class="card p-6 bg-white rounded-lg shadow-md">
            <h3 class="text-lg font-semibold text-gray-700 mb-2">Total Students</h3>
            <p class="text-3xl font-bold text-info">${totalStudents}</p>
        </div>
    </div>
    
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <!-- Quick Actions -->
        <div class="card">
            <div class="bg-secondary text-white px-6 py-4">
                <h2 class="text-xl font-semibold">Quick Actions</h2>
            </div>
            <div class="p-6 space-y-4">
                <a href="${pageContext.request.contextPath}/addAssignment"
                   class="block w-full btn btn-primary text-center">Create New Assignment</a>
                <a href="${pageContext.request.contextPath}/teacherAssignments" 
                   class="block w-full btn bg-accent text-white hover:bg-purple-700 text-center">View All Assignments</a>
            </div>
        </div>
        
        <!-- System Notifications -->
        <div class="card">
            <div class="bg-primary text-white px-6 py-4">
                <h2 class="text-xl font-semibold">System Notifications</h2>
            </div>
            <div class="p-6">
                <div class="space-y-4">
                    <div class="flex items-start space-x-3 p-3 bg-blue-50 rounded-lg">
                        <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-primary flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13 16h-1v-4h-1m1-4h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
                        </svg>
                        <div>
                            <p class="font-medium">Welcome to the Online Submission System</p>
                            <p class="text-sm text-gray-600">Use the dashboard to manage your assignments and track student submissions.</p>
                        </div>
                    </div>
                    
                    <c:if test="${pendingAssignments > 0}">
                        <div class="flex items-start space-x-3 p-3 bg-yellow-50 rounded-lg">
                            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-warning flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z" />
                            </svg>
                            <div>
                                <p class="font-medium">You have ${pendingAssignments} past deadline assignments</p>
                                <p class="text-sm text-gray-600">Consider archiving them or extending the deadlines.</p>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</div>

<c:forEach var="assignment" items="${assignments}">
    <a href="${pageContext.request.contextPath}/downloadAssignment?assignmentId=${assignment.id}"
       class="text-blue-600 hover:underline">
        Download Assignment File
    </a>
</c:forEach>

<jsp:include page="../common/footer.jsp" />