package com.submission.mis.onlinesubmission.controllers;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.time.LocalDate;
import java.util.List;
import java.util.UUID;
import java.util.logging.Logger;

import com.submission.mis.onlinesubmission.models.Assignment;
import com.submission.mis.onlinesubmission.models.Student;
import com.submission.mis.onlinesubmission.models.Submission;
import com.submission.mis.onlinesubmission.services.AssignmentService;
import com.submission.mis.onlinesubmission.services.StudentService;
import com.submission.mis.onlinesubmission.services.StudentStatsService;
import com.submission.mis.onlinesubmission.util.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;


@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 10,  // 10 MB
    maxRequestSize = 1024 * 1024 * 15 // 15 MB
)
public class StudentController extends HttpServlet {
    private static final Logger logger = Logger.getLogger(StudentController.class.getName());
    private final StudentService service = StudentService.getInstance();
    private final AssignmentService assignmentService = AssignmentService.getInstance();
    private final StudentStatsService studentStatsService = StudentStatsService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("studentId") == null) {
            if ("/studentLogin".equals(action)) {
                request.getRequestDispatcher("WEB-INF/Student/studentLogin.jsp").forward(request, response);
                return;
            }
            response.sendRedirect(request.getContextPath() + "/studentLogin");
            return;
        }

        // Proceed with other actions
        if ("/studentHome".equals(action)) {
            handleStudentHome(request, response);
        } else if ("/studentRegistration".equals(action)) {
            request.getRequestDispatcher("WEB-INF/form.jsp").forward(request, response);
        } else if ("/viewAssignments".equals(action)) {
            handleViewAssignments(request, response);
        } else if("/submitAssignment".equals(action)) {
            // Forward to the submission form
            request.getRequestDispatcher("WEB-INF/Student/submitAssignment.jsp").forward(request, response);
        } else if ("/studentProfile".equals(action)) {
            handleStudentProfile(request, response);
        } else if ("/downloadAssignment".equals(action)) {
            handleDownloadAssignment(request, response);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Page not found.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("Received action: " + action); // Log the action parameter

        if ("register".equalsIgnoreCase(action)) {
            handleRegistration(request, response);
        } else if ("login".equalsIgnoreCase(action)) {
            handleLogin(request, response);
        } else if ("submitAssignment".equalsIgnoreCase(action)) {
            handleAssignmentSubmission(request,response);
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action.");
        }
    }

    private void handleRegistration(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String firstname = ValidationUtil.sanitizeInput(request.getParameter("firstname"));
        String lastname = ValidationUtil.sanitizeInput(request.getParameter("lastname"));
        String email = ValidationUtil.sanitizeInput(request.getParameter("email"));
        String password = request.getParameter("password");
        String dobString = request.getParameter("dob");
        String classroom = request.getParameter("classroom");
        try {
            // Validate all inputs
            if (!ValidationUtil.isValidName(firstname)) {
                throw new IllegalArgumentException("Invalid first name format");
            }
            if (!ValidationUtil.isValidName(lastname)) {
                throw new IllegalArgumentException("Invalid last name format");
            }
            if (!ValidationUtil.isValidEmail(email)) {
                throw new IllegalArgumentException("Invalid email format");
            }
            if (!ValidationUtil.isValidPassword(password)) {
                throw new IllegalArgumentException("Password must be at least 8 characters long and contain uppercase, lowercase, number and special character");
            }
            
            LocalDate dob = LocalDate.parse(dobString);
            if (!ValidationUtil.isValidPastDate(dob)) {
                throw new IllegalArgumentException("Date of birth cannot be in the future");
            }
            
            int age = LocalDate.now().getYear() - dob.getYear();
            if (age < 16) {
                throw new IllegalArgumentException("Student must be at least 16 years old");
            }
            
            // Check if email already exists
            if (service.emailExists(email)) {
                throw new IllegalArgumentException("Email already registered");
            }
            if(!ValidationUtil.isValidClass(classroom)) {
                throw new IllegalArgumentException("Invalid email format");
            }

            Student student = new Student(firstname, lastname, email, password, age, dob, classroom);

            service.addStudent(student);
            // Create session and store student data
            HttpSession session = request.getSession();
            session.setAttribute("studentId", student.getId());
            session.setAttribute("classroom", student.getClassRoom());
            session.setAttribute("studentName", student.getFirstName() + " " + student.getLastName());
            session.setAttribute("userType", "student");

            session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout

            response.sendRedirect(request.getContextPath() + "/studentHome");

            
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            request.setAttribute("firstname", firstname);
            request.setAttribute("lastname", lastname);
            request.setAttribute("email", email);
            request.setAttribute("dob", dobString);
            request.getRequestDispatcher("WEB-INF/form.jsp").forward(request, response);
        } catch (Exception e) {
            request.setAttribute("error", "Registration failed: " + e.getMessage());
            request.getRequestDispatcher("WEB-INF/form.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        Student student = service.loginAndGetStudent(email, password);
        if (student != null) {
            HttpSession session = request.getSession();
            session.setAttribute("studentId", student.getId());
            session.setAttribute("classroom", student.getClassRoom());
            session.setAttribute("studentName", student.getFirstName() + " " + student.getLastName());
            session.setAttribute("userType", "student");
            session.setMaxInactiveInterval(30 * 60); // 30 minutes timeout

            response.sendRedirect(request.getContextPath() + "/studentHome");
        } else {
            response.sendRedirect(request.getContextPath() + "/studentLogin?error=Invalid credentials");
        }
    }

    private void handleAssignmentSubmission(HttpServletRequest request, HttpServletResponse response) 
            throws IOException, ServletException {
        try {
            String assignmentId = request.getParameter("assignmentId");
            String studentId = request.getParameter("studentId");

            Part filePart = request.getPart("fileName");
            String fileName = filePart.getSubmittedFileName();
            InputStream fileContent = filePart.getInputStream();

            if(assignmentId == null || studentId == null || fileName == null || fileContent == null) {
                throw new IllegalArgumentException("All fields are required.");
            }

            UUID assignmentUUID = UUID.fromString(assignmentId);
            UUID studentUUID = UUID.fromString(studentId);

            Student student = service.getStudentById(studentUUID);
            Assignment assignment = assignmentService.getAssignmentById(assignmentUUID);

            if(assignment == null || student == null) {
                throw new IllegalArgumentException("Assignment or student not found.");
            }
            
            assignmentService.addStudentSubmission(assignmentUUID, student, fileContent, fileName);
            response.sendRedirect(request.getContextPath() + "/viewAssignments");
            
        } catch (IllegalArgumentException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, e.getMessage());
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "An error occurred while submitting the assignment: " + e.getMessage());
        }
    }

    private void handleViewAssignments(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("studentId") == null) {
                response.sendRedirect(request.getContextPath() + "/studentLogin");
                return;
            }

            UUID studentId = (UUID) session.getAttribute("studentId");
            Student student = service.getStudentById(studentId);
            
            if (student == null) {
                throw new IllegalStateException("Student not found");
            }

            List<Assignment> assignments = assignmentService.getAllAssignments();
            if (assignments != null) {
                // Get submissions for each assignment
                for (Assignment assignment : assignments) {
                    List<Submission> submissions = assignmentService.getSubmissionsByAssignmentId(assignment.getId());
                    assignment.setSubmissions(submissions);
                }
            }

            request.setAttribute("assignments", assignments);
            request.setAttribute("currentStudent", student);
            request.getRequestDispatcher("WEB-INF/Student/viewAssignment.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error retrieving assignments: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving assignments");
        }
    }

    private void handleStudentHome(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            UUID studentId = (UUID) session.getAttribute("studentId");
            
            if (studentId == null) {
                response.sendRedirect(request.getContextPath() + "/studentLogin");
                return;
            }

            // Get the student object
            Student student = service.getStudentById(studentId);
            if (student == null) {
                throw new IllegalStateException("Student not found");
            }
            
            // Get student statistics
            StudentStatsService.StudentStats stats = studentStatsService.getStudentStats(studentId);
            
            // Set attributes for the JSP
            request.setAttribute("currentStudent", student);
            request.setAttribute("totalAssignments", stats.getTotalAssignments());
            request.setAttribute("submittedAssignments", stats.getSubmittedAssignments());
            request.setAttribute("pendingAssignments", stats.getPendingAssignments());
            request.setAttribute("overdueAssignments", stats.getOverdueAssignments());
            request.setAttribute("completionRate", stats.getCompletionRate());
            request.setAttribute("hasOverdue", stats.hasOverdueAssignments());
            
            request.getRequestDispatcher("WEB-INF/Student/studentHome.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Error loading student dashboard: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error loading student dashboard: " + e.getMessage());
        }
    }

    private void handleStudentProfile(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("studentId") == null) {
                response.sendRedirect(request.getContextPath() + "/studentLogin");
                return;
            }

            UUID studentId = (UUID) session.getAttribute("studentId");
            Student student = service.getStudentById(studentId);
            
            if (student == null) {
                throw new IllegalStateException("Student not found");
            }

            // Get student statistics
            StudentStatsService.StudentStats stats = studentStatsService.getStudentStats(studentId);
            
            request.setAttribute("student", student);
            request.setAttribute("stats", stats);
            request.getRequestDispatcher("WEB-INF/Student/studentProfile.jsp").forward(request, response);
            
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error loading profile: " + e.getMessage());
        }
    }

    private void handleDownloadAssignment(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String assignmentIdStr = request.getParameter("id");
        UUID assignmentId = UUID.fromString(assignmentIdStr);
        
        Assignment assignment = assignmentService.getAssignmentById(assignmentId);
        if (assignment != null && assignment.getFilePath() != null) {
            File file = new File(assignment.getFilePath());
            if (file.exists()) {
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment; filename=\"" + file.getName() + "\"");
                response.setContentLength((int) file.length());

                try (FileInputStream in = new FileInputStream(file);
                     OutputStream out = response.getOutputStream()) {
                    byte[] buffer = new byte[4096];
                    int length;
                    while ((length = in.read(buffer)) > 0) {
                        out.write(buffer, 0, length);
                    }
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
            }
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Assignment or file not found.");
        }
    }

    @Override
    public void destroy() {
        // Clean up resources if needed
    }
}