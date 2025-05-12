<%
    String role = (String) session.getAttribute("role");
    if (role == null || !(role.equals("admin") || role.equals("sales manager") || role.equals("stock manager"))) {
        response.sendRedirect(request.getContextPath() + "/admin/unauthorized.jsp");
        return;
    }

    com.smartstock.model.DashboardData dashboardData =
        (com.smartstock.model.DashboardData) request.getAttribute("dashboardData");
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>SmartStock Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="bg-gray-100 font-sans">

<div class="flex">
  <jsp:include page="partials/slideBar.jsp" />

  <main class="flex-1 p-4 space-y-6">
    <h1 class="text-xl font-semibold text-[#142B59]">SmartStock</h1>

<% if (dashboardData != null) { %>

    <!-- Summary Cards -->
    <section class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div class="bg-white p-3 rounded shadow-sm">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Categories</h3>
        <p class="text-xl font-bold text-[#2955D9]">
          <%= dashboardData.getTotalCategories() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded shadow-sm">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Products</h3>
        <p class="text-xl font-bold text-[#2955D9]">
          <%= dashboardData.getTotalProducts() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded shadow-sm">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Customers</h3>
        <p class="text-xl font-bold text-[#2955D9]">
          <%= dashboardData.getTotalCustomers() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded shadow-sm">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Suppliers</h3>
        <p class="text-xl font-bold text-[#2955D9]">
          <%= dashboardData.getTotalSuppliers() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded shadow-sm">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Alerts</h3>
        <p class="text-xl font-bold text-red-500">
          <%= dashboardData.getTotalAlerts() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded shadow-sm">
        <h3 class="font-semibold text-sm text-[#0D448C]">System Users</h3>
        <p class="text-xl font-bold text-[#2955D9]">
          <%= dashboardData.getTotalUsers() %>
        </p>
      </div>
    </section>

    <!-- Profit Info Section -->
    <section>
      <h2 class="text-lg font-semibold mb-3 text-[#142B59]">Profit Overview</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
        <div class="bg-white p-3 rounded shadow-sm">
          <h3 class="font-semibold text-sm text-[#0D448C]">Total Profit</h3>
          <p class="text-xl font-bold text-green-600">
            $<%= String.format("%.2f", dashboardData.getTotalProfit()) %>
          </p>
        </div>
        <div class="bg-white p-3 rounded shadow-sm">
          <h3 class="font-semibold text-sm text-[#0D448C]">Profit Margin</h3>
          <p class="text-xl font-bold text-green-600">
            <%= String.format("%.2f", dashboardData.getProfitMargin()) %>%
          </p>
        </div>
      </div>
    </section>

    <!-- Inventory Info -->
    <section>
      <h2 class="text-lg font-semibold mb-3 text-[#142B59]">Inventory Summary</h2>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div class="bg-white p-3 rounded shadow-sm">
          <h3 class="font-semibold text-sm text-[#0D448C]">Current Stock</h3>
          <p class="text-lg font-bold text-green-600">
            <%= dashboardData.getCurrentStock() %> items
          </p>
        </div>
        <div class="bg-white p-3 rounded shadow-sm">
          <h3 class="font-semibold text-sm text-[#0D448C]">Most Outgoing Product</h3>
          <p class="text-sm text-gray-700">
            <%= dashboardData.getMostOutgoingProduct() %>
          </p>
        </div>
        <div class="bg-white p-3 rounded shadow-sm">
          <h3 class="font-semibold text-sm text-[#0D448C]">Current Returns</h3>
          <p class="text-lg font-bold text-orange-500">
            <%= dashboardData.getCurrentReturns() %> returns
          </p>
        </div>
      </div>
    </section>

<% } else { %>
    <div class="bg-white p-4 rounded shadow text-red-600 font-semibold">
      Error loading dashboard data.
    </div>
<% } %>

    <!-- Support Link -->
    <section>
      <h2 class="text-lg font-semibold mb-3 text-[#142B59]">Support</h2>
      <div class="bg-white p-3 rounded shadow-sm flex justify-between items-center">
        <p class="text-sm text-gray-800">Need help or have issues?</p>
        <a href="/admin/supportForm.jsp" class="bg-[#2964D9] text-white px-3 py-1 rounded hover:bg-[#2955D9] transition text-sm">Go to Support</a>
      </div>
    </section>
    
  </main>
</div>

</body>
</html>