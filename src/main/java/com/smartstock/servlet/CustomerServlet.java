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
	private static final long serialVersionUID = 1L;
	
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("edit".equals(action)) {
                String idParam = request.getParameter("id");
                int id = 0;
                try {
                    id = Integer.parseInt(idParam);
                } catch (NumberFormatException e) {
                    session.setAttribute("message", "Invalid Customer ID.");
                    session.setAttribute("status", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/customer");
                    return;
                }

                Customer customer = customerService.getCustomer(id);
                if (customer == null) {
                    session.setAttribute("message", "Customer not found.");
                    session.setAttribute("status", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/customer");
                    return;
                }

                request.setAttribute("customer", customer);
                request.getRequestDispatcher("/admin/customerForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                String idParam = request.getParameter("id");
                int id = 0;
                try {
                    id = Integer.parseInt(idParam);
                } catch (NumberFormatException e) {
                    session.setAttribute("message", "Invalid Customer ID.");
                    session.setAttribute("status", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/customer");
                    return;
                }

                boolean deleted = customerService.deleteCustomer(id);

                if (deleted) {
                    session.setAttribute("message", "Customer deleted successfully!");
                    session.setAttribute("status", "success-delete");
                } else {
                    session.setAttribute("message", "Failed to delete customer.");
                    session.setAttribute("status", "error");
                }

                response.sendRedirect(request.getContextPath() + "/admin/customer");

            } else if ("add".equals(action)) {
                // For new customer form, clear any existing customer attribute
                request.removeAttribute("customer");
                request.getRequestDispatcher("/admin/customerForm.jsp").forward(request, response);

            } else {
                // Default: list customers, possibly with filters
                String searchName = request.getParameter("searchName");
                String filterAddress = request.getParameter("filterAddress");

                List<Customer> customerList;

                if ((searchName != null && !searchName.trim().isEmpty()) ||
                    (filterAddress != null && !filterAddress.trim().isEmpty())) {
                    customerList = customerService.getFilteredCustomers(searchName, filterAddress);
                } else {
                    customerList = customerService.getAllCustomers();
                }

                List<String> addressList = customerService.getAllAddresses();

                request.setAttribute("customerList", customerList);
                request.setAttribute("addressList", addressList);
                request.setAttribute("searchName", searchName);
                request.setAttribute("filterAddress", filterAddress);

                request.getRequestDispatcher("/admin/customer.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An internal error occurred.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        try {
            String idParam = request.getParameter("id");
            int customerId = 0;
            if (idParam != null && !idParam.isEmpty()) {
                try {
                    customerId = Integer.parseInt(idParam);
                } catch (NumberFormatException e) {
                    session.setAttribute("message", "Invalid Customer ID.");
                    session.setAttribute("status", "error");
                    response.sendRedirect(request.getContextPath() + "/admin/customer");
                    return;
                }
            }

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            // Simple validation example, you can extend
            if (name == null || name.trim().isEmpty()) {
                request.setAttribute("error", "Name is required.");
                request.getRequestDispatcher("/admin/customerForm.jsp").forward(request, response);
                return;
            }

            Customer customer = new Customer();
            customer.setCustomerId(customerId);
            customer.setName(name);
            customer.setEmail(email);
            customer.setPhone(phone);
            customer.setAddress(address);

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

            response.sendRedirect(request.getContextPath() + "/admin/customer");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please check the form.");
            request.getRequestDispatcher("/admin/customerForm.jsp").forward(request, response);
        }
    }
}
