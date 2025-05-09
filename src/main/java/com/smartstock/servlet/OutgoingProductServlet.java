package com.smartstock.servlet;

import com.smartstock.model.Customer;
import com.smartstock.model.ReturnProduct;
import com.smartstock.model.Category;
import com.smartstock.model.Product;
import com.smartstock.model.OutgoingProduct;
import com.smartstock.service.OutgoingProductService;
import com.smartstock.service.ProductService;
import com.smartstock.service.CategoryService;
import com.smartstock.service.CustomerService;
import com.smartstock.service.ReturnProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/outgoing")
public class OutgoingProductServlet extends HttpServlet {

    private OutgoingProductService outgoingProductService = new OutgoingProductService(); // ✅ for outgoing product
    private ProductService productService = new ProductService(); // ✅ for loading product list
    private CustomerService customerService = new CustomerService(); // ✅ for loading customer list

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                OutgoingProduct product = outgoingProductService.getOutgoingProduct(id);

                // Load necessary data
                List<Category> categoryList = new CategoryService().getAllcategory();
                List<Product> productList = productService.getAllProducts();
                List<Customer> customerList = customerService.getAllCustomers(); // Get customers for dropdown

                // Set attributes for the JSP
                request.setAttribute("product", product);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("productList", productList);
                request.setAttribute("customerList", customerList); // Pass customer list for dropdown

                request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                // Handle deletion
                OutgoingProduct outgoingProduct = outgoingProductService.getOutgoingProduct(id);
                boolean deleted = outgoingProductService.deleteOutgoingProduct(id);

                if (deleted) {
                    session.setAttribute("message", "Item deleted successfully!");
                    session.setAttribute("status", "success-delete");
                } else {
                    session.setAttribute("message", "Failed to delete item.");
                    session.setAttribute("status", "error");
                }

                // Handling the return product logic
                if (outgoingProduct != null) {
                    ReturnProduct returnProduct = new ReturnProduct();
                    returnProduct.productName = outgoingProduct.productName;
                    returnProduct.quantity = outgoingProduct.quantity;
                    returnProduct.returnDate = new Date();
                    returnProduct.reason = "";

                    ReturnProductService returnService = new ReturnProductService();
                    returnService.createReturnProduct(returnProduct);
                }

                response.sendRedirect("outgoing");

            } else if ("add".equals(action)) {
                // Load necessary data for add page
                List<Category> categoryList = new CategoryService().getAllcategory();
                List<Product> productList = productService.getAllProducts();
                List<Customer> customerList = customerService.getAllCustomers(); // Get customers for dropdown

                // Set attributes for the JSP
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("productList", productList);
                request.setAttribute("customerList", customerList); // Pass customer list for dropdown

                request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);

            } else {
                // Load the list of outgoing products
                List<OutgoingProduct> outgoingList = outgoingProductService.getAllOutgoingProducts();
                request.setAttribute("outgoingList", outgoingList);
                request.getRequestDispatcher("/admin/outgoing.jsp").forward(request, response);
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
            // Parse incoming form data
            int outgoingId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String productName = request.getParameter("productName");
            String categoryName = request.getParameter("categoryId");
            String customerName = request.getParameter("supplierId"); // The customer ID from the dropdown

            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double salePrice = Double.parseDouble(request.getParameter("unitPrice"));
            double totalAmount = Double.parseDouble(request.getParameter("totalPrice"));

            // Parse date fields
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

            Date manufactureDate = null;
            Date expireDate = null;
            Date outgoingDate = null;

            if (request.getParameter("manufactureDate") != null && !request.getParameter("manufactureDate").isEmpty()) {
                manufactureDate = formatter.parse(request.getParameter("manufactureDate"));
            }

            if (request.getParameter("expireDate") != null && !request.getParameter("expireDate").isEmpty()) {
                expireDate = formatter.parse(request.getParameter("expireDate"));
            }

            if (request.getParameter("outgoingDate") != null && !request.getParameter("outgoingDate").isEmpty()) {
                outgoingDate = formatter.parse(request.getParameter("outgoingDate"));
            }

            // Create the outgoing product object
            OutgoingProduct product = new OutgoingProduct();
            product.outgoingId = outgoingId;
            product.productName = productName;
            product.categoryName = categoryName;
            product.customerName = customerName; // Set the selected customer name
            product.quantity = quantity;
            product.salePrice = salePrice;
            product.totalAmount = totalAmount;
            product.manufactureDate = manufactureDate;
            product.expireDate = expireDate;
            product.outgoingDate = outgoingDate;

            // Handle create or update
            boolean success;
            if (outgoingId > 0) {
                success = outgoingProductService.updateOutgoingProduct(product);
                if (success) {
                    session.setAttribute("message", "Item updated successfully!");
                    session.setAttribute("status", "success-update");
                } else {
                    session.setAttribute("message", "Failed to update item.");
                    session.setAttribute("status", "error");
                }
            } else {
                success = outgoingProductService.createOutgoingProduct(product);
                if (success) {
                    session.setAttribute("message", "Item added successfully!");
                    session.setAttribute("status", "success-add");
                } else {
                    session.setAttribute("message", "Failed to add item.");
                    session.setAttribute("status", "error");
                }
            }

            // Redirect after success
            response.sendRedirect("outgoing");

        } catch (Exception e) {
            e.printStackTrace();

            // Reload the page with the necessary data if an error occurs
            List<Category> categoryList = new CategoryService().getAllcategory();
            List<Product> productList = productService.getAllProducts();
            List<Customer> customerList = customerService.getAllCustomers(); // Get customers for dropdown

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("productList", productList);
            request.setAttribute("customerList", customerList); // Pass customer list for dropdown
            request.setAttribute("error", "Invalid input or missing fields. Please check your form.");
            request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);
        }
    }
}
