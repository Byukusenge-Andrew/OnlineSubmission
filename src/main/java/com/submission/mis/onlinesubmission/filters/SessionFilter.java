package com.submission.mis.onlinesubmission.filters;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
//
@WebFilter(urlPatterns = {"/WEB-INF/Student/*", "/WEB-INF/Teacher/*"})
public class SessionFilter implements Filter {
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestPath = httpRequest.getRequestURI();
        
        // Allow access to the registration page without a session
        if (requestPath.contains("/WEB-INF/form.jsp")) {
            chain.doFilter(request, response);
            return;
        }

        if (session == null || session.getAttribute("userType") == null) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/index.jsp");
            return;
        }
        
        String userType = (String) session.getAttribute("userType");
        if (requestPath.contains("/Student/") && !"student".equals(userType)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/studentLogin");
            return;
        }
        
        if (requestPath.contains("/Teacher/") && !"teacher".equals(userType)) {
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/teacherLogin");
            return;
        }
        
        chain.doFilter(request, response);
    }
} 