package model;

import java.time.LocalDate;

public class Ticket {
    private int ticketId;
    private LocalDate submissionDate;
    private String email;
    private String ticketStatus;
    private String subject;
    private String message;

    // Getters, Setters, Construtor
    public Ticket(int ticketId, LocalDate submissionDate, String email, String ticketStatus, String subject, String message) {
        this.ticketId = ticketId;
        this.submissionDate = submissionDate;
        this.email = email;
        this.ticketStatus = ticketStatus;
        this.subject = subject;
        this.message = message;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public LocalDate getSubmissionDate() {
        return submissionDate;
    }

    public void setSubmissionDate(LocalDate submissionDate) {
        this.submissionDate = submissionDate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getTicketStatus() {
        return ticketStatus;
    }

    public void setTicketStatus(String ticketStatus) {
        this.ticketStatus = ticketStatus;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }


    public boolean isResolved() {
        return "resolved".equalsIgnoreCase(ticketStatus);
    }

    public void markAsResolved() {
        this.ticketStatus = "resolved";
    }
}
