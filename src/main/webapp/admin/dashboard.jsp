<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/admin/unauthorized.jsp");
        return;
    }
%>

<%
    // Dummy sample data - replace with real DAO queries
    int totalCategories = 10;
    int totalProducts = 120;
    int totalCustomers = 35;
    int totalSuppliers = 8;
    int totalAlerts = 4;
    int totalUsers = 5;

    int currentStock = 356; // example
    String mostOutgoingProduct = "Product A (120 units)";
    int currentReturns = 6;

    // Profit Data - Replace with real calculation
    double totalSales = 15000.00;  // Total revenue from sales
    double totalCost = 9000.00;    // Total cost of purchases
    double totalProfit = totalSales - totalCost; // Profit = Sales - Cost
    double profitMargin = (totalProfit / totalSales) * 100; // Profit Margin % (Sales-based)
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

  <main class="flex-1 p-6 space-y-8">
    <h1 class="text-2xl font-bold">SmartStock Dashboard</h1>

    <!-- Summary Cards -->
    <section class="grid grid-cols-1 md:grid-cols-3 gap-6">
      <div class="bg-white p-4 rounded shadow">
        <h3 class="font-semibold">Total Categories</h3>
        <p class="text-2xl font-bold text-indigo-600"><%= totalCategories %></p>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <h3 class="font-semibold">Total Products</h3>
        <p class="text-2xl font-bold text-indigo-600"><%= totalProducts %></p>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <h3 class="font-semibold">Total Customers</h3>
        <p class="text-2xl font-bold text-indigo-600"><%= totalCustomers %></p>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <h3 class="font-semibold">Total Suppliers</h3>
        <p class="text-2xl font-bold text-indigo-600"><%= totalSuppliers %></p>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <h3 class="font-semibold">Total Alerts</h3>
        <p class="text-2xl font-bold text-red-500"><%= totalAlerts %></p>
      </div>
      <div class="bg-white p-4 rounded shadow">
        <h3 class="font-semibold">System Users</h3>
        <p class="text-2xl font-bold text-indigo-600"><%= totalUsers %></p>
      </div>
    </section>

    <!-- Profit Info Section -->
    <section>
      <h2 class="text-xl font-semibold mb-4">Profit Overview</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <div class="bg-white p-4 rounded shadow">
          <h3 class="font-semibold">Total Profit</h3>
          <p class="text-2xl font-bold text-green-600">$<%= String.format("%.2f", totalProfit) %></p>
        </div>
        <div class="bg-white p-4 rounded shadow">
          <h3 class="font-semibold">Profit Margin</h3>
          <p class="text-2xl font-bold text-green-600"><%= String.format("%.2f", profitMargin) %>%</p>
        </div>
      </div>

    <!-- Inventory Info -->
    <section>
      <h2 class="text-xl font-semibold mb-4">Inventory Summary</h2>
      <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
        <div class="bg-white p-4 rounded shadow">
          <h3 class="font-semibold">Current Stock</h3>
          <p class="text-xl font-bold text-green-600"><%= currentStock %> items</p>
        </div>
        <div class="bg-white p-4 rounded shadow">
          <h3 class="font-semibold">Most Outgoing Product</h3>
          <p class="text-sm text-gray-700"><%= mostOutgoingProduct %></p>
        </div>
        <div class="bg-white p-4 rounded shadow">
          <h3 class="font-semibold">Current Returns</h3>
          <p class="text-xl font-bold text-orange-500"><%= currentReturns %> returns</p>
        </div>
      </div>
    </section>

    <!-- Support Link -->
    <section>
      <h2 class="text-xl font-semibold mb-4">Support</h2>
      <div class="bg-white p-4 rounded shadow flex justify-between items-center">
        <p class="text-gray-800">Need help or have issues?</p>
        <a href="support.jsp" class="bg-blue-500 text-white px-4 py-2 rounded hover:bg-blue-600 transition">Go to Support</a>
      </div>
    </section>
  </main>
</div>

</body>
</html>