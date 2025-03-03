package com.submission.mis.onlinesubmission.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import com.submission.mis.onlinesubmission.models.Assignment;
import com.submission.mis.onlinesubmission.services.AssignmentService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


public class DownloadAssignmentServlet extends HttpServlet {
    private final AssignmentService assignmentService = AssignmentService.getInstance();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String assignmentIdStr = request.getParameter("assignmentId");
        
        if (assignmentIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Assignment ID is required.");
            return;
        }

        try {
            UUID assignmentId = UUID.fromString(assignmentIdStr);
            Assignment assignment = assignmentService.getAssignmentById(assignmentId);
            
            if (assignment == null || assignment.getFilePath() == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Assignment or file not found.");
                return;
            }

            File file = new File(assignment.getFilePath());
            if (!file.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "File not found.");
                return;
            }

            response.setContentType(getServletContext().getMimeType(file.getName()));
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
        } catch (Exception e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error downloading file: " + e.getMessage());
        }
    }
} 