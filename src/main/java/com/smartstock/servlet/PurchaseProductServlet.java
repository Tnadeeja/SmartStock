package com.smartstock.servlet;

import com.smartstock.model.PurchaseProduct;
import com.smartstock.service.PurchaseProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/PurchaseDashboard")
public class PurchaseProductServlet extends HttpServlet {

    private PurchaseProductService productService = new PurchaseProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PurchaseProduct product = productService.getPurchaseProduct(id);
                request.setAttribute("product", product);
                request.getRequestDispatcher("/admin/PurchaseForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                productService.deletePurchaseProduct(id);
                response.sendRedirect("PurchaseDashboard");

            } else {
                // Filter parameters
                String search = request.getParameter("search");
                String category = request.getParameter("category");
                String supplier = request.getParameter("supplier");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");

                Date startDate = null;
                Date endDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                if (startDateStr != null && !startDateStr.isEmpty()) {
                    startDate = sdf.parse(startDateStr);
                }
                if (endDateStr != null && !endDateStr.isEmpty()) {
                    endDate = sdf.parse(endDateStr);
                }

                List<PurchaseProduct> purchaseList = productService.getFilteredPurchaseProducts(
                        search, category, supplier, startDate, endDate
                );

                request.setAttribute("purchaseList", purchaseList);
                request.getRequestDispatcher("/admin/PurchaseDashboard.jsp").forward(request, response);
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
            int purchaseId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String productName = request.getParameter("productName");
            String categoryName = request.getParameter("categoryName");
            String supplierName = request.getParameter("supplierName");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
            double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date manufactureDate = null, expireDate = null, purchaseDate = null;

            if (request.getParameter("manufactureDate") != null && !request.getParameter("manufactureDate").isEmpty()) {
                manufactureDate = formatter.parse(request.getParameter("manufactureDate"));
            }
            if (request.getParameter("expireDate") != null && !request.getParameter("expireDate").isEmpty()) {
                expireDate = formatter.parse(request.getParameter("expireDate"));
            }
            if (request.getParameter("purchaseDate") != null && !request.getParameter("purchaseDate").isEmpty()) {
                purchaseDate = formatter.parse(request.getParameter("purchaseDate"));
            }

            PurchaseProduct product = new PurchaseProduct();
            product.setPurchaseId(purchaseId);
            product.setProductName(productName);
            product.setCategoryName(categoryName);
            product.setSupplierName(supplierName);
            product.setQuantity(quantity);
            product.setUnitPrice(unitPrice);
            product.setTotalAmount(totalAmount);
            product.setManufactureDate(manufactureDate);
            product.setExpireDate(expireDate);
            product.setPurchaseDate(purchaseDate);

            boolean success;
            if (purchaseId > 0) {
                success = productService.updatePurchaseProduct(product);
            } else {
                success = productService.createPurchaseProduct(product);
            }

            if (success) {
                response.sendRedirect("PurchaseDashboard");
            } else {
                throw new Exception("Database operation failed.");
            }

        } catch (Exception e) {
            System.err.println("Error in PurchaseProductServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input or missing fields.");
        }
    }
}