package com.smartstock.servlet;

import com.smartstock.model.OutgoingProduct;
import com.smartstock.model.ReturnProduct;
import com.smartstock.service.OutgoingProductService;
import com.smartstock.service.ReturnProductService;
import com.smartstock.model.Category;
import com.smartstock.service.CategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/outgoing")
public class OutgoingProductServlet extends HttpServlet {

    private OutgoingProductService productService = new OutgoingProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                OutgoingProduct product = productService.getOutgoingProduct(id);

                // ✅ Set category list BEFORE forwarding
                List<Category> categoryList = new CategoryService().getAllcategory();

                request.setAttribute("product", product);
                request.setAttribute("categoryList", categoryList);

                request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                OutgoingProduct outgoingProduct = productService.getOutgoingProduct(id);

                // Delete the outgoing product
                boolean deleted = productService.deleteOutgoingProduct(id);

                // Handle success/failure message after delete
                if (deleted) {
                    session.setAttribute("message", "Item deleted successfully!");
                    session.setAttribute("status", "success-delete");
                } else {
                    session.setAttribute("message", "Failed to delete item.");
                    session.setAttribute("status", "error");
                }

                // Return product handling
                if (outgoingProduct != null) {
                    ReturnProduct returnProduct = new ReturnProduct();
                    returnProduct.productName = outgoingProduct.productName;
                    returnProduct.quantity = outgoingProduct.quantity;
                    returnProduct.returnDate = new Date(); // current timestamp
                    returnProduct.reason = ""; // leave empty for now

                    ReturnProductService returnService = new ReturnProductService();
                    returnService.createReturnProduct(returnProduct);
                }

                response.sendRedirect("outgoing");

            } else if ("add".equals(action)) {
                // Load empty form with category list
                List<Category> categoryList = new CategoryService().getAllcategory();
                request.setAttribute("categoryList", categoryList);
                request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);

            } else {
                List<OutgoingProduct> outgoingList = productService.getAllOutgoingProducts();
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
            int outgoingId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String productName = request.getParameter("productName");
            String categoryName = request.getParameter("categoryId");
            String customerName = request.getParameter("supplierId");

            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double salePrice = Double.parseDouble(request.getParameter("unitPrice"));
            double totalAmount = Double.parseDouble(request.getParameter("totalPrice"));

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

            if (request.getParameter("purchaseDate") != null && !request.getParameter("purchaseDate").isEmpty()) {
                outgoingDate = formatter.parse(request.getParameter("purchaseDate"));
            }

            OutgoingProduct product = new OutgoingProduct();
            product.outgoingId = outgoingId;
            product.productName = productName;
            product.categoryName = categoryName;
            product.customerName = customerName;
            product.quantity = quantity;
            product.salePrice = salePrice;
            product.totalAmount = totalAmount;
            product.manufactureDate = manufactureDate;
            product.expireDate = expireDate;
            product.outgoingDate = outgoingDate;

            boolean success;
            if (outgoingId > 0) {
                success = productService.updateOutgoingProduct(product);
                if (success) {
                    session.setAttribute("message", "Item updated successfully!");
                    session.setAttribute("status", "success-update");
                } else {
                    session.setAttribute("message", "Failed to update item.");
                    session.setAttribute("status", "error");
                }
            } else {
                success = productService.createOutgoingProduct(product);
                if (success) {
                    session.setAttribute("message", "Item added successfully!");
                    session.setAttribute("status", "success-add");
                } else {
                    session.setAttribute("message", "Failed to add item.");
                    session.setAttribute("status", "error");
                }
            }

            // Redirect to the "outgoing" page after add or update
            response.sendRedirect("outgoing");

        } catch (Exception e) {
            e.printStackTrace();

            List<Category> categoryList = new CategoryService().getAllcategory();
            request.setAttribute("categoryList", categoryList);
            request.setAttribute("error", "Invalid input or missing fields. Please check your form.");
            request.setAttribute("product", request);  // optionally set previous form data

            request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);
        }
    }
}