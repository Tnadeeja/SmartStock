package com.smartstock.servlet;

import com.smartstock.model.SupportRequest;
import com.smartstock.service.SupportService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * 
 */
@WebServlet("/admin/supportHandler")
public class SupportHandler extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private static final String DEFAULT_EMERGENCY_PHONE = "(123) 456-7890";
    private static final String DEFAULT_HOTLINE = "(987) 654-3210";
    private static final String DEFAULT_SUPPORT_EMAIL = "support@example.com";

    private final SupportService supportService = new SupportService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String emergencyPhone = (String) session.getAttribute("emergencyPhone");
        if (emergencyPhone == null) emergencyPhone = DEFAULT_EMERGENCY_PHONE;

        String hotline = (String) session.getAttribute("hotline");
        if (hotline == null) hotline = DEFAULT_HOTLINE;

        String supportEmail = (String) session.getAttribute("supportEmail");
        if (supportEmail == null) supportEmail = DEFAULT_SUPPORT_EMAIL;

        String message = (String) session.getAttribute("message");
        session.removeAttribute("message");

        request.setAttribute("emergencyPhone", emergencyPhone);
        request.setAttribute("hotline", hotline);
        request.setAttribute("supportEmail", supportEmail);
        request.setAttribute("message", message);

        request.getRequestDispatcher("/admin/supportForm.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        if ("updateContact".equals(action)) {
            session.setAttribute("emergencyPhone", request.getParameter("emergencyPhone"));
            session.setAttribute("hotline", request.getParameter("hotline"));
            session.setAttribute("supportEmail", request.getParameter("supportEmail"));
            session.setAttribute("message", "Contact information updated successfully.");

        } else if ("submitForm".equals(action)) {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String description = request.getParameter("description");

            System.out.println("Support Request Received:");
            System.out.println("Name: " + name);
            System.out.println("Email: " + email);
            System.out.println("Description: " + description);

            session.setAttribute("message", "Thank you for your submission. Our team will contact you soon.");

        } else if ("submitSupportRequest".equals(action)) {
            String name = request.getParameter("name");
            String post = request.getParameter("post");
            String email = request.getParameter("email");
            String description = request.getParameter("description");

            SupportRequest supportRequest = new SupportRequest(name, post, email, description);
            boolean success = supportService.saveSupportRequest(supportRequest);

            if (success) {
                session.setAttribute("message", "Support request submitted successfully.");
            } else {
                session.setAttribute("message", "Failed to submit support request.");
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/supportHandler");
    }
}
