<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add New Product</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen">

  <jsp:include page="partials/header.jsp" />

  <div class="flex h-[calc(100vh-64px)]"> <!-- Assuming header is 64px high -->
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 p-6 flex flex-col"> <!-- ✅ Added 'flex flex-col' -->
      <div class="flex-1 flex flex-col">



        <form action="${pageContext.request.contextPath}/admin/outgoing" method="post" class="flex-1 flex flex-col space-y-6">
  <!-- Hidden ID field for updates -->
  <c:if test="${not empty product}">
    <input type="hidden" name="id" value="${product.purchaseId}" />
  </c:if>

  <!-- Product Info -->
  <div>
    <label class="block text-gray-700 font-medium mb-1">Product Name</label>
    <input type="text" name="productName" value="${product.productName}" required
           class="w-full border border-gray-300 rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
  </div>

  <!-- Category & Customer -->
  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    <div>
      <label class="block text-gray-700 font-medium mb-1">Category</label>
      <select name="categoryId" 
              class="w-full border border-gray-300 rounded px-4 py-2 bg-white">
        <option value="">-- Select Category --</option>
        <c:forEach var="category" items="${categoryList}">
          <option value="${category}" ${product.categoryName == category ? 'selected' : ''}>${category}</option>
        </c:forEach>
      </select>
    </div>
    <div>
      <label class="block text-gray-700 font-medium mb-1">Customer</label>
      <select name="supplierId" 
              class="w-full border border-gray-300 rounded px-4 py-2 bg-white">
        <option value="">-- Select Customer --</option>
        <c:forEach var="customer" items="${customerList}">
          <option value="${customer}" ${product.customerName == customer ? 'selected' : ''}>${customer}</option>
        </c:forEach>
      </select>
    </div>
  </div>

  <!-- Quantity & Price -->
  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
    <div>
      <label class="block text-gray-700 font-medium mb-1">Quantity</label>
      <input type="number" name="quantity" value="${product.quantity}" required
             class="w-full border border-gray-300 rounded px-4 py-2" />
    </div>
    <div>
      <label class="block text-gray-700 font-medium mb-1">Sale Price</label>
      <input type="number" step="0.01" name="unitPrice" value="${product.salePrice}" required
             class="w-full border border-gray-300 rounded px-4 py-2" />
    </div>
    <div>
      <label class="block text-gray-700 font-medium mb-1">Total Price</label>
      <input type="number" step="0.01" name="totalPrice" value="${product.totalAmount}" required
             class="w-full border border-gray-300 rounded px-4 py-2" />
    </div>
  </div>

  <!-- Dates -->
  <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
    <div>
      <label class="block text-gray-700 font-medium mb-1">Manufacture Date</label>
      <input type="date" name="manufactureDate" value="${product.manufactureDate}" 
             class="w-full border border-gray-300 rounded px-4 py-2" />
    </div>
    <div>
      <label class="block text-gray-700 font-medium mb-1">Expire Date</label>
      <input type="date" name="expireDate" value="${product.expireDate}" 
             class="w-full border border-gray-300 rounded px-4 py-2" />
    </div>
    <div>
      <label class="block text-gray-700 font-medium mb-1">Outgoing Date</label>
      <input type="date" name="purchaseDate" value="${product.outgoingDate}" 
             class="w-full border border-gray-300 rounded px-4 py-2" />
    </div>
  </div>

  <!-- Buttons -->
  <div class="pt-4 mt-auto">
    <div class="flex justify-end space-x-4">
      <button type="submit"
              class="bg-green-600 text-white px-6 py-2 rounded hover:bg-green-700 transition-all">
        <i class="fas fa-save mr-2"></i>Save
      </button>
      <button type="button" onclick="window.close()"
              class="bg-gray-500 text-white px-6 py-2 rounded hover:bg-gray-600 transition-all">
        Discard
      </button>
    </div>
  </div>
</form>
        
      </div>
    </main>
  </div>
</body>
</html>