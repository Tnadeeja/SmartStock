package com.smartstock.model;

public class Product {

    private int productId;
    private String productName;
    private String categoryName;
    private double unitPrice;
    private double salePrice;

    // New fields for stock info
    private int stockQuantity;
    private double stockValue;

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
    public int getStockQuantity() {
        return stockQuantity;
    }
    public double getStockValue() {
        return stockValue;
    }

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
    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }
    public void setStockValue(double stockValue) {
        this.stockValue = stockValue;
    }
}