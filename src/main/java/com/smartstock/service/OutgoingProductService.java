package com.smartstock.service;

import com.smartstock.model.OutgoingProduct;
import com.smartstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OutgoingProductService {

    // Create Outgoing Product
    public boolean createOutgoingProduct(OutgoingProduct product) {
        String query = "INSERT INTO outgoing_product (product_name, category_name, customer_name, quantity, sale_price, total_amount, manufacture_date, expire_date, outgoing_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, product.productName);
            stmt.setString(2, product.categoryName);
            stmt.setString(3, product.customerName);
            stmt.setInt(4, product.quantity);
            stmt.setDouble(5, product.salePrice);
            stmt.setDouble(6, product.totalAmount);
            stmt.setDate(7, new java.sql.Date(product.manufactureDate.getTime()));
            stmt.setDate(8, new java.sql.Date(product.expireDate.getTime()));
            stmt.setTimestamp(9, new java.sql.Timestamp(product.outgoingDate.getTime()));
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Outgoing Product by ID
    public OutgoingProduct getOutgoingProduct(int id) {
        String query = "SELECT * FROM outgoing_product WHERE outgoing_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                OutgoingProduct product = new OutgoingProduct();
                product.outgoingId = rs.getInt("outgoing_id");
                product.productName = rs.getString("product_name");
                product.categoryName = rs.getString("category_name");
                product.customerName = rs.getString("customer_name");
                product.quantity = rs.getInt("quantity");
                product.salePrice = rs.getDouble("sale_price");
                product.totalAmount = rs.getDouble("total_amount");
                product.manufactureDate = rs.getDate("manufacture_date");
                product.expireDate = rs.getDate("expire_date");
                product.outgoingDate = rs.getTimestamp("outgoing_date");
                return product;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Outgoing Products
    public List<OutgoingProduct> getAllOutgoingProducts() {
        List<OutgoingProduct> products = new ArrayList<>();
        String query = "SELECT * FROM outgoing_product";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                OutgoingProduct product = new OutgoingProduct();
                product.outgoingId = rs.getInt("outgoing_id");
                product.productName = rs.getString("product_name");
                product.categoryName = rs.getString("category_name");
                product.customerName = rs.getString("customer_name");
                product.quantity = rs.getInt("quantity");
                product.salePrice = rs.getDouble("sale_price");
                product.totalAmount = rs.getDouble("total_amount");
                product.manufactureDate = rs.getDate("manufacture_date");
                product.expireDate = rs.getDate("expire_date");
                product.outgoingDate = rs.getTimestamp("outgoing_date");
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    // Update Outgoing Product
    public boolean updateOutgoingProduct(OutgoingProduct product) {
        String query = "UPDATE outgoing_product SET product_name = ?, category_name = ?, customer_name = ?, quantity = ?, sale_price = ?, total_amount = ?, manufacture_date = ?, expire_date = ?, outgoing_date = ? WHERE outgoing_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, product.productName);
            stmt.setString(2, product.categoryName);
            stmt.setString(3, product.customerName);
            stmt.setInt(4, product.quantity);
            stmt.setDouble(5, product.salePrice);
            stmt.setDouble(6, product.totalAmount);
            stmt.setDate(7, new java.sql.Date(product.manufactureDate.getTime()));
            stmt.setDate(8, new java.sql.Date(product.expireDate.getTime()));
            stmt.setTimestamp(9, new java.sql.Timestamp(product.outgoingDate.getTime()));
            stmt.setInt(10, product.outgoingId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Outgoing Product
    public boolean deleteOutgoingProduct(int id) {
        String query = "DELETE FROM outgoing_product WHERE outgoing_id = ?";
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
