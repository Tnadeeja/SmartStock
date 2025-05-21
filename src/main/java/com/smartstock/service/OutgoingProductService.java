package com.smartstock.service;

import com.smartstock.model.OutgoingProduct;
import com.smartstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OutgoingProductService {

    // Create Outgoing Product
    public boolean createOutgoingProduct(OutgoingProduct product) {
        String query = "INSERT INTO outgoing_product (product_name, category_name, customer_name, quantity, sale_price, total_amount, manufacture_date, expire_date, outgoing_date) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getCategoryName());
            stmt.setString(3, product.getCustomerName());
            stmt.setInt(4, product.getQuantity());
            stmt.setDouble(5, product.getSalePrice());
            stmt.setDouble(6, product.getTotalAmount());
            stmt.setDate(7, new java.sql.Date(product.getManufactureDate().getTime()));
            stmt.setDate(8, new java.sql.Date(product.getExpireDate().getTime()));
            stmt.setTimestamp(9, new java.sql.Timestamp(product.getOutgoingDate().getTime()));
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
                product.setOutgoingId(rs.getInt("outgoing_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryName(rs.getString("category_name"));
                product.setCustomerName(rs.getString("customer_name"));
                product.setQuantity(rs.getInt("quantity"));
                product.setSalePrice(rs.getDouble("sale_price"));
                product.setTotalAmount(rs.getDouble("total_amount"));
                product.setManufactureDate(rs.getDate("manufacture_date"));
                product.setExpireDate(rs.getDate("expire_date"));
                product.setOutgoingDate(rs.getTimestamp("outgoing_date"));
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
                product.setOutgoingId(rs.getInt("outgoing_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryName(rs.getString("category_name"));
                product.setCustomerName(rs.getString("customer_name"));
                product.setQuantity(rs.getInt("quantity"));
                product.setSalePrice(rs.getDouble("sale_price"));
                product.setTotalAmount(rs.getDouble("total_amount"));
                product.setManufactureDate(rs.getDate("manufacture_date"));
                product.setExpireDate(rs.getDate("expire_date"));
                product.setOutgoingDate(rs.getTimestamp("outgoing_date"));
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
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getCategoryName());
            stmt.setString(3, product.getCustomerName());
            stmt.setInt(4, product.getQuantity());
            stmt.setDouble(5, product.getSalePrice());
            stmt.setDouble(6, product.getTotalAmount());
            stmt.setDate(7, new java.sql.Date(product.getManufactureDate().getTime()));
            stmt.setDate(8, new java.sql.Date(product.getExpireDate().getTime()));
            stmt.setTimestamp(9, new java.sql.Timestamp(product.getOutgoingDate().getTime()));
            stmt.setInt(10, product.getOutgoingId());
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

    // Get Filtered Outgoing Products
    public List<OutgoingProduct> getFilteredOutgoingProducts(String search, String category, String customer, Date fromDate, Date toDate) {
        List<OutgoingProduct> products = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM outgoing_product WHERE 1=1");

        if (search != null && !search.trim().isEmpty()) {
            query.append(" AND product_name LIKE ?");
        }
        if (category != null && !category.trim().isEmpty()) {
            query.append(" AND category_name = ?");
        }
        if (customer != null && !customer.trim().isEmpty()) {
            query.append(" AND customer_name = ?");
        }
        if (fromDate != null) {
            query.append(" AND outgoing_date >= ?");
        }
        if (toDate != null) {
            query.append(" AND outgoing_date <= ?");
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            int index = 1;

            if (search != null && !search.trim().isEmpty()) {
                stmt.setString(index++, "%" + search + "%");
            }
            if (category != null && !category.trim().isEmpty()) {
                stmt.setString(index++, category);
            }
            if (customer != null && !customer.trim().isEmpty()) {
                stmt.setString(index++, customer);
            }
            if (fromDate != null) {
                stmt.setTimestamp(index++, new java.sql.Timestamp(fromDate.getTime()));
            }
            if (toDate != null) {
                stmt.setTimestamp(index++, new java.sql.Timestamp(toDate.getTime()));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                OutgoingProduct product = new OutgoingProduct();
                product.setOutgoingId(rs.getInt("outgoing_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryName(rs.getString("category_name"));
                product.setCustomerName(rs.getString("customer_name"));
                product.setQuantity(rs.getInt("quantity"));
                product.setSalePrice(rs.getDouble("sale_price"));
                product.setTotalAmount(rs.getDouble("total_amount"));
                product.setManufactureDate(rs.getDate("manufacture_date"));
                product.setExpireDate(rs.getDate("expire_date"));
                product.setOutgoingDate(rs.getTimestamp("outgoing_date"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return products;
    }
}
