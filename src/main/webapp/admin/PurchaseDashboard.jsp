


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SmartStock Admin Dashboard</title>

    <!-- TailwindCSS for styling -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body>
 <jsp:include page="partials/header.jsp" />
 
 <div class="flex">
  <jsp:include page="partials/slideBar.jsp" />


    <div class="flex">
        <!-- Include sidebar -->
        <jsp:include page="slideBar.jsp" />

        <!-- Main content section -->
        <main class="flex-1 p-6">
            <!-- Start of content section -->
            <div class="mt-6 space-y-6">

                <!-- Filter Form -->
                <form method="get" action="PurchaseDashboard" class="flex flex-wrap items-center gap-3">
                    <input type="text" name="search" placeholder="Search by product or supplier..." value="${param.search}" class="border border-gray-300 rounded px-4 py-2 flex-1 min-w-[250px]" />

                    <!-- Category dropdown -->
                    <select name="category" class="border px-3 py-2 rounded">
                        <option value="">All Categories</option>
                        <c:forEach var="cat" items="${categoryList}">
                            <option value="${cat}" <c:if test="${param.category == cat}">selected</c:if>>${cat}</option>
                        </c:forEach>
                    </select>

                    <!-- Supplier dropdown -->
                    <select name="supplier" class="border px-3 py-2 rounded">
                        <option value="">All Suppliers</option>
                        <c:forEach var="sup" items="${supplierList}">
                            <option value="${sup}" <c:if test="${param.supplier == sup}">selected</c:if>>${sup}</option>
                        </c:forEach>
                    </select>

                    <!-- Date filter inputs -->
                    <input type="date" name="startDate" value="${param.startDate}" class="border px-3 py-2 rounded" />
                    <input type="date" name="endDate" value="${param.endDate}" class="border px-3 py-2 rounded" />





                    <!-- Submit button -->
                    <button type="submit" class="bg-blue-600 text-white px-4 py-2 rounded">Apply</button>
                    <!-- Clear Filters -->
    				<button type="button" onclick="window.location.href='PurchaseDashboard'" class="bg-gray-500 text-white px-4 py-2 rounded">Clear</button>
                </form>


                <!-- Action buttons -->
                <div class="flex gap-4 mt-6">
                    <button onclick="showAddForm()" class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 flex items-center gap-2 transition">
                        <i class="fas fa-plus"></i> Add
                    </button>
                    <button class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 flex items-center gap-2 transition">
                        <i class="fas fa-file-pdf"></i> Export PDF
                    </button>
                    <button class="bg-yellow-500 text-white px-4 py-2 rounded hover:bg-yellow-600 flex items-center gap-2 transition">
                        <i class="fas fa-file-excel"></i> Export Excel
                    </button>
                </div>

                <!-- Purchase Table -->
                <div class="bg-white shadow rounded overflow-x-auto mt-6">
                    <table class="min-w-full text-sm text-gray-700">
                        <thead class="bg-gray-100 text-left font-semibold">
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
                                        <a href="PurchaseDashboard?action=edit&id=${product.purchaseId}" class="bg-blue-500 text-white px-3 py-1 rounded hover:bg-blue-600 transition">Update</a>
                                        <a href="PurchaseDashboard?action=delete&id=${product.purchaseId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition ml-2" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
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
            <!-- End content section -->
        </main>
    </div>

    <script>
        function showAddForm() {
            window.location.href = 'PurchaseForm.jsp';
        }
    </script>
</body>
</html>