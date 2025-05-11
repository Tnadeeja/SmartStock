package com.smartstock.service;

import com.smartstock.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DashboardService {

    public int getCount(String tableName) {
        String query = "SELECT COUNT(*) FROM " + tableName;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public double getTotal(String tableName) {
        String query = "SELECT SUM(total_amount) FROM " + tableName;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) return rs.getDouble(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0.0;
    }

    public String getMostOutgoingProduct() {
        String query = "SELECT product_name, SUM(quantity) as total_qty FROM outgoing_product GROUP BY product_name ORDER BY total_qty DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("product_name") + " (" + rs.getInt("total_qty") + " units)";
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "N/A";
    }

    public int getCurrentStock() {
        String purchaseQuery = "SELECT IFNULL(SUM(quantity), 0) FROM purchase_product";
        String outgoingQuery = "SELECT IFNULL(SUM(quantity), 0) FROM outgoing_product";
        int purchased = 0;
        int sold = 0;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps1 = conn.prepareStatement(purchaseQuery);
             ResultSet rs1 = ps1.executeQuery()) {
            if (rs1.next()) purchased = rs1.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps2 = conn.prepareStatement(outgoingQuery);
             ResultSet rs2 = ps2.executeQuery()) {
            if (rs2.next()) sold = rs2.getInt(1);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return purchased - sold;
    }
}
