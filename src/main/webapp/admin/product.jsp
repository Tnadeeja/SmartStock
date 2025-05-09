<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="bg-gray-100 text-dark-blue">
 
 <div class="flex">
  <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content placeholder -->
    <main class="flex-1 p-6">
    
    <!-- Start -->
<div class="mt-6 space-y-6">

<!-- Filter Form -->
                <form method="get" action="outgoing" class="flex flex-wrap items-center gap-3">
                    <input type="text" name="search" placeholder="Search by product or customer..." value="${param.search}" class="border border-primary rounded px-4 py-2 flex-1 min-w-[250px] text-dark-blue" />

                    <select name="category" class="border border-primary px-3 py-2 rounded text-dark-blue">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat}" <c:if test="${param.category == cat}">selected</c:if>>${cat}</option>
                        </c:forEach>
                    </select>

                    <select name="supplier" class="border border-primary px-3 py-2 rounded text-dark-blue">
                        <option value="">All Suppliers</option>
                        <c:forEach var="sup" items="${cusomerList}">
                            <option value="${sup}" <c:if test="${param.supplier == sup}">selected</c:if>>${sup}</option>
                        </c:forEach>
                    </select>

                    <input type="date" name="startDate" value="${param.startDate}" class="border border-primary px-3 py-2 rounded text-dark-blue" />
                    <input type="date" name="endDate" value="${param.endDate}" class="border border-primary px-3 py-2 rounded text-dark-blue" />

                    <button type="submit" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark">Apply</button>
                    <button type="button" onclick="window.location.href='outgoing'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
                </form> 

  <!-- Action Buttons -->
  <div class="flex gap-4 mt-6">
 <a href="product?action=add" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark flex items-center gap-2 transition">
  <i class="fas fa-plus"></i> Add
</a>
    
    <button class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 flex items-center gap-2 transition">
      <i class="fas fa-file-pdf"></i> Export PDF
    </button>
    <button class="bg-yellow-500 text-dark-blue px-4 py-2 rounded hover:bg-yellow-600 flex items-center gap-2 transition">
      <i class="fas fa-file-excel"></i> Export Excel
    </button>
  </div>

  <!-- Product Table -->
      <div class="bg-white shadow rounded overflow-x-auto mt-6">
        <table class="min-w-full text-sm text-dark-blue">
          <thead class="bg-primary text-white text-left font-semibold">
            <tr>
              <th class="px-4 py-3">ID</th>
              <th class="px-4 py-3">Product Name</th>
              <th class="px-4 py-3">Category</th>
              <th class="px-4 py-3">Unit Price</th>
              <th class="px-4 py-3">Sale Price</th>
              <th class="px-4 py-3">Action</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="product" items="${productList}">
              <tr class="border-t text-center hover:bg-gray-50">
                <td class="px-4 py-3">${product.productId}</td>
                <td class="px-4 py-3">${product.productName}</td>
                <td class="px-4 py-3">${product.categoryName}</td>
                <td class="px-4 py-3">${product.unitPrice}</td>
                <td class="px-4 py-3">${product.salePrice}</td>
                <td class="px-4 py-3">
                  <div class="flex justify-center gap-2">
                    <a href="product?action=edit&id=${product.productId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition">Update</a>
                    <a href="product?action=delete&id=${product.productId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                  </div>
                </td>
              </tr>
            </c:forEach>
            <c:if test="${empty productList}">
              <tr>
                <td colspan="7" class="text-center text-gray-500 py-6">No products found.</td>
              </tr>
            </c:if>
          </tbody>
        </table>
      </div>
</div>


    
    
    </main>

  </div>
</body>
</html>