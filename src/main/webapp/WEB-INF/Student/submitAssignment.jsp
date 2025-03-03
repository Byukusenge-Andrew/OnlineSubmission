<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 08/02/2025
  Time: 18:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="../common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="max-w-2xl mx-auto">
    <div class="card">
        <div class="bg-primary px-6 py-4">
            <h2 class="text-xl font-semibold text-white">Submit Assignment</h2>
        </div>
        <div class="p-6">
            <% if (request.getAttribute("error") != null) { %>
                <div class="bg-danger/10 border border-danger text-danger px-4 py-3 rounded mb-4">
                    <%= request.getAttribute("error") %>
                </div>
            <% } %>
            
            <div class="mb-6">
                <h3 class="text-lg font-semibold">${assignment.title}</h3>
                <p class="text-gray-600 mt-2">${assignment.description}</p>
                <div class="mt-4 text-sm text-gray-500">
                    <p>Deadline: ${assignment.deadline}</p>
                    <p>Teacher: ${assignment.teacher.firstName} ${assignment.teacher.lastName}</p>
                </div>
            </div>
            
            <form action="${pageContext.request.contextPath}/submitAssignment" method="post" 
                  enctype="multipart/form-data" class="space-y-4">
                <input type="hidden" name="action" value="submitassignment">
                <input type="hidden" name="assignmentId" value="${assignment.id}">
                <input type="hidden" name="studentId" value="${sessionScope.studentId}">
                
                <div>
                    <label for="fileName" class="form-label">Submission File</label>
                    <input type="file" id="fileName" name="fileName" required
                           class="form-input" accept=".pdf,.doc,.docx,.txt">
                    <p class="text-sm text-gray-500 mt-1">
                        Accepted formats: PDF, DOC, DOCX, TXT
                    </p>
                </div>
                
                <div class="flex gap-4">
                    <button type="submit" class="btn btn-primary flex-1">
                        Submit Assignment
                    </button>
                    <a href="${pageContext.request.contextPath}/viewAssignments" 
                       class="btn btn-secondary flex-1 text-center">
                        Cancel
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
