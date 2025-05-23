package com.smartstock.servlet;

import com.smartstock.model.Category;
import com.smartstock.model.Product;
import com.smartstock.model.PurchaseProduct;
import com.smartstock.model.Supplier;
import com.smartstock.service.CategoryService;
import com.smartstock.service.ProductService;
import com.smartstock.service.PurchaseProductService;
import com.smartstock.service.SupplierService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/PurchaseDashboard")
public class PurchaseProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private final PurchaseProductService PurchaseProductService = new PurchaseProductService();
    private final ProductService productService = new ProductService();
    private final SupplierService supplierService = new SupplierService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                PurchaseProduct product = PurchaseProductService.getPurchaseProduct(id);

                List<Category> categoryList = new CategoryService().getAllcategory();
                List<Product> productList = productService.getAllProducts();
                List<Supplier> supplierList = supplierService.getAllSuppliers();

                request.setAttribute("product", product);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("productList", productList);
                request.setAttribute("supplierList", supplierList);

                request.getRequestDispatcher("/admin/PurchaseForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = PurchaseProductService.deletePurchaseProduct(id);

                if (deleted) {
                    session.setAttribute("message", "Item deleted successfully!");
                    session.setAttribute("status", "success-delete");
                } else {
                    session.setAttribute("message", "Failed to delete item.");
                    session.setAttribute("status", "error");
                }

                response.sendRedirect("PurchaseDashboard");

            } else if ("add".equals(action)) {
                List<Category> categoryList = new CategoryService().getAllcategory();
                List<Product> productList = productService.getAllProducts();
                List<Supplier> supplierList = supplierService.getAllSuppliers();

                request.setAttribute("categoryList", categoryList);
                request.setAttribute("productList", productList);
                request.setAttribute("supplierList", supplierList);

                request.getRequestDispatcher("/admin/PurchaseForm.jsp").forward(request, response);

            } else {
                String search = request.getParameter("search");
                String category = request.getParameter("category");
                String supplier = request.getParameter("supplier");
                String startDateStr = request.getParameter("startDate");
                String endDateStr = request.getParameter("endDate");

                Date startDate = null, endDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                if (startDateStr != null && !startDateStr.isEmpty())
                    startDate = sdf.parse(startDateStr);
                if (endDateStr != null && !endDateStr.isEmpty())
                    endDate = sdf.parse(endDateStr);

                if (session.getAttribute("message") != null) {
                    request.setAttribute("message", session.getAttribute("message"));
                    request.setAttribute("status", session.getAttribute("status"));
                    session.removeAttribute("message");
                    session.removeAttribute("status");
                }

                List<PurchaseProduct> purchaseList = PurchaseProductService.getFilteredPurchaseProducts(
                        search, category, supplier, startDate, endDate
                );

                List<Category> categoryList = new CategoryService().getAllcategory();
                List<Product> productList = productService.getAllProducts();
                List<Supplier> supplierList = supplierService.getAllSuppliers();

                request.setAttribute("purchaseList", purchaseList);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("productList", productList);
                request.setAttribute("supplierList", supplierList);

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

        HttpSession session = request.getSession();

        try {
            int purchaseId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String productName = request.getParameter("productName");
            String categoryName = request.getParameter("categoryId");
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
                success = PurchaseProductService.updatePurchaseProduct(product);
                if (success) {
                    session.setAttribute("message", "Item updated successfully!");
                    session.setAttribute("status", "success-update");
                } else {
                    session.setAttribute("message", "Failed to update item.");
                    session.setAttribute("status", "error");
                }
                response.sendRedirect("PurchaseDashboard");
            } else {
                success = PurchaseProductService.createPurchaseProduct(product);
                if (success) {
                    session.setAttribute("message", "Item added successfully!");
                    session.setAttribute("status", "success-add");
                    response.sendRedirect("PurchaseDashboard");
                } else {
                    session.setAttribute("message", "Failed to add item.");
                    session.setAttribute("status", "error");
                    response.sendRedirect("PurchaseDashboard");
                }
            }

        } catch (Exception e) {

            List<Category> categoryList = new CategoryService().getAllcategory();
            List<Product> productList = productService.getAllProducts();
            List<Supplier> supplierList = supplierService.getAllSuppliers();

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("productList", productList);
            request.setAttribute("supplierList", supplierList);

            request.setAttribute("errorMessage", "Invalid input or error occurred: " + e.getMessage());
            request.setAttribute("purchaseProduct", new PurchaseProduct());

            e.printStackTrace();

            request.getRequestDispatcher("/admin/PurchaseForm.jsp").forward(request, response);
        }
    }
}