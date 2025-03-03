<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Student" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Student Dashboard" />
</jsp:include>

<jsp:include page="../common/studentNav.jsp" />

<div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold text-gray-800 mb-6">Welcome, ${sessionScope.studentName}!</h1>
    
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <!-- Stats Cards -->
        <div class="card p-6 bg-white rounded-lg shadow-md">
            <h3 class="text-lg font-semibold text-gray-700 mb-2">Total Assignments</h3>
            <p class="text-3xl font-bold text-primary">${stats.totalAssignments}</p>
        </div>
        
        <div class="card p-6 bg-white rounded-lg shadow-md">
            <h3 class="text-lg font-semibold text-gray-700 mb-2">Submitted</h3>
            <p class="text-3xl font-bold text-success">${stats.submittedAssignments}</p>
        </div>
        
        <div class="card p-6 bg-white rounded-lg shadow-md">
            <h3 class="text-lg font-semibold text-gray-700 mb-2">Pending</h3>
            <p class="text-3xl font-bold text-warning">${stats.pendingAssignments}</p>
        </div>
        
        <div class="card p-6 bg-white rounded-lg shadow-md">
            <h3 class="text-lg font-semibold text-gray-700 mb-2">Overdue</h3>
            <p class="text-3xl font-bold text-danger">${stats.overdueAssignments}</p>
        </div>
    </div>
    
    <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <!-- Pending Assignments -->
        <div class="card">
            <div class="bg-primary text-white px-6 py-4">
                <h2 class="text-xl font-semibold">Pending Assignments</h2>
            </div>
            <div class="p-6">
                <c:choose>
                    <c:when test="${empty pendingAssignments}">
                        <p class="text-gray-500 italic">No pending assignments.</p>
                    </c:when>
                    <c:otherwise>
                        <p class="text-gray-500 italic">${pendingAssignments}</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <!-- Recent Submissions -->
        <div class="card">
            <div class="bg-secondary text-white px-6 py-4">
                <h2 class="text-xl font-semibold">Recent Submissions</h2>
            </div>
            <div class="p-6">
                <c:choose>
                    <c:when test="${empty recentSubmissions}">
                        <p class="text-gray-500 italic">No recent submissions.</p>
                    </c:when>
                    <c:otherwise>
                        <div class="space-y-4">
                            <c:forEach items="${recentSubmissions}" var="submission">
                                <div class="border-b pb-4">
                                    <h3 class="text-lg font-semibold">${submission.assignment.title}</h3>
                                    <p class="text-gray-600 mb-2">Submitted: ${submission.submissionTime}</p>
                                    <div class="flex justify-between items-center">
                                        <span class="text-sm text-gray-500">${submission.fileName}</span>
                                        <a href="${pageContext.request.contextPath}/download?submissionId=${submission.id}" 
                                           class="text-primary hover:underline text-sm">Download</a>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />
