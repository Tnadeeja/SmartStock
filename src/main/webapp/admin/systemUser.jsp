<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<% 
    String picture = (String) session.getAttribute("filename"); 
    if (picture == null) {
        picture = "default.png";  // Fallback to a default image if no picture is set
    }
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>system user</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
</head>
<body class="bg-gray-100 text-dark-blue">
 
 <div class="flex">
  <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content placeholder -->
    <main class="flex-1 p-4 flex flex-col min-h-screen">

      <div class="mt-6 space-y-6 flex-grow">

  <div class="flex flex-wrap items-center gap-3 justify-between">
    <!-- Left Section: Add Button -->
    <a href="systemUser?action=add" class="bg-primary text-white px-3 py-2 rounded hover:bg-primary-dark flex items-center gap-2 transition">
      <i class="fas fa-plus"></i>
    </a>

    <!-- Center Section: Filter Form -->
    <form method="get" action="systemUser" class="flex flex-wrap items-center gap-3 flex-grow">
  <input type="text" name="search" placeholder="Search by product or customer..." value="${param.search}"
         class="border border-primary rounded px-4 py-2 text-dark-blue flex-grow min-w-[150px]" />

  <label class="flex items-center gap-1 text-dark-blue">
    From:
    <input type="date" name="startDate" value="${param.startDate}" class="border border-primary rounded px-2 py-1 text-dark-blue" />
  </label>

  <label class="flex items-center gap-1 text-dark-blue">
    To:
    <input type="date" name="endDate" value="${param.endDate}" class="border border-primary rounded px-2 py-1 text-dark-blue" />
  </label>

  <button type="submit" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark">Apply</button>
  <button type="button" onclick="window.location.href='systemUser'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
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

  <!-- Purchase Stock Table -->
  <div class="bg-white shadow rounded overflow-x-auto mt-6">
<table class="min-w-full text-sm text-dark-blue" id="system-table">
  <thead class="bg-primary text-white text-left font-semibold">
  <tr>
    <th class="px-4 py-3 text-center">ID</th>
    <th class="px-4 py-3 text-center">Name</th>
    <th class="px-4 py-3 text-center">Phone</th>
    <th class="px-4 py-3 text-center">Address</th>
    <th class="px-4 py-3 text-center">Email</th>
    <th class="px-4 py-3 text-center">Password</th>
    <th class="px-4 py-3 text-center">Picture</th>
    <th class="px-4 py-3 text-center">User Role</th>
    <th class="px-4 py-3 text-center">Created Date</th>
  	<c:if test="${sessionScope.role == 'admin'}">
    <th class="px-4 py-3 text-center">Action</th>
    </c:if>
  </tr>
</thead>
  <tbody>
  <c:set var="pageSize" value="7" />
						<c:set var="currentPage" value="${param.page != null ? param.page + 0 : 1}" />
						<c:set var="start" value="${(currentPage - 1) * pageSize}" />
						<c:set var="end" value="${start + pageSize}" />
						
    <c:forEach var="user" items="${userList}" varStatus="status"><!-- varStatus="loop" has been removed -->
    <c:if test="${status.index ge start and status.index lt end}">
      <tr class="border-t text-center hover:bg-gray-50">
  <td class="px-4 py-3">${user.userId}</td>
  <td class="px-4 py-3">${user.name}</td>
  <td class="px-4 py-3">${user.phone}</td>
  <td class="px-4 py-3">${user.address}</td>
  <td class="px-4 py-3">${user.email}</td>
  <td class="px-4 py-3">${user.password}</td>
  <td class="px-4 py-3"><img src="/SmartStock/admin/assets/picture/${user.filename}" width="40"></td>
  <td class="px-4 py-3">${user.role}</td>
  <td class="px-4 py-3">
    <fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd" />
  </td>
  <c:if test="${sessionScope.role == 'admin'}">
  <td class="px-4 py-3">
    <div class="flex justify-center gap-2">
    
      <a href="systemUser?action=edit&id=${user.userId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition">Update</a>
      <a href="systemUser?action=delete&id=${user.userId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
      
    </div>
  </td>
  </c:if>
