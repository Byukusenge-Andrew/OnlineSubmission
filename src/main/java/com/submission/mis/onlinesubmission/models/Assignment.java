package com.submission.mis.onlinesubmission.models;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.hibernate.annotations.GenericGenerator;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;

/**
 * Entity class representing an Assignment in the system.
 * Contains assignment details, deadlines, and submission tracking.
 */
@Entity
public class Assignment {
    /** Unique identifier for the assignment */
    @Id
    @GeneratedValue(generator = "UUID")
    @GenericGenerator(
        name = "UUID",
        strategy = "org.hibernate.id.UUIDGenerator"
    )
    @Column(name = "id", updatable = false, nullable = false)
    private UUID id;

    /** Assignment title */
    private String title;

    /** Detailed description of the assignment */
    private String description;

    /** Teacher who created the assignment */
    @ManyToOne
    @JoinColumn(name = "teacher_id", nullable = false)
    private Teacher teacher;

    /** Date when the assignment was posted */
    private LocalDate Posttime;

    /** course of the assignment */
      private String course;

    /** Due date for the assignment */
    private LocalDate deadline;

    /** List of students who have submitted this assignment */
    @ManyToMany
    @JoinTable(
        name = "assignment_submission",
        joinColumns = @JoinColumn(name = "assignment_id"),
        inverseJoinColumns = @JoinColumn(name = "student_id")
    )
    private List<Student> submittedStudents;

    /** Teacher who owns/created the assignment */
    @ManyToOne
    @JoinColumn(name = "owner_id", nullable = true)
    private Teacher owner;

    /** Teachers who can view this assignment */
    @ManyToMany
    @JoinTable(
        name = "assignment_teachers",
        joinColumns = @JoinColumn(name = "assignment_id"),
        inverseJoinColumns = @JoinColumn(name = "teacher_id")
    )
    private List<Teacher> sharedTeachers = new ArrayList<>();

    @OneToMany(mappedBy = "assignment", cascade = CascadeType.ALL)
    private List<Submission> submissions = new ArrayList<>();

    /** Default constructor required by JPA */
    public Assignment() {}

    /**
     * Creates a new Assignment with the specified details.
     * @param title The assignment title
     * @param description The assignment description
     * @param owner The teacher creating the assignment
     * @param posttime When the assignment should be posted
     * @param deadline When the assignment is due
     * @param course assignment course
     */
    public Assignment(String title, String description, String course, Teacher owner, LocalDate posttime, LocalDate deadline) {
        this.title = title;
        this.description = description;
        this.teacher = owner;
        this.owner = owner;
        this.Posttime = posttime;
        this.deadline = deadline;
        this.course = course;
    }

    public String getCourse() {
        return course;
    }

    public void setCourse(String course) {
        this.course = course;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Teacher getTeacher() {
        return teacher;
    }

    public void setTeacher(Teacher teacher) {
        this.teacher = teacher;
    }

    public LocalDate getPosttime() {
        return Posttime;
    }

    public void setPosttime(LocalDate posttime) {
        Posttime = posttime;
    }

    public LocalDate getDeadline() {
        return deadline;
    }

    public void setDeadline(LocalDate deadline) {
        this.deadline = deadline;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public List<Student> getSubmittedStudents() {
        return submittedStudents;
    }

    public void setSubmittedStudents(List<Student> submittedStudents) {
        this.submittedStudents = submittedStudents;
    }

    public Teacher getOwner() {
        return owner;
    }

    public void setOwner(Teacher owner) {
        this.owner = owner;
    }

    public List<Teacher> getSharedTeachers() {
        return sharedTeachers;
    }

    public void setSharedTeachers(List<Teacher> sharedTeachers) {
        this.sharedTeachers = sharedTeachers;
    }

    public boolean isOwner(Teacher teacher) {
        return owner != null && owner.getId().equals(teacher.getId());
    }

    public List<Submission> getSubmissions() {
        return submissions;
    }

    public void setSubmissions(List<Submission> submissions) {
        this.submissions = submissions;
    }
}
