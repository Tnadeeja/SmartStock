package com.smartstock.service;

import com.smartstock.dao.StockDAO;
import com.smartstock.model.Product;
import com.smartstock.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {

    private StockDAO stockDAO = new StockDAO();

    public boolean createProduct(Product product) {
        String query = "INSERT INTO product (product_name, category_name, unit_price, sale_price) VALUES (?, ?, ?, ?)";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getCategoryName());
            stmt.setDouble(3, product.getUnitPrice());
            stmt.setDouble(4, product.getSalePrice());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Product getProduct(int id) {
        String query = "SELECT * FROM product WHERE product_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryName(rs.getString("category_name"));
                product.setUnitPrice(rs.getDouble("unit_price"));
                product.setSalePrice(rs.getDouble("sale_price"));

                product.setStockQuantity(stockDAO.getCurrentStockQuantity(product.getProductName()));
                product.setStockValue(stockDAO.getCurrentStockValue(product.getProductName()));

                return product;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String query = "SELECT * FROM product";
        try (Connection connection = DBConnection.getConnection();
             Statement stmt = connection.createStatement()) {
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                Product product = new Product();
                product.setProductId(rs.getInt("product_id"));
                product.setProductName(rs.getString("product_name"));
                product.setCategoryName(rs.getString("category_name"));
                product.setUnitPrice(rs.getDouble("unit_price"));
                product.setSalePrice(rs.getDouble("sale_price"));

                product.setStockQuantity(stockDAO.getCurrentStockQuantity(product.getProductName()));
                product.setStockValue(stockDAO.getCurrentStockValue(product.getProductName()));

                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean updateProduct(Product product) {
        String query = "UPDATE product SET product_name = ?, category_name = ?, unit_price = ?, sale_price = ? WHERE product_id = ?";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, product.getProductName());
            stmt.setString(2, product.getCategoryName());
            stmt.setDouble(3, product.getUnitPrice());
            stmt.setDouble(4, product.getSalePrice());
            stmt.setInt(5, product.getProductId());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteProduct(int id) {
        String query = "DELETE FROM product WHERE product_id = ?";
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