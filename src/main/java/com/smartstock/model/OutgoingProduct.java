package com.smartstock.model;

import java.util.Date;

public class OutgoingProduct {

    public int outgoingId;
    public String productName;
    public String categoryName;
    public String customerName;
    public int quantity;
    public double salePrice;
    public double totalAmount;
    public Date manufactureDate;
    public Date expireDate;
    public Date outgoingDate;
    
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

