


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>purchase</title>
	<link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
    <!-- TailwindCSS for styling -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.23/jspdf.plugin.autotable.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>

<body class="bg-gray-100 text-dark-blue">

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


    <div class="flex">
        <!-- Include sidebar -->
        <jsp:include page="slideBar.jsp" />

        <!-- Main content section -->
        
        <main class="flex-1 p-4 flex flex-col min-h-screen">

      <div class="mt-6 space-y-6 flex-grow">

  <div class="flex flex-wrap items-center gap-3 justify-between">
    <!-- Left Section: Add Button -->
    <a href="PurchaseDashboard?action=add" class="bg-primary text-white px-3 py-2 rounded hover:bg-primary-dark flex items-center gap-2 transition">
      <i class="fas fa-plus"></i>
    </a>

    <!-- Center Section: Filter Form -->
    <form method="get" action="PurchaseDashboard" class="flex flex-wrap items-center gap-3 flex-grow">
  <input type="text" name="search" placeholder="Search by product or customer..." value="${param.search}"
         class="border border-primary rounded px-4 py-2 text-dark-blue flex-grow min-w-[150px]" />

  <select name="category" class="border border-primary px-3 py-2 rounded text-dark-blue">
    <option value="">All Categories</option>
    <c:forEach var="cat" items="${categoryList}">
      <option value="${cat.categoryName}" <c:if test="${param.category == cat.categoryName}">selected</c:if>>
        ${cat.categoryName}
      </option>
    </c:forEach>
  </select>


  <select name="supplier" class="border border-primary px-3 py-2 rounded text-dark-blue">
  <option value="">All Suppliers</option>
  <c:forEach var="sup" items="${supplierList}">
    <option value="${sup.name}" <c:if test="${param.supplier == sup.name}">selected</c:if>>
      ${sup.name}
    </option>
  </c:forEach>
</select>

  <label class="flex items-center gap-1 text-dark-blue">
    From:
    <input type="date" name="startDate" value="${param.startDate}" class="border border-primary rounded px-2 py-1 text-dark-blue" />
  </label>


  <label class="flex items-center gap-1 text-dark-blue">
    To:
    <input type="date" name="endDate" value="${param.endDate}" class="border border-primary rounded px-2 py-1 text-dark-blue" />
  </label>

  <button type="submit" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark">Apply</button>
  <button type="button" onclick="window.location.href='PurchaseDashboard'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
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
        
                <!-- Purchase Table -->
                <div class="bg-white shadow rounded overflow-x-auto mt-6">
                    <table class="min-w-full text-sm text-dark-blue" id="purchase-table">
                        <thead class="bg-primary text-white text-left font-semibold">
                            <tr>
                                <th class="px-4 py-3">ID</th>
                                <th class="px-4 py-3">Product Name</th>
                                <th class="px-4 py-3">Category</th>
                                <th class="px-4 py-3">Supplier</th>
                                <th class="px-4 py-3">Quantity</th>
                                <th class="px-4 py-3">Unit Price</th>
                                <th class="px-4 py-3">Total Amount</th>
                                <th class="px-4 py-3">MFG Date</th>
                                <th class="px-4 py-3">EXP Date</th>
                                <th class="px-4 py-3">Purchase Date</th>
                                <c:if test="${sessionScope.role == 'admin' || sessionScope.role == 'stock manager'}">
                                <th class="px-4 py-3">Action</th>
                                </c:if>
                            </tr>
                        </thead>
                        <tbody>
                        
                        <c:set var="pageSize" value="9" />
						<c:set var="currentPage" value="${param.page != null ? param.page + 0 : 1}" />
						<c:set var="start" value="${(currentPage - 1) * pageSize}" />
						<c:set var="end" value="${start + pageSize}" />
                        
                            <c:forEach var="product" items="${purchaseList}" varStatus="status">
                            <c:if test="${status.index ge start and status.index lt end}">
                                <tr class="border-t text-center hover:bg-gray-50">
                                    <td class="px-4 py-3">${product.purchaseId}</td>
                                    <td class="px-4 py-3">${product.productName}</td>
                                    <td class="px-4 py-3">${product.categoryName}</td>
                                    <td class="px-4 py-3">${product.supplierName}</td>
                                    <td class="px-4 py-3">${product.quantity}</td>
                                    <td class="px-4 py-3">${product.unitPrice}</td>
                                    <td class="px-4 py-3">${product.totalAmount}</td>
                                    <td class="px-4 py-3"><fmt:formatDate value="${product.manufactureDate}" pattern="yyyy-MM-dd" /></td>
                                    <td class="px-4 py-3"><fmt:formatDate value="${product.expireDate}" pattern="yyyy-MM-dd" /></td>
                                    <td class="px-4 py-3"><fmt:formatDate value="${product.purchaseDate}" pattern="yyyy-MM-dd" /></td>
                                     <c:if test="${sessionScope.role == 'admin' || sessionScope.role == 'stock manager'}">
                                    <td class="px-4 py-3">
                                
                                        <div class="flex justify-center gap-2">
                                            <a href="PurchaseDashboard?action=edit&id=${product.purchaseId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition">Update</a>
                                            <a href="PurchaseDashboard?action=delete&id=${product.purchaseId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                                        </div>
                                       
                                    </td>
                                     </c:if>
                                </tr>
                                
                                </c:if>
                            </c:forEach>

                            <c:if test="${empty purchaseList}">
                                <tr>
                                    <td colspan="11" class="text-center text-gray-500 py-6">No purchase stock found.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
            
            <div class="mt-auto flex justify-center space-x-2">
  <c:set var="totalItems" value="${fn:length(purchaseList)}" />
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
        function showAddForm() {
            window.location.href = 'PurchaseForm.jsp';
        }
    </script>
    
    <script>
    async function exportTableToPDF() {
        const { jsPDF } = window.jspdf;
        const doc = new jsPDF();

        const table = document.getElementById('purchase-table');

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
    	  var table = document.getElementById('purchase-table');
    	  var wb = XLSX.utils.table_to_book(table, { sheet: "Customers" });
    	  XLSX.writeFile(wb, 'customer_data.xlsx');
    	}
  </script>
	
</body>
</html>