package com.greensense.util;

import java.sql.Timestamp;

public class Complaint {
    private int id;
    private String description;
    private String imagePath;
    private String status;
    private Timestamp submittedAt;
    private String citizenFullName;

    // New fields
    private int citizenId;
    private String category;
    private double latitude;
    private double longitude;

    // Existing constructor
    public Complaint(int id, String description, String imagePath, String status, Timestamp submittedAt, String citizenFullName) {
        this.id = id;
        this.description = description;
        this.imagePath = imagePath;
        this.status = status;
        this.submittedAt = submittedAt;
        this.citizenFullName = citizenFullName;
    }

    // Empty constructor
    public Complaint() {}

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImagePath() { return imagePath; }
    public void setImagePath(String imagePath) { this.imagePath = imagePath; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getSubmittedAt() { return submittedAt; }
    public void setSubmittedAt(Timestamp submittedAt) { this.submittedAt = submittedAt; }
    public String getCitizenFullName() { return citizenFullName; }
    public void setCitizenFullName(String citizenFullName) { this.citizenFullName = citizenFullName; }

    // --- Auto-generated getters and setters for new fields ---
    public int getCitizenId() {
        return citizenId;
    }

    public void setCitizenId(int citizenId) {
        this.citizenId = citizenId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }
}