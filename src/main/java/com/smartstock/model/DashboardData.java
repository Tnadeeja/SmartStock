package com.smartstock.model;

public class DashboardData {

private int totalCategories;
private int totalProducts;
private int totalCustomers;
private int totalSuppliers;
private int totalAlerts;
private int totalUsers;

private int currentStock;
private String mostOutgoingProduct;
private int currentReturns;

private double totalSales;
private double totalCost;
private double totalProfit;
private double profitMargin;

// Getters and Setters for all fields

public int getTotalCategories() {
    return totalCategories;
}

public void setTotalCategories(int totalCategories) {
    this.totalCategories = totalCategories;
}

public int getTotalProducts() {
    return totalProducts;
}

public void setTotalProducts(int totalProducts) {
    this.totalProducts = totalProducts;
}

public int getTotalCustomers() {
    return totalCustomers;
}

public void setTotalCustomers(int totalCustomers) {
    this.totalCustomers = totalCustomers;
}

public int getTotalSuppliers() {
    return totalSuppliers;
}

public void setTotalSuppliers(int totalSuppliers) {
    this.totalSuppliers = totalSuppliers;
}

public int getTotalAlerts() {
    return totalAlerts;
}

public void setTotalAlerts(int totalAlerts) {
    this.totalAlerts = totalAlerts;
}

public int getTotalUsers() {
    return totalUsers;
}

public void setTotalUsers(int totalUsers) {
    this.totalUsers = totalUsers;
}

public int getCurrentStock() {
    return currentStock;
}

public void setCurrentStock(int currentStock) {
    this.currentStock = currentStock;
}

public String getMostOutgoingProduct() {
    return mostOutgoingProduct;
}

public void setMostOutgoingProduct(String mostOutgoingProduct) {
    this.mostOutgoingProduct = mostOutgoingProduct;
}

public int getCurrentReturns() {
    return currentReturns;
}

public void setCurrentReturns(int currentReturns) {
    this.currentReturns = currentReturns;
}

public double getTotalSales() {
    return totalSales;
}

public void setTotalSales(double totalSales) {
    this.totalSales = totalSales;
}

public double getTotalCost() {
    return totalCost;
}

public void setTotalCost(double totalCost) {
    this.totalCost = totalCost;
}

public double getTotalProfit() {
    return totalProfit;
}

public void setTotalProfit(double totalProfit) {
    this.totalProfit = totalProfit;
}

public double getProfitMargin() {
    return profitMargin;
}

public void setProfitMargin(double profitMargin) {
    this.profitMargin = profitMargin;
}

}