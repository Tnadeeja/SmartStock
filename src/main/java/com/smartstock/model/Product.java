package com.smartstock.model;

public class Product {

    private int productId;
    private String productName;
    private String categoryName;
    private double unitPrice;
    private double salePrice;

    // Getters
    public int getProductId() {
        return productId;
    }
    public String getProductName() {
        return productName;
    }
    public String getCategoryName() {
        return categoryName;
    }
    public double getUnitPrice() {
        return unitPrice;
    }
    public double getSalePrice() {
        return salePrice;
    }

    // Setters
    public void setProductId(int productId) {
        this.productId = productId;
    }
    public void setProductName(String productName) {
        this.productName = productName;
    }
    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }
    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }
    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }
}
