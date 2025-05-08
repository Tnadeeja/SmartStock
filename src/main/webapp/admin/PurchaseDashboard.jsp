<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartStock Admin Dashboard</title>

    <!-- TailwindCSS for styling -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.23/jspdf.plugin.autotable.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
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
%>

    <div class="flex">
        <!-- Include sidebar -->
        <jsp:include page="partials/slideBar.jsp" />

        <!-- Main content section -->
        <main class="flex-1 p-6">
            <div class="mt-6 space-y-6">

                <!-- Filter Form -->
                <form method="get" action="PurchaseDashboard" class="flex flex-wrap items-center gap-3">
                    <input type="text" name="search" placeholder="Search by product or supplier..." value="${param.search}" class="border border-primary rounded px-4 py-2 flex-1 min-w-[250px] text-dark-blue" />

                    <select name="category" class="border border-primary px-3 py-2 rounded text-dark-blue">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat}" <c:if test="${param.category == cat}">selected</c:if>>${cat}</option>
                        </c:forEach>
                    </select>

                    <select name="supplier" class="border border-primary px-3 py-2 rounded text-dark-blue">
                        <option value="">All Suppliers</option>
                        <c:forEach var="sup" items="${supplierList}">
                            <option value="${sup}" <c:if test="${param.supplier == sup}">selected</c:if>>${sup}</option>
                        </c:forEach>
                    </select>

                    <input type="date" name="startDate" value="${param.startDate}" class="border border-primary px-3 py-2 rounded text-dark-blue" />
                    <input type="date" name="endDate" value="${param.endDate}" class="border border-primary px-3 py-2 rounded text-dark-blue" />

                    <button type="submit" class="bg-primary text-white px-4 py-2 rounded hover:bg-primary-dark">Apply</button>
                    <button type="button" onclick="window.location.href='PurchaseDashboard'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
                </form>

                <!-- Action buttons -->
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

                <!-- Purchase Table -->
                <div class="bg-white shadow rounded overflow-x-auto mt-6">
                    <table class="min-w-full text-sm text-dark-blue">
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
                                <th class="px-4 py-3">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="product" items="${purchaseList}">
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
                                    <td class="px-4 py-3">
                                        <div class="flex justify-center gap-2">
                                            <a href="PurchaseDashboard?action=edit&id=${product.purchaseId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition">Update</a>
                                            <a href="PurchaseDashboard?action=delete&id=${product.purchaseId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
                                        </div>
                                    </td>
                                </tr>
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

        doc.autoTable({
            html: 'table', // targets the first <table> in the DOM
            theme: 'grid',
            headStyles: { fillColor: [41, 85, 217] }, // match your Tailwind primary
            styles: { fontSize: 8 },
        });

        	doc.save('purchase_data.pdf');
    	}
	</script>
	
	<script>
    	function exportTableToExcel() {
        	var table = document.querySelector('table');
        	var wb = XLSX.utils.table_to_book(table, { sheet: "Purchase Data" });
        	XLSX.writeFile(wb, 'purchase_data.xlsx');
    	}
	</script>
	
</body>
</html>