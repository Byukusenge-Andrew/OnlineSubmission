package com.submission.mis.onlinesubmission.services;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.UUID;

import org.hibernate.Session;
import org.hibernate.query.Query;

import com.submission.mis.onlinesubmission.models.Assignment;
import com.submission.mis.onlinesubmission.models.Student;
import com.submission.mis.onlinesubmission.models.Submission;
import com.submission.mis.onlinesubmission.models.Teacher;
import com.submission.mis.onlinesubmission.util.HibernateUtil;

import jakarta.servlet.ServletContext;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.Part;

public class AssignmentService extends HttpServlet {
    private static AssignmentService instance;
    private final TeacherStatsService teacherStatsService = TeacherStatsService.getInstance();
    private final SubmissionStatsService submissionStatsService = SubmissionStatsService.getInstance();
    private ServletContext servletContext;

    private AssignmentService() {}

    public static AssignmentService getInstance() {
        if (instance == null) {
            instance = new AssignmentService();
        }
        return instance;
    }

    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }

    @Override
    public ServletContext getServletContext() {
        return servletContext;
    }

    public void addAssignment(Assignment assignment) throws Exception {
        HibernateUtil.executeInTransaction(session -> {
            // Find all teachers with the same course
            List<Teacher> sameCourseteachers = session.createQuery(
                            "FROM Teacher WHERE course = :course AND id != :ownerId", Teacher.class)
                    .setParameter("course", assignment.getCourse())
                    .setParameter("ownerId", assignment.getOwner().getId())
                    .list();

            assignment.getSharedTeachers().addAll(sameCourseteachers);
            session.persist(assignment);
        });
    }

    public void updateAssignment(Assignment assignment) throws Exception {
        HibernateUtil.executeInTransaction(session ->
                session.merge(assignment)
        );
    }

    public void deleteAssignment(UUID assignmentId) throws Exception {
        HibernateUtil.executeInTransaction(session -> {
            Assignment assignment = session.get(Assignment.class, assignmentId);
            if (assignment != null) {
                session.remove(assignment);
            }
        });
    }

    public Assignment getAssignmentById(UUID assignmentId) {
        Session session = HibernateUtil.getSession();
        try {
            return session.get(Assignment.class, assignmentId);
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public List<Assignment> getAllAssignments() {
        Session session = HibernateUtil.getSession();
        try {
            // Use join fetch to avoid N+1 query problem
            return session.createQuery(
                "SELECT DISTINCT a FROM Assignment a " +
                "LEFT JOIN FETCH a.submissions " +
                "LEFT JOIN FETCH a.teacher " +
                "ORDER BY a.deadline", Assignment.class)
                .list();
        } catch (Exception e) {
            System.err.println("Error retrieving assignments: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public void addStudentSubmission(UUID assignmentId, Student student, InputStream fileContent, String fileName) throws Exception {
        HibernateUtil.executeInTransaction(session -> {
            Assignment assignment = session.get(Assignment.class, assignmentId);
            if (assignment != null) {
                if (!isValidFileType(fileName)) {
                    throw new IllegalArgumentException("Invalid file type.");
                }
                Query<Submission> query = session.createQuery(
                        "FROM Submission WHERE assignment.id = :assignmentId AND student.id = :studentId", Submission.class);
                query.setParameter("assignmentId", assignmentId);
                query.setParameter("studentId", student.getId());
                List<Submission> existingSubmissions = query.list();
                if (!existingSubmissions.isEmpty()) {
                    for (Submission existingSubmission : existingSubmissions) {
                        session.remove(existingSubmission);
                    }
                }

                String savedFilePath = saveFile(fileName, fileContent);

                Submission submission = new Submission();
                submission.setStudent(student);
                submission.setAssignment(assignment);
                submission.setFileName(fileName);
                submission.setSubmissionTime(LocalDateTime.now());
                submission.setFilePath(savedFilePath);

                assignment.getSubmissions().add(submission);
                session.merge(assignment);
            }
        });
    }

    private String saveFile(String fileName, InputStream fileContent) {
        try {
            String uploadDir = "D://JavaProj//OnlineSubmission//uploads";
            File uploadDirectory = new File(uploadDir);

            if (!uploadDirectory.exists()) {
                if (!uploadDirectory.mkdirs()) {
                    throw new RuntimeException("Failed to create upload directory");
                }
            }

            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmss_"));
            String safeFileName = timestamp + fileName.replaceAll("[^a-zA-Z0-9.-]", "_");
            File file = new File(uploadDirectory, safeFileName);

            try (FileOutputStream fos = new FileOutputStream(file)) {
                byte[] buffer = new byte[1024];
                int bytesRead;
                while ((bytesRead = fileContent.read(buffer)) != -1) {
                    fos.write(buffer, 0, bytesRead);
                }
            }

            return file.getAbsolutePath();
        } catch (IOException e) {
            throw new RuntimeException("Error saving file: " + e.getMessage(), e);
        }
    }

    private boolean isValidFileType(String fileName) {
        String[] allowedExtensions = {".pdf", ".xls", ".xlsx", ".pptx", ".zip"};
        return java.util.Arrays.stream(allowedExtensions)
                .anyMatch(ext -> fileName.toLowerCase().endsWith(ext));
    }

    public List<Assignment> getAssignmentsByTeacher(Teacher teacher) {
        Session session = HibernateUtil.getSession();
        try {
            return session.createQuery("from Assignment where teacher = :teacher", Assignment.class)
                    .setParameter("teacher", teacher)
                    .list();
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public List<Assignment> getAssignmentsWithSubmissions(Teacher teacher) {
        Session session = HibernateUtil.getSession();
        try {
            // Using join fetch to eagerly load the submittedStudents collection
            return session.createQuery(
                            "SELECT DISTINCT a FROM Assignment a " +
                                    "LEFT JOIN FETCH a.submittedStudents " +
                                    "WHERE a.teacher = :teacher", Assignment.class)
                    .setParameter("teacher", teacher)
                    .list();
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public List<Assignment> getAssignmentsForTeacher(Teacher teacher) {
        Session session = HibernateUtil.getSession();
        try {
            return session.createQuery(
                "SELECT DISTINCT a FROM Assignment a " +
                "LEFT JOIN FETCH a.submissions " +
                "LEFT JOIN FETCH a.teacher " +
                "WHERE a.course = :course " +
                "ORDER BY a.Posttime DESC", Assignment.class)
                .setParameter("course", teacher.getCourse())
                .list();
        } catch (Exception e) {
            System.err.println("Error retrieving assignments for teacher: " + e.getMessage());
            e.printStackTrace();
            return null;
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public boolean canModifyAssignment(Teacher teacher, Assignment assignment) {
        return assignment.isOwner(teacher);
    }
    public List<Submission> getSubmissionsByAssignmentId(UUID assignmentId) {
        Session session = HibernateUtil.getSession();
        try {
            Query<Submission> query = session.createQuery(
                    "FROM Submission WHERE assignment.id = :assignmentId", Submission.class);
            query.setParameter("assignmentId", assignmentId);
            return query.list();
        } catch (Exception e) {
            System.out.println("Error retrieving submissions: " + e.getMessage());
            return null;
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public Submission getSubmissionById(UUID uuid) {
        Session session = HibernateUtil.getSession();
        try{
            return session.get(Submission.class, uuid);
        }catch(Exception e){
            System.out.println("Error getting submission: " + e.getMessage());
            return null;
        }
        finally {
            HibernateUtil.closeSession(session);
        }

    }

    /**
     * Gets submission statistics for an assignment
     */
    public SubmissionStatsService.SubmissionStats getSubmissionStats(UUID assignmentId) {
        return submissionStatsService.getSubmissionStats(assignmentId);
    }

    /**
     * Gets submission progress for a specific assignment
     */
    public double getSubmissionProgress(UUID assignmentId) {
        return submissionStatsService.getSubmissionProgress(assignmentId);
    }

    /**
     * Gets overall assignment statistics for a teacher
     */
    public TeacherStats getTeacherStats(UUID teacherId) {
        Session session = HibernateUtil.getSession();
        try {
            // Get total assignments
            Long totalAssignments = session.createQuery(
                            "select count(*) from Assignment where teacher.id = :teacherId", Long.class)
                    .setParameter("teacherId", teacherId)
                    .uniqueResult();

            // Get active assignments (not past deadline)
            Long activeAssignments = session.createQuery(
                            "select count(*) from Assignment where teacher.id = :teacherId and deadline >= :today", Long.class)
                    .setParameter("teacherId", teacherId)
                    .setParameter("today", LocalDate.now())
                    .uniqueResult();

            // Get total submissions
            Long totalSubmissions = session.createQuery(
                            "select count(*) from Submission s where s.assignment.teacher.id = :teacherId", Long.class)
                    .setParameter("teacherId", teacherId)
                    .uniqueResult();

            return teacherStatsService.createStats(
                    totalAssignments.intValue(),
                    activeAssignments.intValue(),
                    totalSubmissions.intValue()
            );
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public List<Assignment> getAssignmentsForClass(String classroom) {
        Session session = HibernateUtil.getSession();
        try {
            return session.createQuery(
                "FROM Assignment a WHERE a.targetClass = :classroom ORDER BY a.deadline", 
                Assignment.class)
                .setParameter("classroom", classroom)
                .list();
        } finally {
            HibernateUtil.closeSession(session);
        }
    }

    public void addAssignment(Assignment assignment, Part filePart) throws Exception {
        if (servletContext == null) {
            throw new IllegalStateException("ServletContext not initialized");
        }
        
        // Generate UUID before creating directories
        if (assignment.getId() == null) {
            assignment.setId(UUID.randomUUID());
        }
        
        UUID assignmentId = assignment.getId();
        if (assignmentId == null) {
            throw new IllegalStateException("Failed to generate assignment ID");
        }
        
        String baseDir = servletContext.getRealPath("/uploads/assignments");
        String uploadDir = baseDir + "/" + assignment.getTargetClass() + "/" + 
                          assignmentId.toString();
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }

        // Save the assignment file
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = filePart.getSubmittedFileName();
            String filePath = uploadDir + "/" + fileName;
            
            try (InputStream input = filePart.getInputStream();
                 FileOutputStream output = new FileOutputStream(filePath)) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = input.read(buffer)) > 0) {
                    output.write(buffer, 0, length);
                }
            }
            
            assignment.setAssignmentFileName(fileName);
            assignment.setAssignmentFilePath(filePath);
        }

        // Create submissions folder
        String submissionFolder = uploadDir + "/submissions";
        new File(submissionFolder).mkdirs();
        assignment.setSubmissionFolderPath(submissionFolder);

        // Save assignment to database
        HibernateUtil.executeInTransaction(session -> {
            session.persist(assignment);
        });
    }

    public void handleSubmission(Submission submission, Part filePart) throws Exception {
        Assignment assignment = submission.getAssignment();
        String submissionPath = assignment.getSubmissionFolderPath() + "/" + 
                              submission.getStudent().getId().toString() + "_" +
                              filePart.getSubmittedFileName();

        // Save the submission file
        try (InputStream input = filePart.getInputStream();
             FileOutputStream output = new FileOutputStream(submissionPath)) {
            byte[] buffer = new byte[1024];
            int length;
            while ((length = input.read(buffer)) > 0) {
                output.write(buffer, 0, length);
            }
        }

        submission.setFilePath(submissionPath);
        submission.setFileName(filePart.getSubmittedFileName());

        HibernateUtil.executeInTransaction(session -> {
            session.persist(submission);
        });
    }
}

// Helper classes for statistics

