package com.smartstock.servlet;

import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/admin/supportHandler")
public class SupportHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Handle GET request to show the support form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect to the support form (assuming JSP page is at /admin/supportForm.jsp)
        request.getRequestDispatcher("/admin/supportForm.jsp").forward(request, response);
    }

    // Handle POST request to process the support form
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String description = request.getParameter("description");

        // For now, just print the data for debugging purposes (you can save it to a database or send an email)
        System.out.println("Support Request Received:");
        System.out.println("Name: " + name);
        System.out.println("Email: " + email);
        System.out.println("Description: " + description);

        // Optionally, send a confirmation message to the user
        request.setAttribute("message", "Thank you for your submission. Our team will contact you soon.");
        request.getRequestDispatcher("/admin/supportForm.jsp").forward(request, response); // Redirect back to form
    }
}