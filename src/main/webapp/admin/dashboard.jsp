<%
    String role = (String) session.getAttribute("role");
    if (role == null || !(role.equals("admin") || role.equals("sales manager") || role.equals("stock manager"))) {
        response.sendRedirect(request.getContextPath() + "/admin/unauthorized.jsp");
        return;
    }

    com.smartstock.model.DashboardData dashboardData =
        (com.smartstock.model.DashboardData) request.getAttribute("dashboardData");
%>

<%
    java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("EEEE, MMMM dd, yyyy | hh:mm a");
    String currentDateTime = formatter.format(new java.util.Date());
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>dashboard</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="bg-gray-100 font-sans">

<div class="flex">
  <jsp:include page="partials/slideBar.jsp" />

  <main class="flex-1 p-4 space-y-6">
  
  <div class="rounded-xl p-3 bg-gradient-to-r from-[#0A4DA6] to-[#2964D9] shadow-lg flex flex-col md:flex-row justify-between items-start md:items-center gap-2">
  <!-- Title Section -->
  	<div>
   	 <h1 class="text-3xl font-bold text-white tracking-wide">SmartStock</h1>
   	 <p class="text-sm text-blue-100 mt-1">Be Stock Smart with SmartStock</p>
  	</div>

  <!-- Date & Time Section -->
  	<div class="flex items-center gap-2 bg-white bg-opacity-10 px-4 py-2 rounded-md text-white text-sm md:text-base shadow-sm">
    	<i class="far fa-clock text-white opacity-80"></i>
    	<span class="whitespace-nowrap"><%= currentDateTime %></span>
  	</div>
	</div>


<% if (dashboardData != null) { %>

    <!-- Summary Cards -->
    <section class="grid grid-cols-1 md:grid-cols-3 gap-4">
      <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Categories</h3>
        <p class="text-xl font-bold text-[#2955D9]">
          <%= dashboardData.getTotalCategories() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Products</h3>
        <p class="text-xl font-bold text-[#2955D9]">
          <%= dashboardData.getTotalProducts() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Customers</h3>
        <p class="text-xl font-bold text-[#2955D9]">
          <%= dashboardData.getTotalCustomers() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Suppliers</h3>
        <p class="text-xl font-bold text-[#2955D9]">
          <%= dashboardData.getTotalSuppliers() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
        <h3 class="font-semibold text-sm text-[#0D448C]">Total Alerts</h3>
        <p class="text-xl font-bold text-red-500">
          <%= dashboardData.getTotalAlerts() %>
        </p>
      </div>
      <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
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
        <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
          <h3 class="font-semibold text-sm text-[#0D448C]">Total Profit</h3>
          <p class="text-xl font-bold text-green-600">
            LKR. <%= String.format("%.2f", dashboardData.getTotalProfit()) %>
          </p>
        </div>
        <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
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
        <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
          <h3 class="font-semibold text-sm text-[#0D448C]">Current Stock</h3>
          <p class="text-lg font-bold text-green-600">
            <%= dashboardData.getCurrentStock() %> items
          </p>
        </div>
        <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
          <h3 class="font-semibold text-sm text-[#0D448C]">Most Outgoing Product</h3>
          <p class="text-sm text-gray-700">
            <%= dashboardData.getMostOutgoingProduct() %>
          </p>
        </div>
        <div class="bg-white p-3 rounded-xl shadow hover:shadow-md transition">
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