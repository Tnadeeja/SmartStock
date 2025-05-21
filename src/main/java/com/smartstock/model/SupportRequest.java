package com.smartstock.model;

import java.sql.Timestamp;

public class SupportRequest {
    private int id;
    private String name;
    private String post;
    private String email;
    private String description;
    private Timestamp createdAt; // ✅ New field

    // Constructors
    public SupportRequest() {}

    public SupportRequest(String name, String post, String email, String description) {
        this.name = name;
        this.post = post;
        this.email = email;
        this.description = description;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getPost() { return post; }
    public void setPost(String post) { this.post = post; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public Timestamp getCreatedAt() { return createdAt; } // ✅ Getter
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; } // ✅ Setter
}
