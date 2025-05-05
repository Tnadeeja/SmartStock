<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Outgoing Product</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
 <jsp:include page="partials/header.jsp" />
 
 <div class="flex">
  <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content placeholder -->
    <main class="flex-1 p-6">
      <h1 class="text-2xl font-bold text-gray-800">Outgoing Product</h1>
    
    <!-- Start -->
<div class="mt-6 space-y-6">

  <!-- Filter and Search Section in Single Column -->
  <div class="flex flex-wrap items-center gap-3">
    <input type="text" placeholder="Search by product or supplier..." class="border border-gray-300 rounded px-4 py-2 flex-1 min-w-[250px]" />

      <select class="border px-3 py-2 rounded">
        <option>All Categories</option>
        <!-- Populate from backend -->
      </select>
      <select class="border px-3 py-2 rounded">
        <option>All Suppliers</option>
        <!-- Populate from backend -->
      </select>

      <input type="date" class="border px-3 py-2 rounded" />
      <input type="date" class="border px-3 py-2 rounded" />

    <button class="bg-blue-600 text-white px-4 py-2 rounded">Apply</button>
  </div>  

  <!-- Action Buttons -->
  <div class="flex gap-4 mt-6">
    <button onclick="showAddForm()" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 flex items-center gap-2 transition">
      <i class="fas fa-plus"></i> Add
    </button>
    <button class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 flex items-center gap-2 transition">
      <i class="fas fa-file-pdf"></i> Export PDF
    </button>
    <button class="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-600 flex items-center gap-2 transition">
      <i class="fas fa-file-excel"></i> Export Excel
    </button>
  </div>

  <!-- Purchase Stock Table -->
  <div class="bg-white shadow rounded overflow-x-auto mt-6">
<table class="min-w-full text-sm text-gray-700">
  <thead class="bg-gray-100 text-left font-semibold">
    <tr>
      <th class="px-4 py-3">Id</th>
      <th class="px-4 py-3">Product Name</th>
      <th class="px-4 py-3">Category</th>
      <th class="px-4 py-3">Customer</th>
      <th class="px-4 py-3">Quantity</th>
      <th class="px-4 py-3">Sale Price</th>
      <th class="px-4 py-3">Total Amount</th>
      <th class="px-4 py-3">MFG Date</th>
      <th class="px-4 py-3">EXP Date</th>
      <th class="px-4 py-3">Sale Date</th>
      <th class="px-4 py-3">Action</th>
    </tr>
  </thead>
  <tbody>
    <c:forEach var="product" items="${outgoingList}" varStatus="loop">
      <tr class="border-t text-center hover:bg-gray-50">
        <td class="px-4 py-3">${product.outgoingId}</td>
        <td class="px-4 py-3">${product.productName}</td>
        <td class="px-4 py-3">${product.categoryName}</td>
        <td class="px-4 py-3">${product.customerName}</td>
        <td class="px-4 py-3">${product.quantity}</td>
        <td class="px-4 py-3">${product.salePrice}</td>
        <td class="px-4 py-3">${product.totalAmount}</td>
        <td class="px-4 py-3">${product.manufactureDate}</td>
        <td class="px-4 py-3">${product.expireDate}</td>
        <td class="px-4 py-3">${product.outgoingDate}</td>
        <td class="px-4 py-3">
          <a href="outgoing?action=edit&id=${product.outgoingId}" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition">Update</a>
          <a href="outgoing?action=delete&id=${product.outgoingId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition ml-2" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
        </td>
      </tr>
    </c:forEach>
    <c:if test="${empty outgoingList}">
      <tr>
        <td colspan="11" class="text-center text-gray-500 py-6">No outgoing stock found.</td>
      </tr>
    </c:if>
  </tbody>
</table>

  </div>
</div>

<script>
  function showAddForm() {
    window.location.href = '<c:url value="outgoingForm.jsp?action=add" />';
  }
</script>
<!-- End -->
    
    
    </main>

  </div>
</body>
</html>