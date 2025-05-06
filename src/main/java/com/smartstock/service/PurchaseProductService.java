package com.smartstock.service;

import com.smartstock.model.PurchaseProduct;
import com.smartstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PurchaseProductService {

    public boolean createPurchaseProduct(PurchaseProduct product) {
        String query = "INSERT INTO purchase_product (product_name, category_name, supplier_name, quantity, unit_price, total_amount, manufacture_date, expire_date, purchase_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, product.productName);
            stmt.setString(2, product.categoryName);
            stmt.setString(3, product.supplierName);
            stmt.setInt(4, product.quantity);
            stmt.setDouble(5, product.unitPrice);
            stmt.setDouble(6, product.totalAmount);
            stmt.setDate(7, new java.sql.Date(product.manufactureDate.getTime()));
            stmt.setDate(8, new java.sql.Date(product.expireDate.getTime()));
            stmt.setTimestamp(9, new java.sql.Timestamp(product.purchaseDate.getTime()));
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public PurchaseProduct getPurchaseProduct(int id) {
        String query = "SELECT * FROM purchase_product WHERE purchase_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                PurchaseProduct product = new PurchaseProduct();
                product.purchaseId = rs.getInt("purchase_id");
                product.productName = rs.getString("product_name");
                product.categoryName = rs.getString("category_name");
                product.supplierName = rs.getString("supplier_name");
                product.quantity = rs.getInt("quantity");
                product.unitPrice = rs.getDouble("unit_price");
                product.totalAmount = rs.getDouble("total_amount");
                product.manufactureDate = rs.getDate("manufacture_date");
                product.expireDate = rs.getDate("expire_date");
                product.purchaseDate = rs.getTimestamp("purchase_date");
                return product;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<PurchaseProduct> getAllPurchaseProducts() {
        List<PurchaseProduct> products = new ArrayList<>();
        String query = "SELECT * FROM purchase_product";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                PurchaseProduct product = new PurchaseProduct();
                product.purchaseId = rs.getInt("purchase_id");
                product.productName = rs.getString("product_name");
                product.categoryName = rs.getString("category_name");
                product.supplierName = rs.getString("supplier_name");
                product.quantity = rs.getInt("quantity");
                product.unitPrice = rs.getDouble("unit_price");
                product.totalAmount = rs.getDouble("total_amount");
                product.manufactureDate = rs.getDate("manufacture_date");
                product.expireDate = rs.getDate("expire_date");
                product.purchaseDate = rs.getTimestamp("purchase_date");
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean updatePurchaseProduct(PurchaseProduct product) {
        String query = "UPDATE purchase_product SET product_name = ?, category_name = ?, supplier_name = ?, quantity = ?, unit_price = ?, total_amount = ?, manufacture_date = ?, expire_date = ?, purchase_date = ? WHERE purchase_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, product.productName);
            stmt.setString(2, product.categoryName);
            stmt.setString(3, product.supplierName);
            stmt.setInt(4, product.quantity);
            stmt.setDouble(5, product.unitPrice);
            stmt.setDouble(6, product.totalAmount);
            stmt.setDate(7, new java.sql.Date(product.manufactureDate.getTime()));
            stmt.setDate(8, new java.sql.Date(product.expireDate.getTime()));
            stmt.setTimestamp(9, new java.sql.Timestamp(product.purchaseDate.getTime()));
            stmt.setInt(10, product.purchaseId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deletePurchaseProduct(int id) {
        String query = "DELETE FROM purchase_product WHERE purchase_id = ?";
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