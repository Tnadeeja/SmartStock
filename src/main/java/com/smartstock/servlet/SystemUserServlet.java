package com.smartstock.servlet;

import com.smartstock.model.SystemUser;
import com.smartstock.service.SystemUserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/systemUser")
public class SystemUserServlet extends HttpServlet {

    private SystemUserService userService = new SystemUserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                request.setAttribute("user", null);
                request.getRequestDispatcher("/admin/systemUserForm.jsp").forward(request, response);

            } else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                SystemUser user = userService.getUser(id);
                request.setAttribute("user", user);
                request.getRequestDispatcher("/admin/systemUserForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                userService.deleteUser(id);
                response.sendRedirect("systemUser");

            } else {
                List<SystemUser> users = userService.getAllUsers();
                request.setAttribute("userList", users);
                request.getRequestDispatcher("/admin/systemUser.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int userId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id")) : 0;

            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String filename = request.getParameter("filename") != null ? request.getParameter("filename") : "default.png";
            String role = request.getParameter("role");

            SystemUser user = new SystemUser();
            user.setUserId(userId);
            user.setName(name);
            user.setPhone(phone);
            user.setAddress(address);
            user.setEmail(email);
            user.setPassword(password);
            user.setFilename(filename);
            user.setRole(role);

            if (userId > 0) {
                userService.updateUser(user);
            } else {
                userService.createUser(user);
            }

            response.sendRedirect("systemUser");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Please fill all fields correctly.");
            request.getRequestDispatcher("/admin/systemUserForm.jsp").forward(request, response);
        }
    }
}
