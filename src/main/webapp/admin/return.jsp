<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Return Product</title>
<script src="https://cdn.tailwindcss.com"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="bg-gray-100 text-dark-blue">

<div class="flex">
    <jsp:include page="partials/slideBar.jsp" />

    <main class="flex-1 p-6">
        
        <!-- Start -->
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
                <button class="bg-red-600 text-white px-4 py-2 rounded hover:bg-red-700 flex items-center gap-2 transition">
                    <i class="fas fa-file-pdf"></i> Export PDF
                </button>
                <button class="bg-yellow-500 text-dark-blue px-4 py-2 rounded hover:bg-yellow-600 flex items-center gap-2 transition">
                    <i class="fas fa-file-excel"></i> Export Excel
                </button>
            </div>

            <!-- Purchase Stock Table -->
            <div class="bg-white shadow rounded overflow-x-auto mt-6">
                <table class="min-w-full text-sm text-dark-blue">
                    <thead class="bg-primary text-white text-left font-semibold">
                        <tr>
                            <th class="px-4 py-3">ID</th>
                            <th class="px-4 py-3">Product Name</th>
                            <th class="px-4 py-3">Quantity</th>
                            <th class="px-4 py-3">Reason</th>
                            <th class="px-4 py-3">Return Date</th>
                            <th class="px-4 py-3">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="returnProduct" items="${returnProductList}" varStatus="loop">
                            <tr class="border-t text-center hover:bg-gray-50">
                                <td class="px-4 py-3">${returnProduct.returnId}</td>
                                <td class="px-4 py-3">${returnProduct.productName}</td>
                                <td class="px-4 py-3">${returnProduct.quantity}</td>
                                <td class="px-4 py-3">${returnProduct.reason}</td>
                                <td class="px-4 py-3">${returnProduct.returnDate}</td>
                                <td class="px-4 py-3">
                                    <a href="return?action=edit&id=${returnProduct.returnId}" class="bg-primary text-white px-3 py-1 rounded hover:bg-primary-dark transition ml-2">Add Reason</a>
                                </td>
                            </tr>
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
    </main>
</div>
</body>
</html>