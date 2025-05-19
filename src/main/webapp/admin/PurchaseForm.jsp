<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>purchase form</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen bg-[#f9fafb] text-gray-800 font-sans">

  <div class="flex h-full">
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main Content -->
    <main class="flex-1 flex items-center justify-center overflow-auto px-6 py-12">
      <div class="w-full max-w-5xl space-y-12">

        <!-- Header -->
        <h1 class="text-3xl font-semibold text-[#142B59] border-b-2 border-[#2955D9] pb-3 text-center">
          Purchase Product
        </h1>

        <form action="${pageContext.request.contextPath}/admin/PurchaseDashboard" method="post" class="space-y-10">

          <c:if test="${not empty product}">
            <input type="hidden" name="id" value="${product.purchaseId}" />
          </c:if>

          <!-- Product Selection -->
          <div>
            <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Product Name</label>
            <select name="productName" id="productName" required
                    class="w-full border border-[#2955D9] rounded-lg px-4 py-3 bg-white shadow-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6]">
              <option value="">-- Select Product --</option>
              <c:forEach var="p" items="${productList}">
                <option value="${p.productName}"
                        <c:if test="${product != null && product.productName == p.productName}">selected</c:if>>
                  ${p.productName}
                </option>
              </c:forEach>
            </select>
          </div>

          <!-- Category & Supplier -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Category</label>
              <select name="categoryId" required
                      class="w-full border border-[#2955D9] rounded-lg px-4 py-3 bg-white shadow-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6]">
                <option value="">-- Select Category --</option>
                <c:forEach var="category" items="${categoryList}">
                  <option value="${category.categoryName}"
                          <c:if test="${product != null && product.categoryName == category.categoryName}">selected</c:if>>
                    ${category.categoryName}
                  </option>
                </c:forEach>
              </select>
            </div>

            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Supplier</label>
              <select name="supplierName" required
                      class="w-full border border-[#2955D9] rounded-lg px-4 py-3 bg-white shadow-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6]">
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

          <!-- Quantity, Unit Price, Total -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Quantity</label>
              <input type="number" name="quantity" id="quantity" value="${product.quantity}" required
                     class="w-full border border-[#2955D9] rounded-lg px-4 py-3 shadow-sm" />
            </div>

            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Unit Price</label>
              <input type="number" step="0.01" name="unitPrice" id="unitPrice" value="${product.unitPrice}" required
                     class="w-full border border-[#2955D9] rounded-lg px-4 py-3 shadow-sm" />
            </div>

            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Total Amount</label>
              <input type="text" id="totalAmountDisplay" value="${product.totalAmount}" readonly
                     class="w-full border border-[#2955D9] bg-gray-100 rounded-lg px-4 py-3 shadow-sm" />
            </div>
          </div>

          <!-- Hidden total -->
          <input type="hidden" name="totalAmount" id="totalAmount" value="${product.totalAmount}" />

          <!-- Date Fields -->
          <fmt:formatDate value="${product.manufactureDate}" pattern="yyyy-MM-dd" var="mfgDate" />
          <fmt:formatDate value="${product.expireDate}" pattern="yyyy-MM-dd" var="expDate" />
          <fmt:formatDate value="${product.purchaseDate}" pattern="yyyy-MM-dd" var="purDate" />

          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Manufacture Date</label>
              <input type="date" name="manufactureDate" value="${mfgDate}"
                     class="w-full border border-[#2955D9] rounded-lg px-4 py-3 shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Expire Date</label>
              <input type="date" name="expireDate" value="${expDate}"
                     class="w-full border border-[#2955D9] rounded-lg px-4 py-3 shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Purchase Date</label>
              <input type="date" name="purchaseDate" value="${purDate}"
                     class="w-full border border-[#2955D9] rounded-lg px-4 py-3 shadow-sm" />
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

  <!-- Auto Calculate Total JS -->
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

    updateTotal(); // Initial
  </script>
  
  <script>
  const form = document.querySelector("form");
  const manufactureDateInput = form.querySelector("input[name='manufactureDate']");
  const expireDateInput = form.querySelector("input[name='expireDate']");
  const outgoingDateInput = form.querySelector("input[name='purchaseDate']");

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
        alert("Purchasing Date cannot be before Manufacture Date.");
        outgoingDateInput.focus();
        event.preventDefault();
        return false;
      }
    }

    if (expireDateInput.value && outgoingDateInput.value) {
      if (outgoingDate > expireDate) {
        alert("Purchasing Date cannot be after Expire Date.");
        outgoingDateInput.focus();
        event.preventDefault();
        return false;
      }
    }
  });
</script>
  
</body>
</html>
