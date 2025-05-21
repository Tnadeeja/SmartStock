package com.smartstock.service;

import com.smartstock.model.Supplier;
import com.smartstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class SupplierService {

    // Create Supplier
    public boolean createSupplier(Supplier supplier) {
        String query = "INSERT INTO supplier (name, email, phone, address) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, supplier.getName());
            stmt.setString(2, supplier.getEmail());
            stmt.setString(3, supplier.getPhone());
            stmt.setString(4, supplier.getAddress());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Supplier by ID
    public Supplier getSupplier(int id) {
        String query = "SELECT * FROM supplier WHERE supplier_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierId(rs.getInt("supplier_id"));
                supplier.setName(rs.getString("name"));
                supplier.setEmail(rs.getString("email"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setAddress(rs.getString("address"));
                supplier.setCreatedAt(rs.getTimestamp("created_at"));
                return supplier;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Suppliers
    public List<Supplier> getAllSuppliers() {
        List<Supplier> suppliers = new ArrayList<>();
        String query = "SELECT * FROM supplier";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierId(rs.getInt("supplier_id"));
                supplier.setName(rs.getString("name"));
                supplier.setEmail(rs.getString("email"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setAddress(rs.getString("address"));
                supplier.setCreatedAt(rs.getTimestamp("created_at"));
                suppliers.add(supplier);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return suppliers;
    }

    // Update Supplier
    public boolean updateSupplier(Supplier supplier) {
        String query = "UPDATE supplier SET name = ?, email = ?, phone = ?, address = ? WHERE supplier_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, supplier.getName());
            stmt.setString(2, supplier.getEmail());
            stmt.setString(3, supplier.getPhone());
            stmt.setString(4, supplier.getAddress());
            stmt.setInt(5, supplier.getSupplierId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Supplier
    public boolean deleteSupplier(int id) {
        String query = "DELETE FROM supplier WHERE supplier_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Search Suppliers by name and address
    public List<Supplier> searchSuppliers(String nameFilter, String addressFilter) {
        List<Supplier> suppliers = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM supplier WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (nameFilter != null && !nameFilter.trim().isEmpty()) {
            query.append(" AND name LIKE ?");
            params.add("%" + nameFilter.trim() + "%");
        }

        if (addressFilter != null && !addressFilter.trim().isEmpty()) {
            query.append(" AND address = ?");
            params.add(addressFilter.trim());
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Supplier supplier = new Supplier();
                supplier.setSupplierId(rs.getInt("supplier_id"));
                supplier.setName(rs.getString("name"));
                supplier.setEmail(rs.getString("email"));
                supplier.setPhone(rs.getString("phone"));
                supplier.setAddress(rs.getString("address"));
                supplier.setCreatedAt(rs.getTimestamp("created_at"));
                suppliers.add(supplier);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return suppliers;
    }

    // Get all distinct addresses
    public List<String> getAllAddresses() {
        List<String> addresses = new ArrayList<>();
        String query = "SELECT DISTINCT address FROM supplier ORDER BY address";

        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                addresses.add(rs.getString("address"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return addresses;
    }
}