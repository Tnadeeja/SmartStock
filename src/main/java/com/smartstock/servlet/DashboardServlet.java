package com.smartstock.servlet;

import com.smartstock.util.DBConnection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet("/admin/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(DashboardServlet.class.getName());

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try (Connection conn = DBConnection.getConnection()) {

            // Ensure the connection is not null
            if (conn == null) {
                LOGGER.severe("Database connection failed.");
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database connection failed.");
                return;
            }

            LOGGER.info("Database connection established successfully.");

            // Fetch values from the database (realtime queries)
            int totalCategories = getCount(conn, "SELECT COUNT(*) FROM category");
            int totalProducts = getCount(conn, "SELECT COUNT(*) FROM product");
            int totalCustomers = getCount(conn, "SELECT COUNT(*) FROM customer");
            int totalSuppliers = getCount(conn, "SELECT COUNT(*) FROM supplier");
            int totalUsers = getCount(conn, "SELECT COUNT(*) FROM system_users");
            int totalReturns = getCount(conn, "SELECT COUNT(*) FROM return_product");

            // Fetch stock-related data (realtime calculation)
            int currentStock = getSum(conn, "SELECT SUM(quantity) FROM purchase_product");
            int outgoingStock = getSum(conn, "SELECT SUM(quantity) FROM outgoing_product");
            int stockAvailable = currentStock - outgoingStock;

            // Log stock values for debugging
            LOGGER.info("Current stock (purchased): " + currentStock);
            LOGGER.info("Outgoing stock (sold): " + outgoingStock);
            LOGGER.info("Stock available: " + stockAvailable);

            // Fetch sales and profit data
            double totalSales = getDecimalSum(conn, "SELECT SUM(total_amount) FROM outgoing_product");
            double totalCost = getDecimalSum(conn, "SELECT SUM(total_amount) FROM purchase_product");
            double profit = totalSales - totalCost;
            double profitMargin = (totalSales != 0) ? (profit / totalSales) * 100 : 0;

            // Get the most outgoing product
            String mostOutgoingProduct = getMostOutgoingProduct(conn);

            // Log sales data
            LOGGER.info("Total sales: " + totalSales);
            LOGGER.info("Total cost: " + totalCost);
            LOGGER.info("Profit: " + profit);
            LOGGER.info("Profit margin: " + profitMargin);
            LOGGER.info("Most outgoing product: " + mostOutgoingProduct);

            // Set values as request attributes for JSP to render them dynamically
            request.setAttribute("totalCategories", totalCategories);
            request.setAttribute("totalProducts", totalProducts);
            request.setAttribute("totalCustomers", totalCustomers);
            request.setAttribute("totalSuppliers", totalSuppliers);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("currentReturns", totalReturns);
            request.setAttribute("currentStock", stockAvailable);
            request.setAttribute("totalSales", totalSales);
            request.setAttribute("totalCost", totalCost);
            request.setAttribute("totalProfit", profit);
            request.setAttribute("profitMargin", profitMargin);
            request.setAttribute("mostOutgoingProduct", mostOutgoingProduct);

            // Forward the request to the JSP page
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error fetching dashboard data", e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while fetching dashboard data.");
        }
    }

    private int getCount(Connection conn, String sql) throws SQLException {
        LOGGER.info("Executing SQL query: " + sql);
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                int count = rs.getInt(1);
                LOGGER.info("Query result: " + count);
                return count;
            }
        }
        return 0;
    }

    private int getSum(Connection conn, String sql) throws SQLException {
        LOGGER.info("Executing SQL query: " + sql);
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                int sum = rs.getInt(1);
                LOGGER.info("Query result: " + sum);
                return sum;
            }
        }
        return 0;
    }

    private double getDecimalSum(Connection conn, String sql) throws SQLException {
        LOGGER.info("Executing SQL query: " + sql);
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                double sum = rs.getDouble(1);
                LOGGER.info("Query result: " + sum);
                return sum;
            }
        }
        return 0.0;
    }

    private String getMostOutgoingProduct(Connection conn) throws SQLException {
        String sql = "SELECT product_name, SUM(quantity) AS total FROM outgoing_product GROUP BY product_name ORDER BY total DESC LIMIT 1";
        LOGGER.info("Executing SQL query: " + sql);
        try (PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                String result = rs.getString("product_name") + " (" + rs.getInt("total") + " units)";
                LOGGER.info("Most outgoing product: " + result);
                return result;
            } else {
                return "N/A";
            }
        }
    }
}