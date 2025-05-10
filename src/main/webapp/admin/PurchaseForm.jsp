<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Purchase Form</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen">

  <div class="flex h-[calc(100vh-64px)]">
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 p-6 flex flex-col">
      <div class="flex-1 flex flex-col">

        <form action="${pageContext.request.contextPath}/admin/PurchaseDashboard" method="post" class="flex-1 flex flex-col space-y-6">
          
          <!-- Hidden ID field for edit -->
          <c:if test="${not empty product}">
            <input type="hidden" name="id" value="${product.purchaseId}" />
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

    <!-- Category & Supplier -->
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
	   <label class="block text-gray-700 font-medium mb-1">Supplier</label>
                  <select name="supplierName" id="supplierName" class="w-full border border-[#2955D9] rounded px-4 py-2 bg-white" required>
                      <option value="">-- Select Supplier --</option>
                      <c:forEach var="supplier" items="${supplierList}">
                          <option value="${supplier.name}"
                                  <c:if test="${product != null && product.supplierName == supplier.name}">selected</c:if>>
                              ${supplier.name}
                          </option>
                      </c:forEach>
                  </select>
              </div>
          </div>

          <!-- Quantity, Unit Price & Total -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <label class="block text-gray-700 font-medium mb-1">Quantity</label>
              <input type="number" name="quantity" id="quantity" value="${product.quantity}" required
                     class="w-full border border-[#2955D9] rounded px-4 py-2" />
            </div>
            <div>
              <label class="block text-gray-700 font-medium mb-1">Unit Price</label>
              <input type="number" step="0.01" name="unitPrice" id="unitPrice" value="${product.unitPrice}" required
                     class="w-full border border-[#2955D9] rounded px-4 py-2" />
            </div>
            <div>
              <label class="block text-gray-700 font-medium mb-1">Total Amount</label>
              <input type="text" id="totalAmountDisplay" value="${product.totalAmount}" readonly
                     class="w-full border border-[#2955D9] bg-gray-100 rounded px-4 py-2" />
            </div>
          </div>

          <!-- Hidden totalAmount for form submission -->
          <input type="hidden" name="totalAmount" id="totalAmount" value="${product.totalAmount}" />

          <!-- Date fields -->
          <fmt:formatDate value="${product.manufactureDate}" pattern="yyyy-MM-dd" var="mfgDate" />
          <fmt:formatDate value="${product.expireDate}" pattern="yyyy-MM-dd" var="expDate" />
          <fmt:formatDate value="${product.purchaseDate}" pattern="yyyy-MM-dd" var="purDate" />

          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <label class="block text-gray-700 font-medium mb-1">Manufacture Date</label>
              <input type="date" name="manufactureDate" value="${mfgDate}" class="w-full border border-[#2955D9] rounded px-4 py-2" />
            </div>
            <div>
              <label class="block text-gray-700 font-medium mb-1">Expire Date</label>
              <input type="date" name="expireDate" value="${expDate}" class="w-full border border-[#2955D9] rounded px-4 py-2" />
            </div>
            <div>
              <label class="block text-gray-700 font-medium mb-1">Purchase Date</label>
              <input type="date" name="purchaseDate" value="${purDate}" class="w-full border border-[#2955D9] rounded px-4 py-2" />
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
    const totalAmountInput = document.getElementById("totalAmount");
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