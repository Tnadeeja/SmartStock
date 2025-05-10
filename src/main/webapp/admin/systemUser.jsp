<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
<title>Outgoing Product</title>
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
    <main class="flex-1 p-6">
    
    <!-- Start -->
<div class="mt-6 space-y-6">

  <!-- Filter and Search Section in Single Column -->
  <div class="flex flex-wrap items-center gap-3">
    <input type="text" placeholder="Search by product or supplier..." class="border border-primary rounded px-4 py-2 flex-1 min-w-[250px] text-dark-blue" />

      <select class="border border-primary px-3 py-2 rounded text-dark-blue">
        <option>All Categories</option>
        <!-- Populate from backend -->
      </select>
      <select class="border border-primary px-3 py-2 rounded text-dark-blue">
        <option>All Suppliers</option>
        <!-- Populate from backend -->
      </select>

      <input type="date" class="border border-primary px-3 py-2 rounded text-dark-blue" />
      <input type="date" class="border border-primary px-3 py-2 rounded text-dark-blue" />

    <button class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark">Apply</button>
    <button type="button" onclick="window.location.href='PurchaseDashboard'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
  </div>  

  <!-- Action Buttons -->
  <div class="flex gap-4 mt-6">
    <a href="systemUser?action=add" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark flex items-center gap-2 transition">
  <i class="fas fa-plus"></i> Add
</a>
    
    <button onclick="exportTableToPDF()" class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 flex items-center gap-2 transition">
      <i class="fas fa-file-pdf"></i> Export PDF
    </button>
    <button onclick="exportTableToExcel()" class="bg-yellow-500 text-dark-blue px-4 py-2 rounded hover:bg-yellow-600 flex items-center gap-2 transition">
      <i class="fas fa-file-excel"></i> Export Excel
    </button>
  </div>

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
    <th class="px-4 py-3 text-center">Action</th>
  </tr>
</thead>
  <tbody>
    <c:forEach var="user" items="${userList}" varStatus="loop">
      <tr class="border-t text-center hover:bg-gray-50">
  <td class="px-4 py-3">${user.userId}</td>
  <td class="px-4 py-3">${user.name}</td>
  <td class="px-4 py-3">${user.phone}</td>
  <td class="px-4 py-3">${user.address}</td>
  <td class="px-4 py-3">${user.email}</td>
  <td class="px-4 py-3">${user.password}</td>
  <td class="px-4 py-3"><img src="/SmartStock/admin/assets/picture/${user.filename}" width="40"></td>
  <td class="px-4 py-3">${user.role}</td>
  <td class="px-4 py-3">${user.createdAt}</td>
  <td class="px-4 py-3">
    <div class="flex justify-center gap-2">
      <a href="systemUser?action=edit&id=${user.userId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition">Update</a>
      <a href="systemUser?action=delete&id=${user.userId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
    </div>
  </td>
</tr>
      
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
  
</body>
</html>
