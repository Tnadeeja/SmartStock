<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>supplier</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
</head>
<body class="bg-gray-100 text-dark-blue">

<%
    String message = (String) session.getAttribute("message");
    String status = (String) session.getAttribute("status");

    String bgColor = "bg-[#0A4DA6]";
    String iconSVG = "<svg xmlns='http://www.w3.org/2000/svg' class='h-5 w-5 text-white' fill='none' viewBox='0 0 24 24' stroke='currentColor'><path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M13 16h-1v-4h-1m1-4h.01M12 20.5C6.753 20.5 2.5 16.247 2.5 11S6.753 1.5 12 1.5 21.5 5.753 21.5 11 17.247 20.5 12 20.5z' /></svg>";

    if (status != null) {
        switch (status) {
            case "success-add":
                bgColor = "bg-green-600";
                iconSVG = "<svg xmlns='http://www.w3.org/2000/svg' class='h-6 w-6 text-white' fill='none' viewBox='0 0 24 24' stroke='currentColor'><path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 13l4 4L19 7' /></svg>";
                break;
            case "success-update":
                bgColor = "bg-yellow-500";
                iconSVG = "<svg xmlns='http://www.w3.org/2000/svg' class='h-6 w-6 text-white' fill='none' viewBox='0 0 24 24' stroke='currentColor'><path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M4 4v6h6M20 20v-6h-6M4 20l6-6M20 4l-6 6' /></svg>";
                break;
            case "success-delete":
                bgColor = "bg-red-600";
                iconSVG = "<svg xmlns='http://www.w3.org/2000/svg' class='h-6 w-6 text-white' fill='none' viewBox='0 0 24 24' stroke='currentColor'><path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M6 18L18 6M6 6l12 12' /></svg>";
                break;
            case "error":
                bgColor = "bg-red-700";
                iconSVG = "<svg xmlns='http://www.w3.org/2000/svg' class='h-6 w-6 text-white' fill='none' viewBox='0 0 24 24' stroke='currentColor'><path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M12 8v4m0 4h.01M12 2a10 10 0 100 20 10 10 0 000-20z' /></svg>";
                break;
        }
    }
%>

<style>
    @keyframes moveFromLeftToRight {
        0% { opacity: 0; transform: translateX(-100%); }
        80% { opacity: 1; transform: translateX(5%); }
        100% { opacity: 1; transform: translateX(0); }
    }

    @keyframes fadeOut {
        0% { opacity: 1; }
        100% { opacity: 0; transform: translateX(100%); }
    }

    .animate-move-right {
        animation: moveFromLeftToRight 1s ease-out forwards;
    }

    .animate-fade-out {
        animation: fadeOut 1s ease-in forwards;
    }
</style>

<% if (message != null) { %>
<div id="flashMessage" class="fixed bottom-0 left-0 z-50 flex items-center justify-center w-full bg-black bg-opacity-30 transition-opacity duration-300">
    <div class="message-box max-w-full w-full px-5 py-3 rounded-lg shadow-md text-white text-base flex items-center gap-3 <%= bgColor %> animate-move-right">
        <div><%= iconSVG %></div>
        <span><%= message %></span>
    </div>
</div>
<% } %>

<script>
    setTimeout(() => {
        const msg = document.getElementById("flashMessage");
        if (msg) {
            const box = msg.querySelector(".message-box");
            box.classList.remove("animate-move-right");
            box.classList.add("animate-fade-out");
            setTimeout(() => msg.remove(), 1000);
        }
    }, 3000);
</script>

<%
    session.removeAttribute("message");
    session.removeAttribute("status");
