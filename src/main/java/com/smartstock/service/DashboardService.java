package com.smartstock.service;

import com.smartstock.dao.DashboardDAO;
import com.smartstock.model.DashboardData;

public class DashboardService {
	
private DashboardDAO dashboardDAO;

public DashboardService() {
    this.dashboardDAO = new DashboardDAO();
}

public DashboardData getDashboardData() {
    // Fetch all the necessary data from the DAO layer
    int totalCategories = dashboardDAO.getTotalCategories();
    int totalProducts = dashboardDAO.getTotalProducts();
    int totalCustomers = dashboardDAO.getTotalCustomers();
    int totalSuppliers = dashboardDAO.getTotalSuppliers();
    int totalAlerts = dashboardDAO.getTotalAlerts();
    int totalUsers = dashboardDAO.getTotalUsers();
    
    int currentStock = dashboardDAO.getCurrentStock();
    String mostOutgoingProduct = dashboardDAO.getMostOutgoingProduct();
    int currentReturns = dashboardDAO.getCurrentReturns();

    double totalSales = dashboardDAO.getTotalSales();  // Total revenue from sales
    double totalCost = dashboardDAO.getTotalCost();    // Total cost of purchases
    double totalProfit = totalSales - totalCost;       // Profit = Sales - Cost
    double profitMargin = (totalProfit / totalSales) * 100; // Profit Margin %

    // Create a DashboardData object and set all the values
    DashboardData dashboardData = new DashboardData();
    dashboardData.setTotalCategories(totalCategories);
    dashboardData.setTotalProducts(totalProducts);
    dashboardData.setTotalCustomers(totalCustomers);
    dashboardData.setTotalSuppliers(totalSuppliers);
    dashboardData.setTotalAlerts(totalAlerts);
    dashboardData.setTotalUsers(totalUsers);
    dashboardData.setCurrentStock(currentStock);
    dashboardData.setMostOutgoingProduct(mostOutgoingProduct);
    dashboardData.setCurrentReturns(currentReturns);
    dashboardData.setTotalProfit(totalProfit);
    dashboardData.setProfitMargin(profitMargin);

    return dashboardData;
}

}