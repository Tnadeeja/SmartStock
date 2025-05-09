package com.smartstock.servlet;

import com.smartstock.model.AlertModel;
import com.smartstock.service.AlertService;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/alert")
public class AlertServlet extends HttpServlet {
    private AlertService service;

    @Override
    public void init() throws ServletException {
        service = new AlertService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<AlertModel> alerts = service.getRecentSupportRequests();
        request.setAttribute("alerts", alerts);
        RequestDispatcher dispatcher = request.getRequestDispatcher("alert.jsp");
        dispatcher.forward(request, response);
    }
}