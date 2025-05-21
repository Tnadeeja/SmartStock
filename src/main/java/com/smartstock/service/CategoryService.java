package com.smartstock.service;

import com.smartstock.model.Category;
import com.smartstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryService {

    // Create Category
    public boolean createCategory(Category category) {
        String query = "INSERT INTO category (category_name) VALUES (?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, category.categoryName);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Get Category by ID
    public Category getCategory(int id) {
        String query = "SELECT * FROM category WHERE category_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Category category = new Category();
                category.categoryId = rs.getInt("category_id");
                category.categoryName = rs.getString("category_name");
                return category;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Get All Categories
    public List<Category> getAllcategory() {
        List<Category> categoryList = new ArrayList<>();
        String query = "SELECT * FROM category";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Category cat = new Category();
                cat.setCategoryId(rs.getInt("category_id"));
                cat.setCategoryName(rs.getString("category_name"));
                categoryList.add(cat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categoryList;
    }

    // Update Category
    public boolean updateCategory(Category category) {
        String query = "UPDATE category SET category_name = ? WHERE category_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, category.categoryName);
            stmt.setInt(2, category.categoryId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete Category
    public boolean deleteCategory(int id) {
        String query = "DELETE FROM category WHERE category_id = ?";
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
