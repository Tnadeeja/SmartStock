<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>product</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <!-- jsPDF and AutoTable -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.25/jspdf.plugin.autotable.min.js"></script>
  <!-- SheetJS for Excel export -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
</head>
<body class="bg-gray-100 text-dark-blue">
 
 <div class="flex">
  <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content placeholder -->
    <main class="flex-1 p-4 flex flex-col min-h-screen">
    
    <!-- Start -->

<div class="mt-6 space-y-6 flex-grow">

  <!-- Combined Toolbar -->
  <div class="flex flex-wrap items-center gap-3 justify-between">
    <!-- Left Section: Add Button -->
    <a href="product?action=add" class="bg-primary text-white px-3 py-2 rounded hover:bg-primary-dark flex items-center gap-2 transition">
      <i class="fas fa-plus"></i>
    </a>

    <!-- Center Section: Filter Form -->
    <form method="get" action="product" class="flex flex-wrap items-center gap-3 flex-grow">
  <input type="text" name="search" placeholder="Search by product..." value="${param.search}"
         class="border border-primary rounded px-4 py-2 text-dark-blue flex-grow min-w-[150px]" />

  <select name="category" class="border border-primary px-3 py-2 rounded text-dark-blue">
    <option value="">All Categories</option>
    <c:forEach var="cat" items="${categoryList}">
      <option value="${cat.categoryName}" <c:if test="${param.category == cat.categoryName}">selected</c:if>>
        ${cat.categoryName}
      </option>
    </c:forEach>
  </select>

  <button type="submit" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark">Apply</button>
  <button type="button" onclick="window.location.href='product'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
</form>


    <!-- Export Dropdown -->
  <div class="relative">
    <button onclick="toggleExportDropdown()" class="bg-gray-600 text-white px-3 py-2 rounded hover:bg-gray-700 transition">
      <i class="fas fa-print"></i>
    </button>
    <div id="exportDropdown" class="absolute right-0 mt-2 w-36 bg-white border rounded shadow-lg hidden z-10">
      <button onclick="exportTableToPDF()" class="block w-full text-left px-4 py-2 hover:bg-gray-100 text-sm">
        <i class="fas fa-file-pdf text-red-600 mr-2"></i> Export PDF
      </button>
      <button onclick="exportTableToExcel()" class="block w-full text-left px-4 py-2 hover:bg-gray-100 text-sm">
        <i class="fas fa-file-excel text-green-600 mr-2"></i> Export Excel
      </button>
    </div>
  </div>
</div>

<script>
  function toggleExportDropdown() {
    const dropdown = document.getElementById("exportDropdown");
    dropdown.classList.toggle("hidden");
  }
</script>
	
  <!-- Product Table -->
      <div class="bg-white shadow rounded overflow-x-auto mt-6">
        <table class="min-w-full text-sm text-dark-blue">
          <thead class="bg-primary text-white text-left font-semibold">
            <tr>
              <th class="px-4 py-3 text-center">ID</th>
              <th class="px-4 py-3 text-center">Product Name</th>
              <th class="px-4 py-3 text-center">Category</th>
              <th class="px-4 py-3 text-center">Unit Price</th>
              <th class="px-4 py-3 text-center">Sale Price</th>
              <c:if test="${sessionScope.role == 'admin'}">
              <th class="px-4 py-3 text-center">Action</th>
              </c:if>
            </tr>
          </thead>
          <tbody>
            <c:set var="pageSize" value="9" />
            <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
            <c:set var="start" value="${(currentPage - 1) * pageSize}" />
            <c:set var="end" value="${start + pageSize}" />

            <c:forEach var="product" items="${productList}" varStatus="status">
              <c:if test="${status.index >= start && status.index < end}">
                <tr class="border-t text-center hover:bg-gray-50">
                  <td class="px-4 py-3">${product.productId}</td>
                  <td class="px-4 py-3">${product.productName}</td>
                  <td class="px-4 py-3">${product.categoryName}</td>
                  <td class="px-4 py-3">${product.unitPrice}</td>
                  <td class="px-4 py-3">${product.salePrice}</td>
                  <c:if test="${sessionScope.role == 'admin'}">
                  <td class="px-4 py-3">
                    <div class="flex justify-center gap-2">
                      <a href="product?action=edit&id=${product.productId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition">Update</a>
                      <a href="product?action=delete&id=${product.productId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                    </div>
                  </td>
                  </c:if>
                </tr>
              </c:if>
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

<!-- Pagination Controls at bottom -->
<div class="mt-auto flex justify-center space-x-2">
  <c:set var="totalItems" value="${fn:length(productList)}" />
  <c:set var="totalPages" value="${(totalItems / pageSize) + (totalItems % pageSize > 0 ? 1 : 0)}" />
  <c:forEach var="i" begin="1" end="${totalPages}">
    <a href="?page=${i}&search=${param.search}&category=${param.category}&supplier=${param.supplier}&startDate=${param.startDate}&endDate=${param.endDate}"
       class="px-3 py-1 rounded border
              ${i == currentPage ? 'bg-primary text-white border-primary' : 'bg-white text-dark-blue border-gray-300'}
              hover:bg-primary hover:text-white hover:border-primary transition">
      ${i}
    </a>
  </c:forEach>
</div>

      <!-- Hidden table for export (without 'Action' column) -->
      <table id="exportTable" class="hidden">
        <thead>
          <tr>
            <th>ID</th>
            <th>Product Name</th>
            <th>Category</th>
            <th>Unit Price</th>
            <th>Sale Price</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="product" items="${productList}">
            <tr>
              <td>${product.productId}</td>
              <td>${product.productName}</td>
              <td>${product.categoryName}</td>
              <td>${product.unitPrice}</td>
              <td>${product.salePrice}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>

    
    </main>

  </div>

  <script>
    async function exportTableToPDF() {
      const { jsPDF } = window.jspdf;
      const doc = new jsPDF();
      doc.autoTable({
        html: '#exportTable',
        theme: 'grid',
        headStyles: { fillColor: [41, 85, 217] },
        styles: { fontSize: 9 }
      });
      doc.save('product_data.pdf');
    }

    function exportTableToExcel() {
      var table = document.getElementById('exportTable');
      var wb = XLSX.utils.table_to_book(table, { sheet: "Products" });
      XLSX.writeFile(wb, 'product_data.xlsx');
    }
  </script>

</body>
</html>