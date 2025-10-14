package com.greensense.util;

import java.sql.Timestamp;

public class Update {
    private String title;
    private String content;
    private Timestamp createdAt;
    private int adminId;

    // Existing constructor
    public Update(String title, String content, Timestamp createdAt) {
        this.title = title;
        this.content = content;
        this.createdAt = createdAt;
    }
    
    // Add this empty constructor
    public Update() {}

    // Getters and Setters...


    // Getters
    public String getTitle() { return title; }
    public String getContent() { return content; }
    public Timestamp getCreatedAt() { return createdAt; }

	public int getAdminId() {
		// TODO Auto-generated method stub
		return 0;
	}

	public void setTitle(String parameter) {
		// TODO Auto-generated method stub
		
	}

	public void setContent(String parameter) {
		// TODO Auto-generated method stub
		
	}

	public void setAdminId(int attribute) {
		// TODO Auto-generated method stub
		
	}
}