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
	private static final long serialVersionUID = 1L;
	
    private final OutgoingProductService outgoingProductService = new OutgoingProductService();
    private final ProductService productService = new ProductService();
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                OutgoingProduct product = outgoingProductService.getOutgoingProduct(id);

                List<Category> categoryList = new CategoryService().getAllcategory();
                List<Product> productList = productService.getAllProducts();
                List<Customer> customerList = customerService.getAllCustomers();

                request.setAttribute("product", product);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("productList", productList);
                request.setAttribute("customerList", customerList);
                request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));

                OutgoingProduct outgoingProduct = outgoingProductService.getOutgoingProduct(id);
                boolean deleted = outgoingProductService.deleteOutgoingProduct(id);

                if (deleted) {
                    session.setAttribute("message", "Item deleted successfully!");
                    session.setAttribute("status", "success-delete");
                } else {
                    session.setAttribute("message", "Failed to delete item.");
                    session.setAttribute("status", "error");
                }

                if (outgoingProduct != null) {
                    ReturnProduct returnProduct = new ReturnProduct();
                    returnProduct.setProductName(outgoingProduct.getProductName());
                    returnProduct.setQuantity(outgoingProduct.getQuantity());
                    returnProduct.setReturnDate(new Date());
                    returnProduct.setReason("");

                    ReturnProductService returnService = new ReturnProductService();
                    returnService.createReturnProduct(returnProduct);
                }

                response.sendRedirect("outgoing");

            } else if ("add".equals(action)) {
                List<Category> categoryList = new CategoryService().getAllcategory();
                List<Product> productList = productService.getAllProducts();
                List<Customer> customerList = customerService.getAllCustomers();

                request.setAttribute("categoryList", categoryList);
                request.setAttribute("productList", productList);
                request.setAttribute("customerList", customerList);
                request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);

            } else {
                // Filtering logic
                String search = request.getParameter("search");
                String category = request.getParameter("category");
                String customer = request.getParameter("customer");
                String fromDateStr = request.getParameter("fromDate");
                String toDateStr = request.getParameter("toDate");

                Date fromDate = null;
                Date toDate = null;
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                if (fromDateStr != null && !fromDateStr.isEmpty()) {
                    fromDate = sdf.parse(fromDateStr);
                }
                if (toDateStr != null && !toDateStr.isEmpty()) {
                    toDate = sdf.parse(toDateStr);
                }

                List<OutgoingProduct> outgoingList = outgoingProductService.getFilteredOutgoingProducts(search, category, customer, fromDate, toDate);

                List<Category> categoryList = new CategoryService().getAllcategory();
                List<Product> productList = productService.getAllProducts();
                List<Customer> customerList = customerService.getAllCustomers();

                request.setAttribute("outgoingList", outgoingList);
                request.setAttribute("categoryList", categoryList);
                request.setAttribute("productList", productList);
                request.setAttribute("customerList", customerList);

                request.setAttribute("search", search);
                request.setAttribute("selectedCategory", category);
                request.setAttribute("selectedCustomer", customer);
                request.setAttribute("fromDate", fromDateStr);
                request.setAttribute("toDate", toDateStr);

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
            String customerName = request.getParameter("customerName");

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
            if (request.getParameter("outgoingDate") != null && !request.getParameter("outgoingDate").isEmpty()) {
                outgoingDate = formatter.parse(request.getParameter("outgoingDate"));
            }

            OutgoingProduct product = new OutgoingProduct();
            product.setOutgoingId(outgoingId);
            product.setProductName(productName);
            product.setCategoryName(categoryName);
            product.setCustomerName(customerName);
            product.setQuantity(quantity);
            product.setSalePrice(salePrice);
            product.setTotalAmount(totalAmount);
            product.setManufactureDate(manufactureDate);
            product.setExpireDate(expireDate);
            product.setOutgoingDate(outgoingDate);

            boolean success;
            if (outgoingId > 0) {
                success = outgoingProductService.updateOutgoingProduct(product);
                session.setAttribute("message", success ? "Item updated successfully!" : "Failed to update item.");
                session.setAttribute("status", success ? "success-update" : "error");
            } else {
                success = outgoingProductService.createOutgoingProduct(product);
                session.setAttribute("message", success ? "Item added successfully!" : "Failed to add item.");
                session.setAttribute("status", success ? "success-add" : "error");
            }

            response.sendRedirect("outgoing");

        } catch (Exception e) {
            e.printStackTrace();

            List<Category> categoryList = new CategoryService().getAllcategory();
            List<Product> productList = productService.getAllProducts();
            List<Customer> customerList = customerService.getAllCustomers();

            request.setAttribute("categoryList", categoryList);
            request.setAttribute("productList", productList);
            request.setAttribute("customerList", customerList);
            request.setAttribute("error", "Invalid input or missing fields. Please check your form.");
            request.getRequestDispatcher("/admin/outgoingForm.jsp").forward(request, response);
        }
    }
}
