package com.smartstock.model;

import java.util.Date;

public class ReturnProduct {
	public int returnId;
	public String productName;
	public int quantity;
	public String reason;
	public Date returnDate;
	
	// Getters and setters can be added below
	public int getReturnId() {
		return returnId;
	}
	public String getProductName() {
		return productName;
	}
	public int getQuantity() {
		return quantity;
	}
	public String getReason() {
		return reason;
	}
	public Date getReturnDate() {
		return returnDate;
	}
	public void setReturnId(int returnId) {
		this.returnId = returnId;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	public void setReturnDate(Date returnDate) {
		this.returnDate = returnDate;
	}

    
	
}
