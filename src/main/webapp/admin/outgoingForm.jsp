<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add New Product</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen">

  <div class="flex h-[calc(100vh-64px)]"> <!-- Assuming header is 64px high -->
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 p-6 flex flex-col"> <!-- ✅ Added 'flex flex-col' -->
      <div class="flex-1 flex flex-col">

        <form action="${pageContext.request.contextPath}/admin/outgoing" method="post" class="flex-1 flex flex-col space-y-6">
          <!-- Hidden ID field for updates -->
          <c:if test="${not empty product}">
              <input type="hidden" name="id" value="${product.outgoingId}" />
          </c:if>

          <!-- Product Info -->
          <div>
            <label class="block text-gray-700 font-medium mb-1">Product Name</label>
            <select name="productName" id="productName" required
                    class="w-full border border-[#2955D9] rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#0A4DA6]"
                    onchange="updateProductInfo()">
                <option value="">-- Select Product --</option>
                <c:forEach var="p" items="${productList}">
                    <option value="${p.productName}"
                        <c:if test="${product != null and product.productName == p.productName}">selected</c:if>>
                        ${p.productName}
                    </option>
                </c:forEach>
            </select>
          </div>

          <!-- Category & Customer -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                  <label class="block text-gray-700 font-medium mb-1">Category</label>
                  <select name="categoryId" id="categoryId" class="w-full border border-[#2955D9] rounded px-4 py-2 bg-white" required>
                      <option value="">-- Select Category --</option>
                      <c:forEach var="category" items="${categoryList}">
                          <option value="${category.categoryName}"
                                  <c:if test="${not empty product && product.categoryName == category.categoryName}">selected</c:if>>
                              ${category.categoryName}
                          </option>
                      </c:forEach>
                  </select>
              </div>
              <div>
                  <label class="block text-gray-700 font-medium mb-1">Customer</label>
                  <select name="supplierId" class="w-full border border-[#2955D9] rounded px-4 py-2 bg-white">
                      <option value="">-- Select Customer --</option>
                      <c:forEach var="customer" items="${customerList}">
                          <option value="${customer}" ${product.customerName == customer ? 'selected' : ''}>${customer}</option>
                      </c:forEach>
                  </select>
              </div>
          </div>

          <!-- Quantity & Price -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
              <div>
                  <label class="block text-gray-700 font-medium mb-1">Quantity</label>
                  <input type="number" name="quantity" id="quantity" value="${product.quantity}" required
                         class="w-full border border-[#2955D9] rounded px-4 py-2" />
              </div>
              <div>
                  <label class="block text-gray-700 font-medium mb-1">Sale Price</label>
                  <input type="number" step="0.01" name="unitPrice" id="unitPrice" value="${product.salePrice}" required
                         class="w-full border border-[#2955D9] rounded px-4 py-2" />
              </div>
              <div>
                  <label class="block text-gray-700 font-medium mb-1">Total Price</label>
                  <input type="number" step="0.01" id="totalPrice" name="totalPrice" value="${product.totalAmount}" required
                         class="w-full border border-[#2955D9] rounded px-4 py-2" />
              </div>
          </div>

        <!-- Dates -->
<div class="grid grid-cols-1 md:grid-cols-3 gap-6">
    <div>
        <label class="block text-gray-700 font-medium mb-1">Manufacture Date</label>
        <input type="date" name="manufactureDate"
               value="<fmt:formatDate value='${product.manufactureDate}' pattern='yyyy-MM-dd'/>"
               class="w-full border border-[#2955D9] rounded px-4 py-2" />
    </div>
    <div>
        <label class="block text-gray-700 font-medium mb-1">Expire Date</label>
        <input type="date" name="expireDate"
               value="<fmt:formatDate value='${product.expireDate}' pattern='yyyy-MM-dd'/>"
               class="w-full border border-[#2955D9] rounded px-4 py-2" />
    </div>
    <div>
        <label class="block text-gray-700 font-medium mb-1">Outgoing Date</label>
        <input type="date" name="outgoingDate"
               value="<fmt:formatDate value='${product.outgoingDate}' pattern='yyyy-MM-dd'/>"
               class="w-full border border-[#2955D9] rounded px-4 py-2" />
    </div>
</div>


          <!-- Buttons -->
          <div class="pt-4 mt-auto">
              <div class="flex justify-end space-x-4">
                  <button type="submit" class="bg-[#0A4DA6] text-white px-6 py-2 rounded hover:bg-[#0D448C] transition-all">
                      <i class="fas fa-save mr-2"></i>Save
                  </button>
                    <button type="button" onclick="window.history.back()" class="bg-[#142B59] text-white px-6 py-2 rounded hover:bg-[#0D448C] transition-all">
                Discard
              </button>
              </div>
          </div>
        </form>
      </div>
    </main>
  </div>
  
  

  <!-- JS for auto-calculating total -->
  <script>
    const quantityInput = document.getElementById("quantity");
    const unitPriceInput = document.getElementById("unitPrice");
    const totalAmountInput = document.getElementById("totalPrice");
    const totalAmountDisplay = document.getElementById("totalAmountDisplay");

    function updateTotal() {
      const qty = parseFloat(quantityInput.value) || 0;
      const price = parseFloat(unitPriceInput.value) || 0;
      const total = qty * price;
      totalAmountInput.value = total.toFixed(2);
      totalAmountDisplay.value = total.toFixed(2);
    }

    quantityInput.addEventListener("input", updateTotal);
    unitPriceInput.addEventListener("input", updateTotal);

    // Initial calculation
    updateTotal();
  </script>
</body>
</html>
