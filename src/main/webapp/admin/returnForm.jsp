<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add Reason</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen bg-[#f9fafb] text-gray-800 font-sans">

  <div class="flex h-[calc(100vh-64px)]">
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 p-6 flex flex-col space-y-8">

      <div class="flex-1 flex flex-col">

        <form action="${pageContext.request.contextPath}/admin/return" method="post" class="space-y-12">

          <!-- Hidden ID field for updates -->
          <c:if test="${not empty returnProduct}">
            <input type="hidden" name="id" value="${returnProduct.returnId}" />
          </c:if>

          <!-- Product Info -->
          <div>
            <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Product Name</label>
            <input type="text" name="productName" value="${returnProduct.productName}" required
                   class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
          </div>

          <!-- Quantity and Return Date -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <!-- Quantity -->
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Quantity</label>
              <input type="number" name="quantity" value="${returnProduct.quantity}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>

            <!-- Return Date -->
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Return Date</label>
              <input type="date" name="returnDate"
                     value="<fmt:formatDate value='${returnProduct.returnDate}' pattern='yyyy-MM-dd' />"
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
          </div>

          <!-- Reason -->
          <div>
            <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Reason</label>
            <textarea name="reason" rows="3"
                      class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm"
                      placeholder="Enter reason for return (if any)">${returnProduct.reason}</textarea>
          </div>

          <!-- Buttons -->
          <div class="pt-4 mt-auto">
            <div class="flex justify-end space-x-6">
              <button type="submit"
                      class="bg-[#0A4DA6] hover:bg-[#0D448C] text-white font-medium px-6 py-2 rounded-full shadow transition">
                <i class="fas fa-save mr-2"></i>Save
              </button>
              <button type="button" onclick="window.history.back()"
                      class="border border-[#142B59] text-[#142B59] hover:bg-[#142B59] hover:text-white font-medium px-6 py-2 rounded-full transition">
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
