package com.smartstock.model;

import java.util.Date;

public class SystemUser {
	public int userId;
    public String email;
    public String password;
    public String filename;
    public String role;
    public Date createdAt;
	public int getUserId() {
		return userId;
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
	public void setUserId(int userId) {
		this.userId = userId;
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
