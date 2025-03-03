<%@ include file="../common/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<div class="max-w-7xl mx-auto">
    <div class="mb-6">
        <h1 class="text-2xl font-bold text-gray-900">Your Assignments</h1>
        <p class="text-gray-600">Class: ${sessionScope.classroom}</p>
    </div>

    <div class="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        <c:forEach var="assignment" items="${assignments}">
            <div class="card">
                <div class="bg-primary px-4 py-3">
                    <h3 class="text-lg font-semibold text-white">${assignment.title}</h3>
                </div>
                <div class="p-4 space-y-4">
                    <div>
                        <p class="text-gray-600">${assignment.description}</p>
                    </div>
                    
                    <div class="text-sm">
                        <p class="text-gray-500">Posted: ${assignment.posttime}</p>
                        <p class="text-gray-500">Deadline: ${assignment.deadline}</p>
                        <p class="text-gray-500">Teacher: ${assignment.teacher.firstName} ${assignment.teacher.lastName}</p>
                    </div>
                    
                    <div class="space-y-2">
                        <c:if test="${assignment.assignmentFileName != null}">
                            <a href="${pageContext.request.contextPath}/downloadAssignmentFile?id=${assignment.id}" 
                               class="btn btn-secondary w-full flex items-center justify-center">
                                <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                          d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"/>
                                </svg>
                                Download Assignment
                            </a>
                        </c:if>
                        
                        <c:set var="hasSubmitted" value="false"/>
                        <c:forEach var="submission" items="${assignment.submissions}">
                            <c:if test="${submission.student.id == sessionScope.studentId}">
                                <c:set var="hasSubmitted" value="true"/>
                            </c:if>
                        </c:forEach>
                        
                        <c:choose>
                            <c:when test="${hasSubmitted}">
                                <div class="bg-success/10 text-success px-4 py-2 rounded text-center">
                                    Submitted
                                </div>
                            </c:when>
                            <c:otherwise>
                                <a href="${pageContext.request.contextPath}/submitAssignment?id=${assignment.id}" 
                                   class="btn btn-primary w-full flex items-center justify-center">
                                    <svg class="w-4 h-4 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" 
                                              d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-8l4 4m0 0l4-4m-4 4V4"/>
                                    </svg>
                                    Submit Assignment
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>