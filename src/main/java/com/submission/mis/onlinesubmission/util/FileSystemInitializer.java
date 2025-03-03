package com.submission.mis.onlinesubmission.util;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.attribute.PosixFilePermission;
import java.util.Set;
import java.util.logging.Logger;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class FileSystemInitializer implements ServletContextListener {
    private static final Logger logger = Logger.getLogger(FileSystemInitializer.class.getName());
    private static final String BASE_UPLOAD_DIR = "uploads";
    private static final String[] CLASS_FOLDERS = {"A", "B", "C", "D"};

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        String rootPath = sce.getServletContext().getRealPath("/");
        initializeFileSystem(rootPath);
    }

    private void initializeFileSystem(String rootPath) {
        try {
            // Create base directories
            String uploadsPath = rootPath + File.separator + BASE_UPLOAD_DIR;
            createDirectory(uploadsPath);

            // Create assignments and submissions directories for each class
            String assignmentsPath = uploadsPath + File.separator + "assignments";
            createDirectory(assignmentsPath);

            for (String classFolder : CLASS_FOLDERS) {
                String classPath = assignmentsPath + File.separator + classFolder;
                createDirectory(classPath);
                
                // Create submissions folder for each class
                String submissionsPath = classPath + File.separator + "submissions";
                createDirectory(submissionsPath);
            }

            // Set appropriate permissions
            setPermissions(Paths.get(uploadsPath));

            logger.info("File system initialized successfully");
        } catch (Exception e) {
            logger.severe("Error initializing file system: " + e.getMessage());
            throw new RuntimeException("Failed to initialize file system", e);
        }
    }

    private void createDirectory(String path) throws Exception {
        File dir = new File(path);
        if (!dir.exists()) {
            if (!dir.mkdirs()) {
                throw new Exception("Failed to create directory: " + path);
            }
        }
    }

    private void setPermissions(Path path) {
        try {
            // For Unix-like systems
            if (!System.getProperty("os.name").toLowerCase().contains("windows")) {
                Set<PosixFilePermission> permissions = Set.of(
                    PosixFilePermission.OWNER_READ,
                    PosixFilePermission.OWNER_WRITE,
                    PosixFilePermission.OWNER_EXECUTE,
                    PosixFilePermission.GROUP_READ,
                    PosixFilePermission.GROUP_WRITE,
                    PosixFilePermission.GROUP_EXECUTE
                );
                Files.setPosixFilePermissions(path, permissions);
            }
            
            // For Windows systems
            File file = path.toFile();
            file.setReadable(true, false);
            file.setWritable(true, false);
            file.setExecutable(true, false);
        } catch (Exception e) {
            logger.warning("Error setting permissions for " + path + ": " + e.getMessage());
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
    }
} 