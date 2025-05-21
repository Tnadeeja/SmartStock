package com.smartstock.model;

import java.util.Date;

public class SystemUser {
    public int userId;
    public String name;
    public String phone;
    public String address;
    public String email;
    public String password;
    public String filename;
    public String role;
    public Date createdAt;

    // Getters
    public int getUserId() {
        return userId;
    }
    public String getName() {
        return name;
    }
    public String getPhone() {
        return phone;
    }
    public String getAddress() {
        return address;
    }
    public String getEmail() {
        return email;
    }
    public String getPassword() {
        return password;
    }
    public String getFilename() {
        return filename;
    }
    public String getRole() {
        return role;
    }
    public Date getCreatedAt() {
        return createdAt;
    }

    // Setters
    public void setUserId(int userId) {
        this.userId = userId;
    }
    public void setName(String name) {
        this.name = name;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public void setEmail(String email) {
        this.email = email;
    }
    public void setPassword(String password) {
        this.password = password;
    }
    public void setFilename(String filename) {
        this.filename = filename;
    }
    public void setRole(String role) {
        this.role = role;
    }
    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }
}
