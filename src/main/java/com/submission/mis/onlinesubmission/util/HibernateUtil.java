package com.submission.mis.onlinesubmission.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

/**
 * Utility class for managing Hibernate sessions and transactions.
 * Provides centralized session factory management and transaction handling.
 */
public class HibernateUtil {
    /** The single SessionFactory instance for the application */
    private static final SessionFactory sessionFactory;

    // Initialize the SessionFactory
    static {
        try {
            sessionFactory = new Configuration().configure().buildSessionFactory();
        } catch (Throwable ex) {
            System.err.println("Initial SessionFactory creation failed." + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    /**
     * Gets the SessionFactory instance.
     * @return The singleton SessionFactory instance
     */
    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }

    /**
     * Opens and returns a new Hibernate Session.
     * @return A new Session instance
     */
    public static Session getSession() {
        return sessionFactory.openSession();
    }

    /**
     * Safely closes a Hibernate Session if it's open.
     * @param session The Session to close
     */
    public static void closeSession(Session session) {
        if (session != null && session.isOpen()) {
            session.close();
        }
    }

    /**
     * Executes an operation within a transaction, handling commit and rollback.
     * @param operation The database operation to execute
     * @throws RuntimeException if the transaction fails
     */
    public static void executeInTransaction(TransactionOperation operation) throws Exception {
        Session session = getSession();
        try {
            session.beginTransaction();
            operation.execute(session);
            session.getTransaction().commit();
        } catch (Exception e) {
            if (session.getTransaction() != null) {
                session.getTransaction().rollback();
            }
            throw e;
        } finally {
            closeSession(session);
        }
    }

    /**
     * Functional interface for database operations that need to be executed within a transaction.
     */
    @FunctionalInterface
    public interface TransactionOperation {
        /**
         * Executes a database operation.
         * @param session The Hibernate Session to use
         * @throws Exception if the operation fails
         */
        void execute(Session session) throws Exception;
    }
}
