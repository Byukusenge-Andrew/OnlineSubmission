<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Teacher" %>
<%@ page import="com.submission.mis.onlinesubmission.services.TeacherStats" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Teacher Profile" />
</jsp:include>

<%--<jsp:include page="../common/teacherNav.jsp" />--%>

<div class="container mx-auto px-4 py-8">
    <div class="max-w-4xl mx-auto">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Teacher Profile</h1>
        
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="bg-secondary text-white p-6">
                <h2 class="text-2xl font-bold">${teacher.firstName} ${teacher.lastName}</h2>
                <p class="text-gray-100">${teacher.email}</p>
            </div>
            
            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <h3 class="text-lg font-semibold text-gray-700 mb-4">Professional Information</h3>
                        <div class="space-y-3">
                            <div>
                                <p class="text-sm text-gray-500">Course</p>
                                <p class="font-medium">${teacher.course}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Hire Date</p>
                                <p class="font-medium">${teacher.hireDate}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <h3 class="text-lg font-semibold text-gray-700 mb-4">Assignment Statistics</h3>
                        <div class="space-y-3">
                            <div class="flex justify-between">
                                <span class="text-gray-600">Total Assignments:</span>
                                <span class="font-medium">${stats.totalAssignments}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Active Assignments:</span>
                                <span class="font-medium text-success">${stats.activeAssignments}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Total Submissions:</span>
                                <span class="font-medium text-accent">${stats.totalSubmissions}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Total Students:</span>
                                <span class="font-medium text-info">${totalStudents}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" />