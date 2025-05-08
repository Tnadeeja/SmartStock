package com.smartstock.model;

public class Product {

    private int productId;
    private String productName;
    private String categoryName;
    private int quantityInStock;
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
    public int getQuantityInStock() {
        return quantityInStock;
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
    public void setQuantityInStock(int quantityInStock) {
        this.quantityInStock = quantityInStock;
    }
    public void setUnitPrice(double unitPrice) {
        this.unitPrice = unitPrice;
    }
    public void setSalePrice(double salePrice) {
        this.salePrice = salePrice;
    }
}
