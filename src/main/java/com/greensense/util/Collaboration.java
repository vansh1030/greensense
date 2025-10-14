package com.greensense.util;

public class Collaboration {
    private String title;
    private String description;
    private String contactInfo;

    public Collaboration(String title, String description, String contactInfo) {
        this.title = title;
        this.description = description;
        this.contactInfo = contactInfo;
    }

    // Getters
    public String getTitle() { return title; }
    public String getDescription() { return description; }
    public String getContactInfo() { return contactInfo; }
}