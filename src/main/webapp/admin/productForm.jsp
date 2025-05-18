<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>product form</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen bg-[#f9fafb] text-gray-800 font-sans">

  <div class="flex h-full">
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 flex items-center justify-center overflow-auto px-6 py-12">
      <div class="w-full max-w-4xl space-y-12">

        <!-- Page Header -->
        <h1 class="text-3xl font-semibold text-[#142B59] border-b-2 border-[#2955D9] pb-3 text-center">
          Add Product
        </h1>

        <form action="${pageContext.request.contextPath}/admin/product" method="post" class="space-y-12">
          <c:if test="${not empty product}">
              <input type="hidden" name="id" value="${product.productId}" />
          </c:if>

          <!-- Product Name & Category -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Product Name</label>
              <input type="text" name="productName" value="${product.productName}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-2 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>

            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Category</label>
              <select name="categoryId" id="categoryId" required
                      class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-2 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm">
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

          <!-- Unit Price & Sale Price -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Unit Price</label>
              <input type="number" step="0.01" name="unitPrice" value="${product.unitPrice}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-2 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Sale Price</label>
              <input type="number" step="0.01" name="salePrice" value="${product.salePrice}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-2 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
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

</body>
</html>
