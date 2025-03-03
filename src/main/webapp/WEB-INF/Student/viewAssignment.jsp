<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Assignment" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Submission" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.submission.mis.onlinesubmission.models.Student" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDate" %>
<%
    Student student = (Student) request.getAttribute("currentStudent");
    if (student == null) {
        response.sendRedirect(request.getContextPath() + "/studentLogin");
        return;
    }

    List<Assignment> assignments = (List<Assignment>) request.getAttribute("assignments");
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Assignments</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                }
            }
        }
    </script>
</head>
<body class="bg-gray-50 font-sans">
<div class="min-h-screen">
    <!-- Navigation -->
    <nav class="bg-white shadow">
        <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
            <div class="flex justify-between h-16">
                <div class="flex space-x-8">
                    <a href="${pageContext.request.contextPath}/studentHome"
                       class="inline-flex items-center px-1 pt-1 text-gray-500 hover:text-gray-700">
                        <i class="fas fa-home mr-2"></i> Home
                    </a>
                    <a href="${pageContext.request.contextPath}/viewAssignments"
                       class="inline-flex items-center px-1 pt-1 border-b-2 border-indigo-500 text-gray-900">
                        <i class="fas fa-tasks mr-2"></i> Assignments
                    </a>
                    <a href="${pageContext.request.contextPath}/studentProfile"
                       class="inline-flex items-center px-1 pt-1 text-gray-500 hover:text-gray-700">
                        <i class="fas fa-user mr-2"></i> Profile
                    </a>
                </div>
                <div class="flex items-center">
                    <span class="text-gray-700 mr-4">Welcome, <%= student.getFirstName() %></span>
                    <a href="${pageContext.request.contextPath}/logout"
                       class="inline-flex items-center px-4 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-red-600 hover:bg-red-700">
                        <i class="fas fa-sign-out-alt mr-2"></i> Logout
                    </a>
                </div>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="max-w-7xl mx-auto py-6 sm:px-6 lg:px-8">
        <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
            <div class="p-6">
                <h2 class="text-2xl font-bold text-gray-900 mb-6 flex items-center justify-center">
                    <i class="fas fa-tasks mr-2"></i> Assignments
                </h2>

                <% if (assignments == null || assignments.isEmpty()) { %>
                <div class="text-center py-12">
                    <i class="fas fa-clipboard-list text-gray-400 text-5xl mb-4"></i>
                    <p class="text-gray-500">No assignments available at the moment.</p>
                </div>
                <% } else { %>
                <div class="overflow-x-auto">
                    <table class="min-w-full divide-y divide-gray-200">
                        <thead class="bg-gray-50">
                        <tr>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Title</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Course</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Teacher</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Deadline</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">File</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Status</th>
                            <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Actions</th>
                        </tr>
                        </thead>
                        <tbody class="bg-white divide-y divide-gray-200">
                        <% for (Assignment assignment : assignments) {
                            boolean isSubmitted = assignment.getSubmissions().stream()
                                    .anyMatch(s -> s.getStudent().getId().equals(student.getId()));
                            boolean isOverdue = assignment.getDeadline().isBefore(LocalDate.now());
                        %>
                        <tr class="hover:bg-gray-50">
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">
                                <%= assignment.getTitle() %>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <%= assignment.getCourse() %>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <%= assignment.getTeacher().getName() %>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                <%= assignment.getDeadline().format(DateTimeFormatter.ofPattern("yyyy-MM-dd")) %>
                            </td>
                            <td class="px-4 py-2">
                                <a href="${pageContext.request.contextPath}/downloadAssignment?assignmentId=${assignment.id}" class="text-blue-600 hover:underline">
                                    Download
                                </a>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap">
                                <% if (isSubmitted) { %>
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                    Submitted
                                </span>
                                <% } else if (isOverdue) { %>
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-red-100 text-red-800">
                                    Overdue
                                </span>
                                <% } else { %>
                                <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-yellow-100 text-yellow-800">
                                    Pending
                                </span>
                                <% } %>
                            </td>
                            <td class="px-6 py-4 whitespace-nowrap text-sm font-medium">
                                <% if (!isSubmitted && !isOverdue) { %>
                                <a href="${pageContext.request.contextPath}/submitAssignment?assignmentId=<%= assignment.getId() %>"
                                   class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                                    <i class="fas fa-upload mr-2"></i> Submit
                                </a>
                                <% } else if (isSubmitted) { %>
                                <span class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-green-600 cursor-not-allowed">
                                    <i class="fas fa-check mr-2"></i> Submitted
                                </span>
                                <% } else { %>
                                <span class="inline-flex items-center px-3 py-2 border border-transparent text-sm leading-4 font-medium rounded-md text-white bg-red-600 cursor-not-allowed">
                                    <i class="fas fa-clock mr-2"></i> Overdue
                                </span>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
                <% } %>
            </div>
        </div>
    </div>
</div>
</body>
</html>