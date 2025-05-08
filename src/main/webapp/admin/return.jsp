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
                                    <a href="return?action=delete&id=${returnProduct.returnId}" class="bg-red-500 text-white px-3 py-1 rounded hover:bg-red-600 transition" onclick="return confirm('Are you sure you want to delete this item?')">Delete</a>
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