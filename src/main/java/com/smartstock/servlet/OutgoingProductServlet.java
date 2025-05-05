package com.smartstock.servlet;

import com.smartstock.model.OutgoingProduct;
import com.smartstock.service.OutgoingProductService;

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

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                OutgoingProduct product = productService.getOutgoingProduct(id);
                request.setAttribute("product", product);
                request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                productService.deleteOutgoingProduct(id);
                response.sendRedirect("outgoing");

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

        try {
            // Parse ID for update case
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

            if (outgoingId > 0) {
                productService.updateOutgoingProduct(product);
            } else {
                productService.createOutgoingProduct(product);
            }

            response.sendRedirect("outgoing");

        } catch (Exception e) {
            System.err.println("Error in OutgoingProductServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input or missing fields.");
        }
    }
}
