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
            stmt.setString(1, customer.name);
            stmt.setString(2, customer.email);
            stmt.setString(3, customer.phone);
            stmt.setString(4, customer.address);
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
                customer.customerId = rs.getInt("customer_id");
                customer.name = rs.getString("name");
                customer.email = rs.getString("email");
                customer.phone = rs.getString("phone");
                customer.address = rs.getString("address");
                customer.createdAt = rs.getTimestamp("created_at");
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
                customer.customerId = rs.getInt("customer_id");
                customer.name = rs.getString("name");
                customer.email = rs.getString("email");
                customer.phone = rs.getString("phone");
                customer.address = rs.getString("address");
                customer.createdAt = rs.getTimestamp("created_at");
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    // Update Customer
    public boolean updateCustomer(Customer customer) {
        String query = "UPDATE customer SET name = ?, email = ?, phone = ?, address = ? WHERE customer_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, customer.name);
            stmt.setString(2, customer.email);
            stmt.setString(3, customer.phone);
            stmt.setString(4, customer.address);
            stmt.setInt(5, customer.customerId);
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
