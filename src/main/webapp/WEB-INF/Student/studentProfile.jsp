<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Student" %>
<%@ page import="com.submission.mis.onlinesubmission.services.StudentStatsService.StudentStats" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Student Profile" />
</jsp:include>

<jsp:include page="../common/studentNav.jsp" />

<div class="container mx-auto px-4 py-8">
    <div class="max-w-4xl mx-auto">
        <h1 class="text-3xl font-bold text-gray-800 mb-6">Student Profile</h1>
        
        <div class="bg-white rounded-lg shadow-md overflow-hidden">
            <div class="bg-primary text-white p-6">
                <h2 class="text-2xl font-bold">${student.firstName} ${student.lastName}</h2>
                <p class="text-gray-100">${student.email}</p>
            </div>
            
            <div class="p-6">
                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <h3 class="text-lg font-semibold text-gray-700 mb-4">Personal Information</h3>
                        <div class="space-y-3">
                            <div>
                                <p class="text-sm text-gray-500">Age</p>
                                <p class="font-medium">${student.age}</p>
                            </div>
                            <div>
                                <p class="text-sm text-gray-500">Date of Birth</p>
                                <p class="font-medium">${student.birthDate}</p>
                            </div>
                        </div>
                    </div>
                    
                    <div>
                        <h3 class="text-lg font-semibold text-gray-700 mb-4">Submission Statistics</h3>
                        <div class="space-y-3">
                            <div class="flex justify-between items-center">
                                <span class="text-gray-600">Completion Rate:</span>
                                <div class="w-2/3 bg-gray-200 rounded-full h-2.5">
                                    <div class="bg-primary h-2.5 rounded-full" style="width: ${stats.completionRate}%"></div>
                                </div>
                                <span class="text-sm font-medium">${Math.round(stats.completionRate)}%</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Total Assignments:</span>
                                <span class="font-medium">${stats.totalAssignments}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Submitted:</span>
                                <span class="font-medium text-success">${stats.submittedAssignments}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Pending:</span>
                                <span class="font-medium text-warning">${stats.pendingAssignments}</span>
                            </div>
                            <div class="flex justify-between">
                                <span class="text-gray-600">Overdue:</span>
                                <span class="font-medium text-danger">${stats.overdueAssignments}</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp" /> 