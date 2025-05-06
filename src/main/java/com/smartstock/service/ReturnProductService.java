package com.smartstock.service;

import com.smartstock.model.ReturnProduct;
import com.smartstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReturnProductService {

    // Create Return Product
    public boolean createReturnProduct(ReturnProduct returnProduct) {
        String query = "INSERT INTO return_product (product_name, quantity, reason, return_date) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, returnProduct.productName);
            stmt.setInt(2, returnProduct.quantity);
            stmt.setString(3, returnProduct.reason);
            stmt.setTimestamp(4, new java.sql.Timestamp(returnProduct.returnDate.getTime()));
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Return Product by ID
    public ReturnProduct getReturnProduct(int id) {
        String query = "SELECT * FROM return_product WHERE return_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                ReturnProduct returnProduct = new ReturnProduct();
                returnProduct.returnId = rs.getInt("return_id");
                returnProduct.productName = rs.getString("product_name");
                returnProduct.quantity = rs.getInt("quantity");
                returnProduct.reason = rs.getString("reason");
                returnProduct.returnDate = rs.getTimestamp("return_date");
                return returnProduct;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Return Products
    public List<ReturnProduct> getAllReturnProducts() {
        List<ReturnProduct> returnProducts = new ArrayList<>();
        String query = "SELECT * FROM return_product";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                ReturnProduct returnProduct = new ReturnProduct();
                returnProduct.returnId = rs.getInt("return_id");
                returnProduct.productName = rs.getString("product_name");
                returnProduct.quantity = rs.getInt("quantity");
                returnProduct.reason = rs.getString("reason");
                returnProduct.returnDate = rs.getTimestamp("return_date");
                returnProducts.add(returnProduct);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return returnProducts;
    }

    // Update Return Product
    public boolean updateReturnProduct(ReturnProduct returnProduct) {
        String query = "UPDATE return_product SET product_name = ?, quantity = ?, reason = ?, return_date = ? WHERE return_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, returnProduct.productName);
            stmt.setInt(2, returnProduct.quantity);
            stmt.setString(3, returnProduct.reason);
            stmt.setTimestamp(4, new java.sql.Timestamp(returnProduct.returnDate.getTime()));
            stmt.setInt(5, returnProduct.returnId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Return Product
    public boolean deleteReturnProduct(int id) {
        String query = "DELETE FROM return_product WHERE return_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
