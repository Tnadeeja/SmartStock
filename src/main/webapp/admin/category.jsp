<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>category</title>
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

  <div class="flex min-h-screen flex-col">

    <div class="flex flex-1">
      <jsp:include page="partials/slideBar.jsp" />

      <main class="flex-1 p-4 flex flex-col min-h-screen">

        <div class="mt-6 space-y-6 flex-grow">

          <!-- Combined Toolbar (search filters etc) -->
          <div class="flex flex-wrap items-center gap-3 justify-between">
            <!-- Left Section: Add Button -->
            <c:if test="${sessionScope.role == 'admin'}">
              <button onclick="showAddForm()" class="bg-primary text-white px-3 py-2 rounded hover:bg-primary-dark flex items-center gap-2 transition">
                <i class="fas fa-plus"></i>
              </button>
            </c:if>

            <!-- Center Section: Filter Form -->
            <form method="get" action="category" class="flex flex-wrap items-center gap-3 flex-grow">
              <input
                type="text"
                name="search"
                placeholder="Search by category..."
                value="${param.search}"
                class="border border-primary rounded px-4 py-2 text-dark-blue flex-grow min-w-[150px]"
              />

              <!-- Category filter not needed here (listing categories) so just omit -->

              <!-- You had supplier and date filters in original, but categories page likely does not need them,
                   so I'll keep the form minimal with just search -->

              <button type="submit" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark">Apply</button>
              <button type="button" onclick="window.location.href='category'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
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

          <!-- Categories Grid -->

          <c:set var="pageSize" value="12" />
          <c:set var="currentPage" value="${param.page != null ? param.page : 1}" />
          <c:set var="start" value="${(currentPage - 1) * pageSize}" />
          <c:set var="end" value="${start + pageSize}" />

          <c:set var="searchTerm" value="${fn:toLowerCase(param.search)}" />

          <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 mt-6 flex-grow overflow-auto">
            <c:set var="filteredIndex" value="0" />
            <c:forEach var="category" items="${categoryList}">
              <c:if test="${param.search == null || param.search == '' || fn:contains(fn:toLowerCase(category.categoryName), searchTerm)}">
                <c:if test="${filteredIndex >= start && filteredIndex < end}">
                  <div class="bg-gray-50 border border-gray-300 shadow hover:shadow-xl transition-all duration-300 rounded-2xl p-5 group relative h-[160px] flex flex-col justify-between">
                    <div class="flex items-center justify-between mb-3">
                      <div class="text-primary text-xl">
                        <i class="fas fa-tag"></i>
                      </div>
                      <div class="text-sm bg-primary text-white px-3 py-1 rounded-full opacity-0 group-hover:opacity-100 transition">
                        ID: ${category.categoryId}
                      </div>
                    </div>
                    <div class="text-center">
                      <p class="text-lg font-semibold text-gray-800 mb-2">${category.categoryName}</p>
                    </div>
                    <c:if test="${sessionScope.role == 'admin'}">
                      <div class="flex justify-center gap-2 mt-4 opacity-0 group-hover:opacity-100 transition">
                        <a href="category?action=edit&id=${category.categoryId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition text-sm">Update</a>
                        <a href="category?action=delete&id=${category.categoryId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition text-sm" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                      </div>
                    </c:if>
                  </div>
                </c:if>
                <c:set var="filteredIndex" value="${filteredIndex + 1}" />
              </c:if>
            </c:forEach>

            <c:if test="${filteredIndex == 0}">
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

        <!-- Pagination Controls fixed to bottom -->
        <c:set var="totalItems" value="${fn:length(categoryList)}" />
        <c:set var="totalPages" value="${(totalItems / pageSize) + (totalItems % pageSize > 0 ? 1 : 0)}" />
        <div class="mt-4 flex justify-center space-x-2 mt-auto">
          <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="?page=${i}&search=${param.search}"
               class="px-3 py-1 rounded border
                      ${i == currentPage ? 'bg-primary text-white border-primary' : 'bg-white text-dark-blue border-gray-300'}
                      hover:bg-primary hover:text-white hover:border-primary transition">
              ${i}
            </a>
          </c:forEach>
        </div>

      </main>
    </div>
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

</body>
</html>