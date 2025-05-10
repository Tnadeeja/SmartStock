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
            // Handling 'add' action: Display an empty form
            if ("add".equals(action)) {
                // Ensure that the user attribute is an empty object with only email and password fields pre-filled
                SystemUser user = new SystemUser();
                user.setEmail(""); // Default empty email for new user
                user.setPassword(""); // Default empty password for new user
                request.setAttribute("user", user); // Set the empty user for the form
                request.getRequestDispatcher("/admin/systemUserForm.jsp").forward(request, response);

            } 
            // Handling 'edit' action: Fetch user details for editing
            else if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                SystemUser user = userService.getUser(id);  // Retrieve the user by ID
                request.setAttribute("user", user);  // Set user in request for editing
                request.getRequestDispatcher("/admin/systemUserForm.jsp").forward(request, response);

            } 
            // Handling 'delete' action: Delete a user by ID
            else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                userService.deleteUser(id);  // Delete user by ID
                response.sendRedirect("systemUser");  // Redirect to user listing page

            } 
            // Default case: Display the list of all users
            else {
                List<SystemUser> users = userService.getAllUsers();  // Get all users
                request.setAttribute("userList", users);  // Set users in request for display
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
            // Extract form data
            int userId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id")) : 0;

            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String filename = request.getParameter("filename") != null ? request.getParameter("filename") : "default.png";
            String role = request.getParameter("role");

            // Validate the form fields (optional but recommended)
            if (name == null || email == null || password == null || role == null) {
                request.setAttribute("error", "Please fill all fields correctly.");
                request.getRequestDispatcher("/admin/systemUserForm.jsp").forward(request, response);
                return;
            }

            // Create SystemUser object and set values
            SystemUser user = new SystemUser();
            user.setUserId(userId);
            user.setName(name);
            user.setPhone(phone);
            user.setAddress(address);
            user.setEmail(email);
            user.setPassword(password);
            user.setFilename(filename);
            user.setRole(role);

            // Check if userId > 0 (Edit existing user), else create new user
            if (userId > 0) {
                userService.updateUser(user);  // Update user if it's an edit
            } else {
                userService.createUser(user);  // Create new user
            }

            // Redirect to user list after add/edit
            response.sendRedirect("systemUser");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error occurred while processing the data. Please try again.");
            request.getRequestDispatcher("/admin/systemUserForm.jsp").forward(request, response);
        }
    }
}