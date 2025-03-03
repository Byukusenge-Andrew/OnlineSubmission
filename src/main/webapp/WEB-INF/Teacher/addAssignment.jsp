<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Student" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="addasignment" />
</jsp:include>
<jsp:include page="../common/teacherNav.jsp"/>

<div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-lg">

    <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">Add New Assignment</h2>

    <% if(request.getAttribute("error") != null) { %>
    <div class="bg-red-100 text-red-700 p-4 rounded mb-4 text-center">
        ${error}
    </div>
    <% } %>

    <form action="addAssignment" method="post"  name="assignmentForm" class="mx-120" enctype="multipart/form-data">
        <input type="hidden" name="action" value="addAssignment"/>

        <div class="mb-4">
            <label for="title" class="block text-gray-700 font-medium mb-2">Title:</label>
            <input type="text" id="title" name="title" value="${title}" required minlength="3" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"/>
        </div>

        <div class="mb-4">
            <label for="description" class="block text-gray-700 font-medium mb-2">Description:</label>
            <textarea id="description" name="description" required minlength="10" class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500">${description}</textarea>
        </div>

        <div class="mb-4">
            <label for="deadline" class="block text-gray-700 font-medium mb-2">Deadline:</label>
            <input type="date" id="deadline" name="deadline" value="${deadline}" required class="w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500"/>
        </div>
        <div class="mb-4">
            <label for="file">Select File:</label>
            <input type="file" id="file" name="fileName" required/>
        </div>

        <input type="submit" value="add asignment" class="w-full bg-blue-500 text-white py-2 rounded-md hover:bg-blue-600 transition duration-300"/>
    </form>
</div>
<jsp:include page="../common/footer.jsp"/>