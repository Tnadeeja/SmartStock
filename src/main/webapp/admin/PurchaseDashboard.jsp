


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


    <div class="flex">
        <!-- Include sidebar -->
        <jsp:include page="slideBar.jsp" />

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