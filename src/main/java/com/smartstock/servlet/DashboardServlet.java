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

    // Check if the user is an admin
    if (role == null || !role.equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/admin/unauthorized.jsp");
        return;
    }

    // Fetch the dashboard data from the service
    DashboardData dashboardData = dashboardService.getDashboardData();

    // Set the dashboard data as a request attribute
    request.setAttribute("dashboardData", dashboardData);

    // Forward the request to the dashboard.jsp
    request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
}

}