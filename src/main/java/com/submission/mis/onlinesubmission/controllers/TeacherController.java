package com.submission.mis.onlinesubmission.controllers;
import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

import com.submission.mis.onlinesubmission.models.Assignment;
import com.submission.mis.onlinesubmission.models.Submission;
import com.submission.mis.onlinesubmission.models.Teacher;
import com.submission.mis.onlinesubmission.services.*;
import com.submission.mis.onlinesubmission.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class TeacherController extends HttpServlet {
private static final Logger logger = Logger.getLogger(TeacherController.class.getName());
    private final TeacherService service = TeacherService.getInstance();
    private final AssignmentService assignmentService = AssignmentService.getInstance();
    private final TeacherStatsService teacherStatsService = TeacherStatsService.getInstance();
    private final SubmissionStatsService submissionStatsService = SubmissionStatsService.getInstance();

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        if ("/teacherRegistration".equals(action)) {
            request.setAttribute("formName", "Teacher Registration Form");
            request.getRequestDispatcher("WEB-INF/TeacherForm.jsp").forward(request, response);
        } else if ("/teacherLogin".equals(action)) {
            request.getRequestDispatcher("WEB-INF/TeacherLogin.jsp").forward(request, response);
        } else if ("/teacherAssignments".equals(action)) {
            handleViewAssignments(request,response);
        } else if ("/teacherHome".equalsIgnoreCase(action)) {
            handleTeacherHome(request, response);
        }else if ("/addAssignment".equalsIgnoreCase(action)) {
            request.getRequestDispatcher("WEB-INF/Teacher/addAssignment.jsp").forward(request, response);
        }
        else if ("/deleteAssignment".equalsIgnoreCase(action)) {
            handleDeleteAssignment(request, response);
        }

        else if ("/updateAssignment".equalsIgnoreCase(action)) {
            String assignmentIdStr = request.getParameter("assignmentId");
            try {
                UUID assignmentId = UUID.fromString(assignmentIdStr);
                Assignment assignment = assignmentService.getAssignmentById(assignmentId);
                request.setAttribute("PrevAssignment", assignment);
                request.getRequestDispatcher("WEB-INF/Teacher/updateAssignment.jsp").forward(request, response);
            } catch (Exception e) {
                logger.severe("Error retrieving assignment: " + e.getMessage());
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid assignment ID.");
            }

        }
        else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Page not found.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("register".equalsIgnoreCase(action)) {
            handleRegistration(request, response);
        } else if ("login".equalsIgnoreCase(action)) {
            handleLogin(request, response);
        } else if ("updateAssignment".equalsIgnoreCase(action)) {
            handleUpdateAssignment(request, response);
        } else if ("deleteAssignment".equalsIgnoreCase(action)) {
            handleDeleteAssignment(request, response);
        } else if ("addAssignment".equalsIgnoreCase(action)) {
            handleAddAssignment(request, response);

        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
	}
    private void handleViewAssignments(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("teacherId") == null) {
                throw new IllegalStateException("Teacher not logged in");
            }

            UUID teacherId = (UUID) session.getAttribute("teacherId");
            Teacher teacher = service.getTeacherById(teacherId);

            if (teacher == null) {
                throw new IllegalArgumentException("Teacher not found.");
            }

            List<Assignment> assignments = assignmentService.getAssignmentsForTeacher(teacher);
            if(assignments != null && !assignments.isEmpty()) {
                for (Assignment assignment : assignments){
                    List<Submission> submissions = assignmentService.getSubmissionsByAssignmentId(assignment.getId());
                    assignment.setSubmissions(submissions);
                }
            }
            // Log the number of assignments retrieved
            logger.info("Number of assignments retrieved: " + (assignments != null ? assignments.size() : 0));

            if (assignments == null || assignments.isEmpty()) {
                request.setAttribute("assignments", null); // Avoid passing an empty list
            } else {
                request.setAttribute("assignments", assignments);
            }



            request.setAttribute("currentTeacher", teacher);
            request.getRequestDispatcher("WEB-INF/Teacher/viewTeacherAssignment.jsp").forward(request, response);

        } catch (IllegalStateException e) {
            logger.warning("Teacher not logged in"+e.getMessage());
            response.sendRedirect(request.getContextPath() + "/teacherLogin");
        } catch (IllegalArgumentException e) {
            logger.warning("Invalid teacher ID: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            logger.severe("Error retrieving assignments: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving assignments");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {
            Teacher teacher = service.loginAndGetTeacher(email, password);
            if (teacher != null) {
                // Create session and store teacher data
                HttpSession session = request.getSession();
                session.setAttribute("teacherId", teacher.getId());
                session.setAttribute("teacherName", teacher.getFirstName() + " " + teacher.getLastName());
                session.setAttribute("userType", "teacher");
                session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout
                response.sendRedirect(request.getContextPath() + "/teacherHome");
            } else {
                System.out.println("Error in login");
                request.setAttribute("message", "Invalid email or password");
                request.getRequestDispatcher("WEB-INF/TeacherLogin.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error during login: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/TeacherLogin.jsp").forward(request, response);
        }
    }
    private void handleAddAssignment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String title = ValidationUtil.sanitizeInput(request.getParameter("title"));
        String description = ValidationUtil.sanitizeInput(request.getParameter("description"));
        String deadlineStr = request.getParameter("deadline");
        
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("teacherId") == null) {
                throw new IllegalStateException("Teacher not logged in");
            }
            UUID teacherId = (UUID) session.getAttribute("teacherId");
            Teacher teacher = service.getTeacherById(teacherId);
            
            if (title == null || title.trim().length() < 3) {
                throw new IllegalArgumentException("Title must be at least 3 characters long");
            }
            if (description == null || description.trim().length() < 10) {
                throw new IllegalArgumentException("Description must be at least 10 characters long");
            }
            
            LocalDate postTime = LocalDate.now();
            LocalDate deadline = LocalDate.parse(deadlineStr);
            
            if (!ValidationUtil.isValidFutureDate(deadline)) {
                throw new IllegalArgumentException("Deadline must be in the future");
            }
            if (postTime.isAfter(deadline)) {
                throw new IllegalArgumentException("Post time cannot be after deadline");
            }
            
            // Create assignment with the teacher as owner
            Assignment assignment = new Assignment(title, description, teacher.getCourse(), teacher, postTime, deadline);
            assignmentService.addAssignment(assignment);
            
            response.sendRedirect("teacherAssignments");
            
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("title", title);
            request.setAttribute("description", description);
            request.setAttribute("deadline", deadlineStr);
            request.getRequestDispatcher("WEB-INF/Teacher/addAssignment.jsp").forward(request, response);
        }
    }

    private void handleUpdateAssignment(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String assignmentIdStr = request.getParameter("assignmentId");

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        String deadlineStr = request.getParameter("deadline");

        try {
            UUID assignmentId = UUID.fromString(assignmentIdStr);
            System.out.println("the assignment id is: " + assignmentId);
            Assignment assignment = assignmentService.getAssignmentById(assignmentId);
           request.setAttribute("PrevAssignment", assignment);

            // Validate inputs
            if (title == null || title.trim().length() < 3) {
                throw new IllegalArgumentException("Title must be at least 3 characters long");
            }
            if (description == null || description.trim().length() < 10) {
                throw new IllegalArgumentException("Description must be at least 10 characters long");
            }
            
            LocalDate deadline = LocalDate.parse(deadlineStr);
            if (!ValidationUtil.isValidFutureDate(deadline)) {
                throw new IllegalArgumentException("Deadline must be in the future");
            }

            assignment.setTitle(title);
            assignment.setDescription(description);
            assignment.setDeadline(deadline);
            assignmentService.updateAssignment(assignment);
            
            response.sendRedirect("teacherAssignments");
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("title", title);
            request.setAttribute("description", description);
            request.setAttribute("deadline", deadlineStr);
            request.getRequestDispatcher("WEB-INF/Teacher/updateAssignment.jsp").forward(request, response);
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String fname = request.getParameter("fname");
        String lname = request.getParameter("lname");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String course = request.getParameter("course");
        String hireDateString = request.getParameter("hireDate");
        DateTimeFormatter pattern = DateTimeFormatter.ofPattern("yyyy-MM-dd");

        boolean emailexist = service.emailExists(email);

        if(emailexist) {
            request.setAttribute("formName", "Teacher Registration Form");
            request.setAttribute("message2", "Email already exists");
            request.getRequestDispatcher("WEB-INF/TeacherForm.jsp").forward(request, response);
            return;
        }

        try {
            if (fname == null || lname == null || email == null || hireDateString == null) {
                throw new IllegalArgumentException("All fields are required.");
            }
            LocalDate hireDate = LocalDate.parse(hireDateString, pattern);
            Teacher teacher = new Teacher(fname, lname, email,course, password, hireDate);
            service.addTeacher(teacher);
            
            // Create session after successful registration
            HttpSession session = request.getSession();
            session.setAttribute("teacherId", teacher.getId());
            session.setAttribute("teacherName", teacher.getFirstName() + " " + teacher.getLastName());
            session.setAttribute("userType", "teacher");
            session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout

            response.sendRedirect("WEB-INF/Teacher/teacherHome.jsp");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }
    }
    private void handleDeleteAssignment(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String assignmentIdStr = request.getParameter("assignmentId");

        try {
            UUID assignmentId = UUID.fromString(assignmentIdStr);
            assignmentService.deleteAssignment(assignmentId);
            response.sendRedirect("teacherAssignments");
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid assignment ID format");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting assignment");
        }
    }

    private void handleTeacherHome(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            UUID teacherId = (UUID) session.getAttribute("teacherId");
            
            // Get overall statistics
            TeacherStats stats = assignmentService.getTeacherStats(teacherId);
            request.setAttribute("totalAssignments", stats.getTotalAssignments());
            request.setAttribute("activeAssignments", stats.getActiveAssignments());
            request.setAttribute("pendingAssignments", teacherStatsService.calculatePendingAssignments(stats));
            request.setAttribute("totalSubmissions", stats.getTotalSubmissions());

            // Get total students
            Long totalStudents = service.numberOfStudents();
            request.setAttribute("totalStudents", totalStudents);

            // Forward to home page
            request.getRequestDispatcher("WEB-INF/Teacher/teacherHome.jsp").forward(request, response);
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error loading teacher dashboard: " + e.getMessage());
        }
    }

    private void handleViewAssignment(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            String assignmentId = request.getParameter("assignmentId");
            if (assignmentId == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Assignment ID is required");
                return;
            }

            UUID uuid = UUID.fromString(assignmentId);
            SubmissionStatsService.SubmissionStats stats = submissionStatsService.getSubmissionStats(uuid);
            
            request.setAttribute("submissionStats", stats);
            request.setAttribute("submissionProgress", stats.getSubmissionPercentage());
            request.setAttribute("totalStudents", stats.getTotalStudents());
            request.setAttribute("submittedCount", stats.getSubmittedCount());
            request.setAttribute("pendingCount", stats.getPendingCount());
            
            request.getRequestDispatcher("WEB-INF/Teacher/viewAssignment.jsp")
                  .forward(request, response);
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid assignment ID");
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error viewing assignment: " + e.getMessage());
        }
    }

    public void destroy() {
    }
}