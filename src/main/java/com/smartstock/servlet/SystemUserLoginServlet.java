package com.smartstock.servlet;

import com.smartstock.model.SystemUser;
import com.smartstock.service.SystemUserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/login")
public class SystemUserLoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private final SystemUserService userService = new SystemUserService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null) email = "";
        if (password == null) password = "";
        email = email.trim();
        password = password.trim();

        if (email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email and password must not be empty.");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
            return;
        }

        SystemUser user = authenticateUser(email, password);

        if (user != null) {
            HttpSession session = request.getSession(true);
            session.setAttribute("user", user);
            session.setAttribute("name", user.getName());  // Use the name in the sidebar
            session.setAttribute("email", user.getEmail());
            session.setAttribute("role", user.getRole());
            session.setAttribute("filename", user.getFilename());  // For profile picture
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            redirectByRole(response, request.getContextPath(), user.getRole());
        } else {
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }

    private void redirectByRole(HttpServletResponse response, String contextPath, String role) throws IOException {
        switch (role.toLowerCase()) {
            case "admin":
                response.sendRedirect(contextPath + "/admin/dashboard.jsp");
                break;
            case "stock manager":
                response.sendRedirect(contextPath + "/admin/dashboard.jsp");
                break;
            case "sales manager":
                response.sendRedirect(contextPath + "/admin/dashboard.jsp");
                break;
            default:
                response.sendRedirect(contextPath + "/admin/unauthorized.jsp");
        }
    }

    private SystemUser authenticateUser(String email, String password) {
        List<SystemUser> users = userService.getAllUsers();
        for (SystemUser user : users) {
            if (user.getEmail().equalsIgnoreCase(email) && user.getPassword().equals(password)) {
                return user;
            }
        }
        return null;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("user") != null) {
            SystemUser user = (SystemUser) session.getAttribute("user");
            redirectByRole(response, request.getContextPath(), user.getRole());
        } else {
            request.getRequestDispatcher("/admin/login.jsp").forward(request, response);
        }
    }
}
