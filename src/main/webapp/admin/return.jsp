<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>return</title>
<link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.28/jspdf.plugin.autotable.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

<style>
        @keyframes moveFromLeftToRight {
            0% {
                opacity: 0;
                transform: translateX(-100%);
            }
            80% {
                opacity: 1;
                transform: translateX(5%);
            }
            100% {
                opacity: 1;
                transform: translateX(0);
            }
        }

        @keyframes fadeOut {
            0% {
                opacity: 1;
            }
            100% {
                opacity: 0;
                transform: translateX(100%);
            }
        }

        .animate-move-right {
            animation: moveFromLeftToRight 1s ease-out forwards;
        }

        .animate-fade-out {
            animation: fadeOut 1s ease-in forwards;
        }
    </style>
</head>
<body class="bg-gray-100 text-dark-blue">

<%
    String message = (String) request.getAttribute("message");
    String status = (String) request.getAttribute("status");

    String bgColor = "bg-[#0A4DA6]";  // Default info
    String iconSVG = "<svg xmlns='http://www.w3.org/2000/svg' class='h-5 w-5 text-white' fill='none' viewBox='0 0 24 24' stroke='currentColor'><path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M13 16h-1v-4h-1m1-4h.01M12 20.5C6.753 20.5 2.5 16.247 2.5 11S6.753 1.5 12 1.5 21.5 5.753 21.5 11 17.247 20.5 12 20.5z' /></svg>";

    if (status != null) {
        switch (status) {
            case "success-add":
                bgColor = "bg-green-600";
                iconSVG = "<svg xmlns='http://www.w3.org/2000/svg' class='h-6 w-6 text-white' fill='none' viewBox='0 0 24 24' stroke='currentColor'><path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 13l4 4L19 7' /></svg>";
                break;
            case "success-update":
                bgColor = "bg-yellow-500"; // Lightened the yellow
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
%>
    

    <div id="flashMessage" class="fixed bottom-0 left-0 z-50 flex items-center justify-center w-full bg-black bg-opacity-30 transition-opacity duration-300">
        <div class="message-box max-w-full w-full px-5 py-3 rounded-lg shadow-md text-white text-base flex items-center gap-3 <%= bgColor %> animate-move-right">
            <div><%= iconSVG %></div>
            <span><%= message %></span>
        </div>
    </div>

    <script>
        setTimeout(() => {
            const msg = document.getElementById("flashMessage");
            if (msg) {
                const box = msg.querySelector(".message-box");
                box.classList.remove("animate-move-right");
                box.classList.add("animate-fade-out");
                setTimeout(() => msg.remove(), 1000); // Remove after fade-out
            }
        }, 3000);  // Message disappears after 3 seconds
    </script>
<%
    }
%>

<div class="flex">
    <jsp:include page="partials/slideBar.jsp" />

    <main class="flex-1 p-4 flex flex-col min-h-screen">

      <div class="mt-6 space-y-6 flex-grow">

  <div class="flex flex-wrap items-center gap-3 justify-between">

    <!-- Center Section: Filter Form -->
    <form method="get" action="return" class="flex flex-wrap items-center gap-3 flex-grow">
  <input type="text" name="search" placeholder="Search by product..." value="${param.search}"
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
  <button type="button" onclick="window.location.href='return'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
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
                <table class="min-w-full text-sm text-dark-blue" id="return-table">
                    <thead class="bg-primary text-white text-left font-semibold">
                        <tr>
                            <th class="px-4 py-3 text-center">ID</th>
                            <th class="px-4 py-3 text-center">Product Name</th>
                            <th class="px-4 py-3 text-center">Quantity</th>
                            <th class="px-4 py-3 text-center">Reason</th>
                            <th class="px-4 py-3 text-center">Return Date</th>
                            <c:if test="${sessionScope.role == 'admin' || sessionScope.role == 'sales manager'}">
                            <th class="px-4 py-3 text-center">Action</th>
                            </c:if>
                        </tr>
                    </thead>
                    <tbody>
                    
                    <c:set var="pageSize" value="11" />
						<c:set var="currentPage" value="${param.page != null ? param.page + 0 : 1}" />
						<c:set var="start" value="${(currentPage - 1) * pageSize}" />
						<c:set var="end" value="${start + pageSize}" />
                    
                        <c:forEach var="returnProduct" items="${returnProductList}" varStatus="status"><!-- varStatus="loop" has been remove -->
                        <c:if test="${status.index ge start and status.index lt end}">
                            <tr class="border-t text-center hover:bg-gray-50">
                                <td class="px-4 py-3">${returnProduct.returnId}</td>
                                <td class="px-4 py-3">${returnProduct.productName}</td>
                                <td class="px-4 py-3">${returnProduct.quantity}</td>
                                <td class="px-4 py-3">${returnProduct.reason}</td>
                                <td class="px-4 py-3"><fmt:formatDate value="${returnProduct.returnDate}" pattern="yyyy-MM-dd" /></td>
                                <c:if test="${sessionScope.role == 'admin' || sessionScope.role == 'sales manager'}">
                                <td class="px-4 py-3">
                                    <a href="return?action=edit&id=${returnProduct.returnId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition ml-2">Add Reason</a>
                                    <a href="return?action=delete&id=${returnProduct.returnId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                                </td>
                                </c:if>
                                
                            </tr>
                            </c:if>
                        </c:forEach>
                        <c:if test="${empty returnProductList}">
                            <tr>
                                <td colspan="6" class="text-center text-gray-500 py-6">No return stock found.</td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>

        <script>
            function showAddForm() {
                window.location.href = '<c:url value="outgoingForm.jsp?action=add" />';
            }
        </script>
        
        <div class="mt-auto flex justify-center space-x-2">
  <c:set var="totalItems" value="${fn:length(returnProductList)}" />
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

        const table = document.getElementById('return-table');

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
    	  var table = document.getElementById('return-table');
    	  var wb = XLSX.utils.table_to_book(table, { sheet: "Customers" });
    	  XLSX.writeFile(wb, 'customer_data.xlsx');
    	}
  </script>
  
  <script>
//This script filters the return product table based on search and date inputs

  window.addEventListener("DOMContentLoaded", () => {
    const form = document.querySelector("form[action='return']");
    const searchInput = form.querySelector("input[name='search']");
    const startDateInput = form.querySelector("input[name='startDate']");
    const endDateInput = form.querySelector("input[name='endDate']");
    const applyButton = form.querySelector("button[type='submit']");
    const clearButton = form.querySelector("button[type='button']");
    const tableRows = document.querySelectorAll("#return-table tbody tr");

    applyButton.addEventListener("click", (e) => {
      e.preventDefault();
      filterTable();
    });

    clearButton.addEventListener("click", () => {
      searchInput.value = "";
      startDateInput.value = "";
      endDateInput.value = "";
      filterTable();
    });

    function filterTable() {
      const searchValue = searchInput.value.toLowerCase();
      const startDate = new Date(startDateInput.value);
      const endDate = new Date(endDateInput.value);

      tableRows.forEach((row) => {
        const productName = row.cells[1]?.innerText.toLowerCase();
        const returnDateStr = row.cells[4]?.innerText;
        const returnDate = new Date(returnDateStr);

        const matchSearch =
          !searchValue || (productName && productName.includes(searchValue));

        const matchStart = !startDateInput.value || returnDate >= startDate;
        const matchEnd = !endDateInput.value || returnDate <= endDate;

        if (matchSearch && matchStart && matchEnd) {
          row.style.display = "";
        } else {
          row.style.display = "none";
        }
      });
    }
  });
  </script>

</body>
</html>