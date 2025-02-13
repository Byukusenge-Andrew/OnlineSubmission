<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Assignment" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Teacher" %>
<%
    Assignment prevAssignment = (Assignment) request.getAttribute("PrevAssignment");
    if (prevAssignment == null) {
        response.sendRedirect(request.getContextPath() + "/teacherAssignments");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Assignment</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/styles.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>
<body>
    <div class="app-container">
        <nav class="navbar">
            <div class="nav-container">
                <div class="nav-start">
                    <a href="${pageContext.request.contextPath}/teacherHome" class="nav-link">
                        <i class="fas fa-home"></i> Home
                    </a>
                    <a href="${pageContext.request.contextPath}/teacherAssignments" class="nav-link active">
                        <i class="fas fa-tasks"></i> Assignments
                    </a>
                    <a href="${pageContext.request.contextPath}/teacherProfile" class="nav-link">
                        <i class="fas fa-user"></i> Profile
                    </a>
                </div>
                <div class="nav-end">
                    <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline">
                        <i class="fas fa-sign-out-alt"></i> Logout
                    </a>
                </div>
            </div>
        </nav>

        <div class="main-content">
            <div class="card">
                <div class="card-header">
                    <h2><i class="fas fa-edit"></i> Update Assignment</h2>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/updateAssignment" method="post" class="form">
                        <input type="hidden" name="action" value="updateAssignment">
                        <input type="hidden" name="assignmentId" value="<%= prevAssignment.getId() %>">

                        <div class="form-group">
                            <label for="title">
                                <i class="fas fa-heading"></i> Title
                            </label>
                            <input type="text" id="title" name="title" required 
                                   value="<%= prevAssignment.getTitle() %>">
                        </div>

                        <div class="form-group">
                            <label for="description">
                                <i class="fas fa-align-left"></i> Description
                            </label>
                            <textarea id="description" name="description" required 
                                      rows="4"><%= prevAssignment.getDescription() %></textarea>
                        </div>

                        <div class="form-group">
                            <label for="course">
                                <i class="fas fa-book"></i> Course
                            </label>
                            <input type="text" id="course" name="course" required 
                                   value="<%= prevAssignment.getCourse() %>">
                        </div>

                        <div class="form-group">
                            <label for="deadline">
                                <i class="fas fa-calendar"></i> Deadline
                            </label>
                            <input type="date" id="deadline" name="deadline" required 
                                   value="<%= prevAssignment.getDeadline() %>">
                        </div>

                        <div class="form-actions">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> Update Assignment
                            </button>
                            <a href="${pageContext.request.contextPath}/teacherAssignments" 
                               class="btn btn-outline">
                                <i class="fas fa-times"></i> Cancel
                            </a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>