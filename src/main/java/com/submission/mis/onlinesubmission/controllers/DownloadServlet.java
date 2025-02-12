package com.submission.mis.onlinesubmission.controllers;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.submission.mis.onlinesubmission.models.Submission;
import com.submission.mis.onlinesubmission.services.AssignmentService;


public class DownloadServlet extends HttpServlet {
    private final AssignmentService assignmentService = AssignmentService.getInstance();

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String submissionId = request.getParameter("submissionId");
        
        try {
            Submission submission = assignmentService.getSubmissionById(UUID.fromString(submissionId));
            if (submission == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            File file = new File(submission.getFilePath());
            if (!file.exists()) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }

            response.setContentType(getServletContext().getMimeType(file.getName()));
            response.setHeader("Content-Disposition", "attachment; filename=\"" + submission.getFileName() + "\"");
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
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
} 