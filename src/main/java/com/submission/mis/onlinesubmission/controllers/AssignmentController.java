package com.submission.mis.onlinesubmission.controllers;

import java.io.IOException;
import java.util.List;
import java.util.UUID;

import com.submission.mis.onlinesubmission.models.Assignment;
import com.submission.mis.onlinesubmission.services.AssignmentService;
import com.submission.mis.onlinesubmission.services.StudentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/assignments")
public class AssignmentController extends HttpServlet {
    private final AssignmentService assignmentService = AssignmentService.getInstance();
    private final StudentService studentService = StudentService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Assuming the student ID is stored in the session
        UUID studentId = (UUID) request.getSession().getAttribute("studentId");
        if (studentId == null) {
            response.sendRedirect(request.getContextPath() + "/studentLogin");
            return;
        }

        // Fetch assignments for the student
        List<Assignment> assignments = assignmentService.getAllAssignments(); // Adjust this method as needed
        request.setAttribute("assignments", assignments);
        request.getRequestDispatcher("WEB-INF/Student/viewAssignment.jsp").forward(request, response);
    }
}
