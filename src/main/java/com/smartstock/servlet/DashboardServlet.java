package com.smartstock.servlet;

import com.smartstock.service.DashboardService;
import com.smartstock.model.DashboardData;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/dashboard")
public class DashboardServlet extends HttpServlet {
    private DashboardService dashboardService;

    @Override
    public void init() throws ServletException {
        super.init();
        dashboardService = new DashboardService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get user role from the session
        String role = (String) request.getSession().getAttribute("role");

        // Allow access only for specific roles
        if (role == null || 
           !(role.equalsIgnoreCase("admin") || 
             role.equalsIgnoreCase("stock manager") || 
             role.equalsIgnoreCase("sales manager"))) {
            response.sendRedirect(request.getContextPath() + "/admin/unauthorized.jsp");
            return;
        }

        // Fetch the dashboard data
        DashboardData dashboardData = dashboardService.getDashboardData();

        // Set the data to request
        request.setAttribute("dashboardData", dashboardData);

        // Forward to JSP
        request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
    }
}