package com.smartstock.service;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import com.smartstock.model.SupportRequest;
import com.smartstock.util.DBConnection;

public class SupportService {

    // Save support request
    public boolean saveSupportRequest(SupportRequest request) {
        String sql = "INSERT INTO support_requests (name, post, email, description) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, request.getName());
            stmt.setString(2, request.getPost());
            stmt.setString(3, request.getEmail());
            stmt.setString(4, request.getDescription());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ✅ Fetch all support requests
    public List<SupportRequest> getAllSupportRequests() {
        List<SupportRequest> supportRequests = new ArrayList<>();
        String sql = "SELECT * FROM support_requests ORDER BY created_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                SupportRequest request = new SupportRequest();
                request.setId(rs.getInt("id"));
                request.setName(rs.getString("name"));
                request.setPost(rs.getString("post"));
                request.setEmail(rs.getString("email"));
                request.setDescription(rs.getString("description"));
                request.setCreatedAt(rs.getTimestamp("created_at"));
                supportRequests.add(request);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return supportRequests;
    }
}