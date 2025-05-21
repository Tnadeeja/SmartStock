package com.smartstock.dao;

import com.smartstock.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class StockDAO {

    private int getTotalQuantity(String tableName, String productName) {
        String query = "SELECT COALESCE(SUM(quantity), 0) FROM " + tableName + " WHERE product_name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, productName);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    private double getUnitPrice(String productName) {
        String query = "SELECT unit_price FROM product WHERE product_name = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, productName);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getDouble("unit_price");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public int getCurrentStockQuantity(String productName) {
        int purchasedQty = getTotalQuantity("purchase_product", productName);
        int outgoingQty = getTotalQuantity("outgoing_product", productName);
        int returnedQty = getTotalQuantity("return_product", productName);

        return purchasedQty - (outgoingQty + returnedQty);
    }

    public double getCurrentStockValue(String productName) {
        int stockQuantity = getCurrentStockQuantity(productName);
        double unitPrice = getUnitPrice(productName);
        return stockQuantity * unitPrice;
    }
}