</tr>
      </c:if>
    </c:forEach>
    <c:if test="${empty userList}">
      <tr>
        <td colspan="11" class="text-center text-gray-500 py-6">No users found.</td>
      </tr>
    </c:if>
  </tbody>
</table>

  </div>
</div>

<script>
  function showAddForm() {
    window.location.href = '<c:url value="systemUserForm.jsp?action=add" />';
  }
</script>
<!-- End -->
    
    
    <div class="mt-auto flex justify-center space-x-2">
  <c:set var="totalItems" value="${fn:length(userList)}" />
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
    
    </main>

  </div>
  
          <script>
    async function exportTableToPDF() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        const table = document.getElementById('system-table');

        const headers = [];
        const data = [];

        // Get headers (excluding last column)
        const headerCells = table.querySelectorAll('thead tr th');
        headerCells.forEach((th, index) => {
          if (index < headerCells.length - 1) { // exclude last column
            headers.push(th.innerText.trim());
          }
        });

        // Get rows
        const rows = table.querySelectorAll('tbody tr');
        rows.forEach(row => {
          const rowData = [];
          const cells = row.querySelectorAll('td');
          cells.forEach((td, index) => {
            if (index < cells.length - 1) { // exclude last column
              rowData.push(td.innerText.trim());
            }
          });
          if (rowData.length > 0) {
            data.push(rowData);
          }
        });

        // Generate PDF
        doc.autoTable({
          head: [headers],
          body: data,
          theme: 'grid',
          headStyles: { fillColor: [10, 77, 166] },
          styles: { fontSize: 9 }
        });

        doc.save('customer_data.pdf');
      }

    	function exportTableToExcel() {
    	  var table = document.getElementById('system-table');
    	  var wb = XLSX.utils.table_to_book(table, { sheet: "Customers" });
    	  XLSX.writeFile(wb, 'customer_data.xlsx');
    	}
  </script>
  
    <script>
window.addEventListener("DOMContentLoaded", () => {
  const form = document.querySelector("form[action='systemUser']");
  const searchInput = form.querySelector("input[name='search']");
  const startDateInput = form.querySelector("input[name='startDate']");
  const endDateInput = form.querySelector("input[name='endDate']");
  const applyButton = form.querySelector("button[type='submit']");
  const clearButton = form.querySelector("button[type='button']");
  const tableRows = document.querySelectorAll("#system-table tbody tr");

  function filterTable() {
    const searchValue = searchInput.value.toLowerCase();
    const startDateVal = startDateInput.value;
    const endDateVal = endDateInput.value;
    const startDate = startDateVal ? new Date(startDateVal) : null;
    const endDate = endDateVal ? new Date(endDateVal) : null;

    tableRows.forEach(row => {
      const nameCell = row.cells[1]?.innerText.toLowerCase();
      const createdDateText = row.cells[8]?.innerText;
      const createdDate = createdDateText ? new Date(createdDateText) : null;

      const matchesSearch = !searchValue || nameCell.includes(searchValue);
      const matchesStart = !startDate || (createdDate && createdDate >= startDate);
      const matchesEnd = !endDate || (createdDate && createdDate <= endDate);

      if (matchesSearch && matchesStart && matchesEnd) {
        row.style.display = "";
      } else {
        row.style.display = "none";
      }
    });
  }

  applyButton.addEventListener("click", (e) => {
    e.preventDefault();
    filterTable();
  });

  clearButton.addEventListener("click", (e) => {
    e.preventDefault();
    searchInput.value = "";
    startDateInput.value = "";
    endDateInput.value = "";
    filterTable();
  });
});
</script>
  
</body>
</html>
