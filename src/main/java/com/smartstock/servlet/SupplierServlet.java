package com.smartstock.servlet;

import com.smartstock.model.Supplier;
import com.smartstock.service.SupplierService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/supplier")
public class SupplierServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private final SupplierService supplierService = new SupplierService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Supplier supplier = supplierService.getSupplier(id);
                request.setAttribute("supplier", supplier);
                request.getRequestDispatcher("/admin/supplierForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = supplierService.deleteSupplier(id);

                if (deleted) {
                    session.setAttribute("message", "Supplier deleted successfully!");
                    session.setAttribute("status", "success-delete");
                } else {
                    session.setAttribute("message", "Failed to delete supplier.");
                    session.setAttribute("status", "error");
                }

                response.sendRedirect("supplier");

            } else if ("add".equals(action)) {
                request.getRequestDispatcher("/admin/supplierForm.jsp").forward(request, response);

            } else {
                String nameFilter = request.getParameter("search");
                String addressFilter = request.getParameter("address");

                List<Supplier> supplierList = supplierService.searchSuppliers(nameFilter, addressFilter);
                List<String> addressList = supplierService.getAllAddresses();

                request.setAttribute("supplierList", supplierList);
                request.setAttribute("addressList", addressList);
                request.setAttribute("selectedName", nameFilter);
                request.setAttribute("selectedAddress", addressFilter);

                request.getRequestDispatcher("/admin/supplier.jsp").forward(request, response);
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
            int supplierId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            Supplier supplier = new Supplier();
            supplier.setSupplierId(supplierId);
            supplier.setName(name);
            supplier.setEmail(email);
            supplier.setPhone(phone);
            supplier.setAddress(address);

            boolean success;
            if (supplierId > 0) {
                success = supplierService.updateSupplier(supplier);
                if (success) {
                    session.setAttribute("message", "Supplier updated successfully!");
                    session.setAttribute("status", "success-update");
                } else {
                    session.setAttribute("message", "Failed to update supplier.");
                    session.setAttribute("status", "error");
                }
            } else {
                success = supplierService.createSupplier(supplier);
                if (success) {
                    session.setAttribute("message", "Supplier added successfully!");
                    session.setAttribute("status", "success-add");
                } else {
                    session.setAttribute("message", "Failed to add supplier.");
                    session.setAttribute("status", "error");
                }
            }

            response.sendRedirect("supplier");

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Invalid input. Please check the form.");
            request.getRequestDispatcher("/admin/supplierForm.jsp").forward(request, response);
        }
    }
}