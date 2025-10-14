package com.greensense.util;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String password; // This will be the hash
    private String role;

    // Constructors
    public User() {}

    // Getters and Setters for all fields...
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}