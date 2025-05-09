package com.smartstock.service;

import com.smartstock.model.AlertModel;
import com.smartstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AlertService {

    public List<AlertModel> getRecentSupportRequests() {
        List<AlertModel> list = new ArrayList<>();

        String sql = "SELECT * FROM support_requests WHERE submitted_at >= NOW() - INTERVAL 1 DAY ORDER BY submitted_at DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                AlertModel req = new AlertModel();
                req.setRequestId(rs.getInt("request_id"));
                req.setName(rs.getString("name"));
                req.setPost(rs.getString("post"));
                req.setEmail(rs.getString("email"));
                req.setDescription(rs.getString("description"));
                req.setSubmittedAt(rs.getTimestamp("submitted_at").toLocalDateTime());
                list.add(req);
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Consider logging this instead
        }

        return list;
    }
}