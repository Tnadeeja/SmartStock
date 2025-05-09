package com.smartstock.servlet;

import com.smartstock.model.Customer;
import com.smartstock.service.CustomerService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/customer")
public class CustomerServlet extends HttpServlet {

    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Customer customer = customerService.getCustomer(id);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/admin/customerForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = customerService.deleteCustomer(id);

                if (deleted) {
                    session.setAttribute("message", "Customer deleted successfully!");
                    session.setAttribute("status", "success-delete");
                } else {
                    session.setAttribute("message", "Failed to delete customer.");
                    session.setAttribute("status", "error");
                }

                response.sendRedirect("customer");

            } else if ("add".equals(action)) {
                request.getRequestDispatcher("/admin/customerForm.jsp").forward(request, response);

            } else {
                List<Customer> customerList = customerService.getAllCustomers();
                request.setAttribute("customerList", customerList);
                request.getRequestDispatcher("/admin/customer.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        try {
            int customerId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            Customer customer = new Customer();
            customer.customerId = customerId;
            customer.name = name;
            customer.email = email;
            customer.phone = phone;
            customer.address = address;

            boolean success;
            if (customerId > 0) {
                success = customerService.updateCustomer(customer);
                if (success) {
                    session.setAttribute("message", "Customer updated successfully!");
                    session.setAttribute("status", "success-update");
                } else {
                    session.setAttribute("message", "Failed to update customer.");
                    session.setAttribute("status", "error");
                }
            } else {
                success = customerService.createCustomer(customer);
                if (success) {
                    session.setAttribute("message", "Customer added successfully!");
                    session.setAttribute("status", "success-add");
                } else {
                    session.setAttribute("message", "Failed to add customer.");
                    session.setAttribute("status", "error");
                }
            }

            response.sendRedirect("customer");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please check the form.");
            request.getRequestDispatcher("/admin/customerForm.jsp").forward(request, response);
        }
    }
}
