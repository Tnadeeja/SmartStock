package com.smartstock.servlet;

import com.smartstock.model.Category;
import com.smartstock.service.CategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/category")
public class CategoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                Category category = categoryService.getCategory(id);
                request.setAttribute("category", category);
                request.getRequestDispatcher("/admin/categoryForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                categoryService.deleteCategory(id);
                response.sendRedirect("category");

            } else {
                List<Category> categoryList = categoryService.getAllcategory();
                request.setAttribute("categoryList", categoryList);
                request.getRequestDispatcher("/admin/category.jsp").forward(request, response);
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
            int categoryId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String categoryName = request.getParameter("categoryName");

            Category category = new Category();
            category.setCategoryId(categoryId);
            category.setCategoryName(categoryName);

            if (categoryId > 0) {
                categoryService.updateCategory(category);
            } else {
                categoryService.createCategory(category);
            }

            response.sendRedirect("category");

        } catch (Exception e) {
            System.err.println("Error in CategoryServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input or missing fields.");
        }
    }
}
