<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.submission.mis.onlinesubmission.models.*" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<html>
<head>
    <title>View Assignments</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
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
<body class="font-sans bg-gray-100 p-5 mx-8">
<nav class="bg-white shadow  h-24  mb-8">
    <div class="max-w-2xl mx-auto p-8 flex justify-between items-center">
        <a href="teacherHome" class="text-xl font-semibold text-blue-600">Teacher Portal</a>
        <ul class="flex space-x-4">
            <li><a href="teacherHome" class="text-gray-700 hover:text-blue-600">Dashboard</a></li>
            <li><a href="teacherAssignments" class="text-gray-700 hover:text-blue-600">Assignments</a></li>
            <li><a href="addAssignment" class="text-gray-700 hover:text-blue-600">Add Assignment</a></li>
            <li><a href="teacherProfile" class="text-gray-700 hover:text-blue-600">Profile</a></li>
            <li><a href="logout" class="bg-red-500 text-white px-3 py-2 rounded hover:bg-red-600">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="max-w-6xl mx-auto bg-white shadow rounded-lg p-6">
    <h2 class="text-2xl font-bold text-center text-gray-800 mb-6">Assignments and Submissions</h2>

    <div class="overflow-x-auto">
        <table class="min-w-full bg-white border-collapse">
            <thead>
            <tr>
                <th class="bg-blue-600 text-white px-4 py-2">Title</th>
                <th class="bg-blue-600 text-white px-4 py-2">Description</th>
                <th class="bg-blue-600 text-white px-4 py-2">Post Time</th>
                <th class="bg-blue-600 text-white px-4 py-2">Deadline</th>
                <th class="bg-blue-600 text-white px-4 py-2">Assignment File</th>

                <th class="bg-blue-600 text-white px-4 py-2">Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Assignment> assignments = (List<Assignment>) request.getAttribute("assignments");
                if (assignments != null && !assignments.isEmpty()) {
                    for (Assignment assignment : assignments) {
                        List<Submission> submissions = assignment.getSubmissions();
                        int totalStudents = ((Long) request.getAttribute("totalStudents")).intValue();
                        int submissionCount = submissions != null ? submissions.size() : 0;
                        double submissionPercentage = (submissionCount * 100.0) / totalStudents;
            %>
            <tr class="border-b">
                <td class="px-4 py-2"><%= assignment.getTitle() %></td>
                <td class="px-4 py-2"><%= assignment.getDescription() %></td>
                <td class="px-4 py-2"><%= assignment.getPosttime() %></td>
                <td class="px-4 py-2"><%= assignment.getDeadline() %></td>
                <td class="px-4 py-2">
                <a href="${pageContext.request.contextPath}/downloadAssignment?assignmentId=<%=assignment.getId()%>">Download</a>
            </td>
                <td class="px-4 py-2">
                    <div class="bg-gray-100 p-4 rounded-lg">
                        <div class="grid grid-cols-3 gap-4">
                            <div class="text-center">
                                <div class="text-xl font-bold"><%= submissionCount %></div>
                                <div class="text-sm text-gray-600">Submissions</div>
                            </div>
                            <div class="text-center">
                                <div class="text-xl font-bold"><%= totalStudents - submissionCount %></div>
                                <div class="text-sm text-gray-600">Pending</div>
                            </div>
                            <div class="text-center">
                                <div class="text-xl font-bold"><%= String.format("%.1f%%", submissionPercentage) %></div>
                                <div class="text-sm text-gray-600">Completion</div>
                            </div>
                        </div>
                        <div class="w-full bg-gray-200 h-2 rounded mt-2">
                            <div class="bg-blue-600 h-2 rounded" style="width: <%= submissionPercentage %>%"></div>
                        </div>
                        <% if (submissionCount == totalStudents) { %>
                        <div class="bg-green-100 text-green-800 p-2 rounded mt-2 text-center font-medium">
                            All students have submitted their assignments!
                        </div>
                        <% } %>
                    </div>

                    <% if (submissions != null && !submissions.isEmpty()) { %>
                    <ul class="mt-2">
                        <% for (Submission submission : submissions) { %>
                        <li class="flex justify-between items-center py-4 border-b">
                            <span><%= submission.getStudent().getFirstName() %> <%= submission.getStudent().getLastName() %></span>
                            <a href="${pageContext.request.contextPath}/downloadSubmission?submissionId=<%= submission.getId() %>"
                               class="text-blue-600 hover:underline">
                                <%= submission.getFileName() %>
                            </a>
                            <span class="text-sm text-gray-500">
                                    Submitted: <%= submission.getSubmissionTime().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")) %>
                                </span>
                        </li>
                        <% } %>
                    </ul>
                    <% } else { %>
                    <div class="text-gray-500">No submissions yet</div>
                    <% } %>
                </td>
                <td class="px-4 py-2 flex space-x-2">
                    <% if (assignment.isOwner((Teacher)request.getAttribute("currentTeacher"))) { %>
                    <a href="updateAssignment?action=updateAssignment&assignmentId=<%= assignment.getId() %>"
                       class="bg-green-500 text-white px-3 py-1 rounded hover:bg-green-600">Update</a>
                    <a href="deleteAssignment?action=deleteAssignment&assignmentId=<%= assignment.getId() %>"
                       class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600"
                       onclick="return confirm('Are you sure you want to delete this assignment?')">Delete</a>
                    <% } %>
                    <% if (!assignment.isOwner((Teacher)request.getAttribute("currentTeacher"))) { %>
                    <span class="text-sm text-gray-500">Created by <%= assignment.getOwner().getName() %></span>
                    <% } %>
                </td>
            </tr>
            <%
                }
            } else {
            %>
            <tr>
                <td colspan="6" class="text-center text-gray-500 py-4">No assignments available.</td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="mt-4">
        <a href="${pageContext.request.contextPath}/teacherHome" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600">Back to Home</a>
    </div>
</div>
</body>
</html>