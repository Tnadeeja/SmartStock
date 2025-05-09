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

  <div class="flex h-[calc(100vh-64px)]"> <!-- Assuming header is 64px high -->
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 p-6 flex flex-col"> <!-- ✅ Added 'flex flex-col' -->
      <div class="flex-1 flex flex-col">

        <form action="${pageContext.request.contextPath}/admin/product" method="post" class="flex-1 flex flex-col space-y-6">
          <!-- Hidden ID field for updates -->
          <c:if test="${not empty product}">
              <input type="hidden" name="id" value="${product.productId}" />
          </c:if>

           <!-- Product Name -->
          <div>
            <label class="block text-gray-700 font-medium mb-1">Product Name</label>
            <input type="text" name="productName" value="${product.productName}" required
                   class="w-full border border-[#2955D9] rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#0A4DA6]" />
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
          </div>

          <!-- Price -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
     
              <div>
                  <label class="block text-gray-700 font-medium mb-1">Unit Price</label>
                  <input type="number" step="0.01" name="unitPrice" id="unitPrice" value="${product.unitPrice}" required
                         class="w-full border border-[#2955D9] rounded px-4 py-2" />
              </div>
              <div>
                  <label class="block text-gray-700 font-medium mb-1">Sale Price</label>
                  <input type="number" step="0.01" id="salePrice" name="salePrice" value="${product.salePrice}" required
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

</body>
</html>
