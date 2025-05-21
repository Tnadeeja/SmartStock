package com.smartstock.model;

import java.util.Date;

public class OutgoingProduct {

    private int outgoingId;
    private String productName;
    private String categoryName;
    private String customerName;
    private int quantity;
    private double salePrice;
    private double totalAmount;
    private Date manufactureDate;
    private Date expireDate;
    private Date outgoingDate;
    
	public int getOutgoingId() {
		return outgoingId;
	}
	public String getProductName() {
		return productName;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public String getCustomerName() {
		return customerName;
	}
	public int getQuantity() {
		return quantity;
	}
	public double getSalePrice() {
		return salePrice;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public Date getManufactureDate() {
		return manufactureDate;
	}
	public Date getExpireDate() {
		return expireDate;
	}
	public Date getOutgoingDate() {
		return outgoingDate;
	}
	public void setOutgoingId(int outgoingId) {
		this.outgoingId = outgoingId;
	}
	public void setProductName(String productName) {
		this.productName = productName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	public void setSalePrice(double salePrice) {
		this.salePrice = salePrice;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public void setManufactureDate(Date manufactureDate) {
		this.manufactureDate = manufactureDate;
	}
	public void setExpireDate(Date expireDate) {
		this.expireDate = expireDate;
	}
	public void setOutgoingDate(Date outgoingDate) {
		this.outgoingDate = outgoingDate;
	}
    
    
}

