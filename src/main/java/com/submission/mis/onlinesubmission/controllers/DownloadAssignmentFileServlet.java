package com.submission.mis.onlinesubmission.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import com.submission.mis.onlinesubmission.models.Assignment;
import com.submission.mis.onlinesubmission.services.AssignmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class DownloadAssignmentFileServlet extends HttpServlet {
    private final AssignmentService assignmentService = AssignmentService.getInstance();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String assignmentId = request.getParameter("id");
        
        try {
            UUID uuid = UUID.fromString(assignmentId);
            Assignment assignment = assignmentService.getAssignmentById(uuid);
            
            if (assignment == null || assignment.getAssignmentFilePath() == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Assignment file not found");
                return;
            }

            // Verify student's class matches assignment's target class
            HttpSession session = request.getSession();
            String studentClass = (String) session.getAttribute("classroom");
            if (!assignment.getTargetClass().equals(studentClass)) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, 
                    "You don't have permission to access this file");
                return;
            }

            File file = new File(assignment.getAssignmentFilePath());
            if (!file.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found");
                return;
            }

            response.setContentType(getServletContext().getMimeType(file.getName()));
            response.setHeader("Content-Disposition", 
                "attachment; filename=\"" + assignment.getAssignmentFileName() + "\"");
            response.setContentLength((int) file.length());

            try (FileInputStream in = new FileInputStream(file);
                 OutputStream out = response.getOutputStream()) {
                byte[] buffer = new byte[4096];
                int length;
                while ((length = in.read(buffer)) > 0) {
                    out.write(buffer, 0, length);
                }
            }
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Error downloading file: " + e.getMessage());
        }
    }
} 