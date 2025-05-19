package com.smartstock.servlet;

import com.smartstock.model.Product;
import com.smartstock.model.Category;
import com.smartstock.service.ProductService;
import com.smartstock.service.CategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/product")
public class ProductServlet extends HttpServlet {

    private ProductService productService = new ProductService();
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        String search = request.getParameter("search");
        String categoryFilter = request.getParameter("category");

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Product product = productService.getProduct(id);
                List<Category> categoryList = categoryService.getAllcategory();
                List<Product> productList = productService.getAllProducts();

                request.setAttribute("product", product);
                request.setAttribute("productList", productList);
                request.setAttribute("categoryList", categoryList);
                request.getRequestDispatcher("/admin/productForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                productService.deleteProduct(id);
                response.sendRedirect("product");

            } else if ("add".equals(action)) {
                List<Category> categoryList = categoryService.getAllcategory();
                List<Product> productList = productService.getAllProducts();

                request.setAttribute("productList", productList);
                request.setAttribute("categoryList", categoryList);
                request.getRequestDispatcher("/admin/productForm.jsp").forward(request, response);

            } else {
                // Get all products with stock info
                List<Product> productList = productService.getAllProducts();

                // Filter by search text if present
                if (search != null && !search.trim().isEmpty()) {
                    String searchLower = search.toLowerCase();
                    productList = productList.stream()
                            .filter(p -> p.getProductName().toLowerCase().contains(searchLower))
                            .toList();
                }

                // Filter by category if selected
                if (categoryFilter != null && !categoryFilter.trim().isEmpty()) {
                    productList = productList.stream()
                            .filter(p -> p.getCategoryName().equalsIgnoreCase(categoryFilter))
                            .toList();
                }

                List<Category> categoryList = categoryService.getAllcategory();

                request.setAttribute("productList", productList);
                request.setAttribute("categoryList", categoryList);
                request.getRequestDispatcher("/admin/product.jsp").forward(request, response);
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
            int productId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String productName = request.getParameter("productName");
            String categoryName = request.getParameter("categoryId");
            double unitPrice = Double.parseDouble(request.getParameter("unitPrice"));
            double salePrice = Double.parseDouble(request.getParameter("salePrice"));

            Product product = new Product();
            product.setProductId(productId);
            product.setProductName(productName);
            product.setCategoryName(categoryName);
            product.setUnitPrice(unitPrice);
            product.setSalePrice(salePrice);

            if (productId > 0) {
                productService.updateProduct(product);
            } else {
                productService.createProduct(product);
            }

            response.sendRedirect("product");

        } catch (Exception e) {
            e.printStackTrace();

            List<Category> categoryList = categoryService.getAllcategory();
            List<Product> productList = productService.getAllProducts();

            request.setAttribute("productList", productList);
            request.setAttribute("categoryList", categoryList);
            request.setAttribute("error", "Invalid input or missing fields. Please check your form.");

            request.getRequestDispatcher("/admin/productForm.jsp").forward(request, response);
        }
    }
}