package com.smartstock.dao;

import java.sql.*;
import com.smartstock.util.DBConnection;

public class DashboardDAO {

private Connection connection;

public DashboardDAO() {
    this.connection = DBConnection.getConnection();
}

public int getTotalCategories() {
    String query = "SELECT COUNT(*) FROM category";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}

public int getTotalProducts() {
    String query = "SELECT COUNT(*) FROM product";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}

public int getTotalCustomers() {
    String query = "SELECT COUNT(*) FROM customer";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}

public int getTotalSuppliers() {
    String query = "SELECT COUNT(*) FROM supplier";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}

public int getTotalAlerts() {
    String query = "SELECT COUNT(*) FROM support_requests WHERE status = 'alert'";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}

public int getTotalUsers() {
    String query = "SELECT COUNT(*) FROM system_users";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}

public int getCurrentStock() {
    int purchased = 0, outgoing = 0, returned = 0;

    try {
        String purchasedQuery = "SELECT COALESCE(SUM(quantity), 0) FROM purchase_product";
        try (PreparedStatement ps = connection.prepareStatement(purchasedQuery);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) purchased = rs.getInt(1);
        }

        String outgoingQuery = "SELECT COALESCE(SUM(quantity), 0) FROM outgoing_product";
        try (PreparedStatement ps = connection.prepareStatement(outgoingQuery);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) outgoing = rs.getInt(1);
        }

        String returnQuery = "SELECT COALESCE(SUM(quantity), 0) FROM return_product";
        try (PreparedStatement ps = connection.prepareStatement(returnQuery);
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) returned = rs.getInt(1);
        }

    } catch (SQLException e) {
        e.printStackTrace();
    }

    return purchased - outgoing - returned;
}

public String getMostOutgoingProduct() {
    String query = "SELECT product_name, SUM(quantity) AS total " +
                   "FROM outgoing_product GROUP BY product_name ORDER BY total DESC LIMIT 1";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) {
            return rs.getString("product_name") + " (" + rs.getInt("total") + " units)";
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return "N/A";
}

public int getCurrentReturns() {
    String query = "SELECT SUM(quantity) FROM return_product";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) return rs.getInt(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0;
}

public double getTotalSales() {
    String query = "SELECT SUM(total_amount) FROM outgoing_product";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) return rs.getDouble(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0.0;
}

public double getTotalCost() {
    String query = "SELECT SUM(total_amount) FROM purchase_product";
    try (Statement stmt = connection.createStatement()) {
        ResultSet rs = stmt.executeQuery(query);
        if (rs.next()) return rs.getDouble(1);
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return 0.0;
}

}