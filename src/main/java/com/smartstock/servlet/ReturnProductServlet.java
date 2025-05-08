package com.smartstock.servlet;

import com.smartstock.model.ReturnProduct;
import com.smartstock.service.ReturnProductService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet("/admin/return")
public class ReturnProductServlet extends HttpServlet {

    private ReturnProductService returnProductService = new ReturnProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                ReturnProduct returnProduct = returnProductService.getReturnProduct(id);
                request.setAttribute("returnProduct", returnProduct);
                request.getRequestDispatcher("/admin/returnForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                boolean deleted = returnProductService.deleteReturnProduct(id);

                if (deleted) {
                    session.setAttribute("message", "Item deleted successfully!");
                    session.setAttribute("status", "success-delete");
                } else {
                    session.setAttribute("message", "Failed to delete item.");
                    session.setAttribute("status", "error");
                }

                response.sendRedirect("return");

            } else {
                List<ReturnProduct> returnProductList = returnProductService.getAllReturnProducts();
                request.setAttribute("returnProductList", returnProductList);

                // Retrieve flash message from session and set it in request scope
                Object message = session.getAttribute("message");
                Object status = session.getAttribute("status");
                if (message != null && status != null) {
                    request.setAttribute("message", message);
                    request.setAttribute("status", status);
                    session.removeAttribute("message");
                    session.removeAttribute("status");
                }

                request.getRequestDispatcher("/admin/return.jsp").forward(request, response);
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
            int returnId = request.getParameter("id") != null && !request.getParameter("id").isEmpty()
                    ? Integer.parseInt(request.getParameter("id"))
                    : 0;

            String productName = request.getParameter("productName");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String reason = request.getParameter("reason");

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date returnDate = null;

            if (request.getParameter("returnDate") != null && !request.getParameter("returnDate").isEmpty()) {
                returnDate = formatter.parse(request.getParameter("returnDate"));
            }

            ReturnProduct returnProduct = new ReturnProduct();
            returnProduct.returnId = returnId;
            returnProduct.productName = productName;
            returnProduct.quantity = quantity;
            returnProduct.reason = reason;
            returnProduct.returnDate = returnDate;

            boolean success;

            if (returnId > 0) {
                success = returnProductService.updateReturnProduct(returnProduct);
                if (success) {
                    session.setAttribute("message", "Reason Update successfully!");
                    session.setAttribute("status", "success-update");
                } else {
                    session.setAttribute("message", "Failed to update item.");
                    session.setAttribute("status", "error");
                }
            } else {
                success = returnProductService.createReturnProduct(returnProduct);
                if (success) {
                    session.setAttribute("message", "Reason Added!");
                    session.setAttribute("status", "success-add");
                } else {
                    session.setAttribute("message", "Failed to add item.");
                    session.setAttribute("status", "error");
                }
            }

            response.sendRedirect("return");

        } catch (Exception e) {
            System.err.println("Error in ReturnProductServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input or missing fields.");
        }
    }
}