%>
 
 <div class="flex">
  <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content placeholder -->
    <main class="flex-1 p-4 flex flex-col min-h-screen">

      <div class="mt-6 space-y-6 flex-grow">

  <div class="flex flex-wrap items-center gap-3 justify-between">
    <!-- Left Section: Add Button -->
    <c:if test="${sessionScope.role == 'admin' || sessionScope.role == 'stock manager'}">
    <a href="supplier?action=add" class="bg-primary text-white px-3 py-2 rounded hover:bg-primary-dark flex items-center gap-2 transition">
      <i class="fas fa-plus"></i>
    </a>
    </c:if>

    <!-- Center Section: Filter Form -->
    <form method="get" action="supplier" class="flex flex-wrap items-center gap-3 flex-grow">
      <input type="text" name="search" placeholder="Search by supplier..." value="${param.search}"
             class="border border-primary rounded px-4 py-2 text-dark-blue flex-grow min-w-[150px]" />

      <select name="address" class="border border-primary px-3 py-2 rounded text-dark-blue">
        <option value="">All Address</option>
        <c:forEach var="cat" items="${addressList}">
          <option value="${cat}" <c:if test="${param.address == cat}">selected</c:if>>${cat}</option>
        </c:forEach>
      </select>

      <button type="submit" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark">Apply</button>
      <button type="button" onclick="window.location.href='supplier'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
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

     <!-- Customer Table -->
            <div class="bg-white shadow rounded overflow-x-auto mt-4">
            <table class="min-w-full text-sm text-dark-blue" id="supplier-table">
    <thead class="bg-primary text-white text-left font-semibold">
        <tr>
            <th class="px-4 py-3 text-center">ID</th>
            <th class="px-4 py-3 text-center">Name</th>
            <th class="px-4 py-3 text-center">Email</th>
            <th class="px-4 py-3 text-center">Phone</th>
            <th class="px-4 py-3 text-center">Address</th>
            <c:if test="${sessionScope.role == 'admin' || sessionScope.role == 'stock manager'}">
            <th class="px-4 py-3 text-center">Action</th>
            </c:if>
        </tr>
    </thead>
    <tbody>
    
    	<c:set var="pageSize" value="9" />
		<c:set var="currentPage" value="${param.page != null ? param.page + 0 : 1}" />
		<c:set var="start" value="${(currentPage - 1) * pageSize}" />
		<c:set var="end" value="${start + pageSize}" />
		
        <c:forEach var="supplier" items="${supplierList}" varStatus="status">
        <c:if test="${status.index ge start and status.index lt end}">
            <tr class="border-t text-center hover:bg-gray-50">
                <td class="px-4 py-3">${supplier.supplierId}</td>
                <td class="px-4 py-3">${supplier.name}</td>
                <td class="px-4 py-3">${supplier.email}</td>
                <td class="px-4 py-3">${supplier.phone}</td>
                <td class="px-4 py-3">${supplier.address}</td>
                 <c:if test="${sessionScope.role == 'admin' || sessionScope.role == 'stock manager'}">
                <td class="px-4 py-3">
               
                    <div class="flex justify-center gap-2">
                        <a href="supplier?action=edit&id=${supplier.supplierId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition">Update</a>
                        <a href="supplier?action=delete&id=${supplier.supplierId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                    </div>
                   
                </td>
                 </c:if>
            </tr>
        </c:if>
        </c:forEach>
        <c:if test="${empty supplierList}">
            <tr>
                <td colspan="6" class="text-center text-gray-500 py-6">No suppliers found.</td>
            </tr>
        </c:if>
    </tbody>
</table>
            
            </div>
        </div>


    <div class="mt-auto flex justify-center space-x-2">
  <c:set var="totalItems" value="${fn:length(supplierList)}" />
  <c:set var="totalPages" value="${(totalItems / pageSize) + (totalItems % pageSize > 0 ? 1 : 0)}" />
  <c:forEach var="i" begin="1" end="${totalPages}">
    <a href="?page=${i}&search=${param.search}&address=${param.address}&supplier=${param.supplier}&startDate=${param.startDate}&endDate=${param.endDate}"
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

        const table = document.getElementById('supplier-table');

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
    	  var table = document.getElementById('supplier-table');
    	  var wb = XLSX.utils.table_to_book(table, { sheet: "Customers" });
    	  XLSX.writeFile(wb, 'customer_data.xlsx');
    	}
  </script>
  
</body>
</html>