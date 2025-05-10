<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Category</title>
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

    <main class="flex-1 p-6">
      <div class="mt-6 space-y-6">

        <!-- Filter and Search Section -->
        <div class="flex flex-wrap items-center gap-3">
          <input type="text" placeholder="Search by product or supplier..." class="border border-primary rounded px-4 py-2 flex-1 min-w-[250px] text-dark-blue" />
          <select class="border border-primary px-3 py-2 rounded text-dark-blue">
            <option>All Categories</option>
          </select>
          <select class="border border-primary px-3 py-2 rounded text-dark-blue">
            <option>All Suppliers</option>
          </select>
          <input type="date" class="border border-primary px-3 py-2 rounded text-dark-blue" />
          <input type="date" class="border border-primary px-3 py-2 rounded text-dark-blue" />
          <button class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark">Apply</button>
          <button type="button" onclick="window.location.href='PurchaseDashboard'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
        </div>

        <!-- Action Buttons -->
        <div class="flex gap-4 mt-6">
          <button onclick="showAddForm()" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark flex items-center gap-2 transition">
            <i class="fas fa-plus"></i> Add
          </button>
          <button onclick="exportTableToPDF()" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 flex items-center gap-2 transition">
    		<i class="fas fa-file-pdf"></i> Export PDF
		  </button>
          <button onclick="exportTableToExcel()" class="bg-yellow-500 text-dark-blue px-4 py-2 rounded hover:bg-yellow-600 flex items-center gap-2 transition">
    		<i class="fas fa-file-excel"></i> Export Excel
		  </button>
        </div>

        <!-- Responsive 4-Column Grid -->
        <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-6">
          <c:forEach var="category" items="${categoryList}">
            <div class="bg-white shadow-md rounded-xl p-5 border border-gray-200 hover:shadow-lg transition">
              <div class="flex items-center justify-between mb-3">
                <div class="text-primary text-xl">
                  <i class="fas fa-tag"></i>
                </div>
                <div class="text-sm bg-primary text-white px-3 py-1 rounded-full">
                  ID: ${category.categoryId}
                </div>
              </div>
              <div class="text-center">
                <p class="text-lg font-semibold text-dark-blue mb-2">${category.categoryName}</p>
              </div>
              <div class="flex justify-center gap-2 mt-4">
                <a href="category?action=edit&id=${category.categoryId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition text-sm">Update</a>
                <a href="category?action=delete&id=${category.categoryId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition text-sm" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
              </div>
            </div>
          </c:forEach>

          <c:if test="${empty categoryList}">
            <div class="col-span-full text-center text-gray-500 py-6">No category found.</div>
          </c:if>
        </div>

        <!-- Hidden table for export -->
        <table id="exportTable" class="hidden">
          <thead>
            <tr>
              <th>ID</th>
              <th>Category Name</th>
            </tr>
          </thead>
          <tbody>
            <c:forEach var="category" items="${categoryList}">
              <tr>
                <td>${category.categoryId}</td>
                <td>${category.categoryName}</td>
              </tr>
            </c:forEach>
          </tbody>
        </table>

      </div>

      <script>
        function showAddForm() {
          window.location.href = '<c:url value="categoryForm.jsp?action=add" />';
        }
      </script>

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
          doc.save('category_data.pdf');
        }
      </script>

      <script>
        function exportTableToExcel() {
          var table = document.getElementById('exportTable');
          var wb = XLSX.utils.table_to_book(table, { sheet: "Categories" });
          XLSX.writeFile(wb, 'category_data.xlsx');
        }
      </script>
    </main>
  </div>
</body>
</html>