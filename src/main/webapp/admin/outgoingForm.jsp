<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>outgoing form</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen bg-[#f9fafb] text-gray-800 font-sans">

  <div class="flex h-full">
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 flex items-center justify-center overflow-auto px-6 py-12">
      <div class="w-full max-w-5xl space-y-12">

        <!-- Page Header -->
        <h1 class="text-3xl font-semibold text-[#142B59] border-b-2 border-[#2955D9] pb-3 text-center">
          Add Product Outgoing
        </h1>

        <form action="${pageContext.request.contextPath}/admin/outgoing" method="post" class="space-y-12">
          <!-- Hidden ID field for updates -->
          <c:if test="${not empty product}">
              <input type="hidden" name="id" value="${product.outgoingId}" />
          </c:if>

          <!-- Product Name -->
          <div>
            <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Product Name</label>
            <select name="productName" id="productName" required
                    class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm"
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
          <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Category</label>
              <select name="categoryId" id="categoryId"
                      class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" required>
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
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Customer</label>
              <select name="customerName"
                      class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" required>
                  <option value="">-- Select Customer --</option>
                  <c:forEach var="customer" items="${customerList}">
                      <option value="${customer.name}" 
                              <c:if test="${product != null && product.customerName == customer.name}">selected</c:if>>
                          ${customer.name}
                      </option>
                  </c:forEach>
              </select>
            </div>
          </div>

          <!-- Quantity, Price, Total -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Quantity</label>
              <input type="number" name="quantity" id="quantity" value="${product.quantity}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Sale Price</label>
              <input type="number" step="0.01" name="unitPrice" id="unitPrice" value="${product.salePrice}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Total Price</label>
              <input type="number" step="0.01" id="totalPrice" name="totalPrice" value="${product.totalAmount}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
          </div>

          <!-- Date Fields -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Manufacture Date</label>
              <input type="date" name="manufactureDate"
                     value="<fmt:formatDate value='${product.manufactureDate}' pattern='yyyy-MM-dd'/>"
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Expire Date</label>
              <input type="date" name="expireDate"
                     value="<fmt:formatDate value='${product.expireDate}' pattern='yyyy-MM-dd'/>"
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Outgoing Date</label>
              <input type="date" name="outgoingDate"
                     value="<fmt:formatDate value='${product.outgoingDate}' pattern='yyyy-MM-dd'/>"
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
          </div>

          <!-- Action Buttons -->
          <div class="flex justify-end space-x-6 pt-4">
            <button type="submit"
                    class="bg-[#0A4DA6] hover:bg-[#0D448C] text-white font-medium px-6 py-2 rounded-full shadow transition">
              <i class="fas fa-save mr-2"></i>Save
            </button>
            <button type="button" onclick="window.history.back()"
                    class="border border-[#142B59] text-[#142B59] hover:bg-[#142B59] hover:text-white font-medium px-6 py-2 rounded-full transition">
              Discard
            </button>
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

    function updateTotal() {
      const qty = parseFloat(quantityInput.value) || 0;
      const price = parseFloat(unitPriceInput.value) || 0;
      const total = qty * price;
      totalAmountInput.value = total.toFixed(2);
    }

    quantityInput.addEventListener("input", updateTotal);
    unitPriceInput.addEventListener("input", updateTotal);
    updateTotal();
  </script>

<script>
  const form = document.querySelector("form");
  const manufactureDateInput = form.querySelector("input[name='manufactureDate']");
  const expireDateInput = form.querySelector("input[name='expireDate']");
  const outgoingDateInput = form.querySelector("input[name='outgoingDate']");

  form.addEventListener("submit", function(event) {
    const manufactureDate = new Date(manufactureDateInput.value);
    const expireDate = new Date(expireDateInput.value);
    const outgoingDate = new Date(outgoingDateInput.value);

    // Only validate if dates are filled
    if (manufactureDateInput.value && expireDateInput.value) {
      if (expireDate <= manufactureDate) {
        alert("Expire Date must be after Manufacture Date.");
        expireDateInput.focus();
        event.preventDefault();
        return false;
      }
    }

    if (manufactureDateInput.value && outgoingDateInput.value) {
      if (outgoingDate < manufactureDate) {
        alert("Outgoing Date cannot be before Manufacture Date.");
        outgoingDateInput.focus();
        event.preventDefault();
        return false;
      }
    }

    if (expireDateInput.value && outgoingDateInput.value) {
      if (outgoingDate > expireDate) {
        alert("Outgoing Date cannot be after Expire Date.");
        outgoingDateInput.focus();
        event.preventDefault();
        return false;
      }
    }
  });
</script>

</body>
</html>
