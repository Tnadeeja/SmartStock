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

        try {
            if ("edit".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                ReturnProduct returnProduct = returnProductService.getReturnProduct(id);
                request.setAttribute("returnProduct", returnProduct);
                request.getRequestDispatcher("/admin/returnForm.jsp").forward(request, response);

            } else if ("delete".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                returnProductService.deleteReturnProduct(id);
                response.sendRedirect("return");

            } else {
                List<ReturnProduct> returnProductList = returnProductService.getAllReturnProducts();
                request.setAttribute("returnProductList", returnProductList);
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

        try {
            // Parse ID for update case
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

            if (returnId > 0) {
                returnProductService.updateReturnProduct(returnProduct);
            } else {
                returnProductService.createReturnProduct(returnProduct);
            }

            response.sendRedirect("return");

        } catch (Exception e) {
            System.err.println("Error in ReturnProductServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid input or missing fields.");
        }
    }
}
