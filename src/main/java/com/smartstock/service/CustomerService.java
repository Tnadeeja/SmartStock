package com.smartstock.service;

import com.smartstock.model.Customer;
import com.smartstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CustomerService {

    // Create Customer
    public boolean createCustomer(Customer customer) {
        String query = "INSERT INTO customer (name, email, phone, address) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getAddress());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Customer by ID
    public Customer getCustomer(int id) {
        String query = "SELECT * FROM customer WHERE customer_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                return customer;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Customers
    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String query = "SELECT * FROM customer";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Get filtered Customers by name and address
    public List<Customer> getFilteredCustomers(String nameSearch, String addressFilter) {
        List<Customer> customers = new ArrayList<>();
        StringBuilder query = new StringBuilder("SELECT * FROM customer WHERE 1=1 ");
        List<Object> params = new ArrayList<>();

        if (nameSearch != null && !nameSearch.trim().isEmpty()) {
            query.append("AND name LIKE ? ");
            params.add("%" + nameSearch.trim() + "%");
        }

        if (addressFilter != null && !addressFilter.trim().isEmpty()) {
            query.append("AND address = ? ");
            params.add(addressFilter.trim());
        }

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query.toString())) {

            for (int i = 0; i < params.size(); i++) {
                stmt.setObject(i + 1, params.get(i));
            }

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setName(rs.getString("name"));
                customer.setEmail(rs.getString("email"));
                customer.setPhone(rs.getString("phone"));
                customer.setAddress(rs.getString("address"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Get all distinct addresses
    public List<String> getAllAddresses() {
        List<String> addresses = new ArrayList<>();
        String query = "SELECT DISTINCT address FROM customer ORDER BY address";
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

    // Update Customer
    public boolean updateCustomer(Customer customer) {
        String query = "UPDATE customer SET name = ?, email = ?, phone = ?, address = ? WHERE customer_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, customer.getName());
            stmt.setString(2, customer.getEmail());
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getAddress());
            stmt.setInt(5, customer.getCustomerId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Customer
    public boolean deleteCustomer(int id) {
        String query = "DELETE FROM customer WHERE customer_id = ?";
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
