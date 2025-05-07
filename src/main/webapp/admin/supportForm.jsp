<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Support Form</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen bg-gray-100">

    <div class="flex h-full">
        <!-- Sidebar (Assuming sidebar is already included) -->
        <jsp:include page="partials/slideBar.jsp" />

        <!-- Main content -->
        <main class="flex-1 p-6">

            <!-- Redesigned Emergency Contact Info Section -->
            <div class="bg-gradient-to-r from-blue-500 to-indigo-600 text-white shadow-lg rounded-lg p-4 mb-4">
    <h2 class="text-xl font-semibold mb-3">Need Assistance? We're Here to Help!</h2>
    <p class="mb-4 text-base">Our support team is available to assist you. Please use the contact methods below to get in touch with us:</p>
    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
        <!-- Emergency Phone -->
        <div class="flex items-center bg-white text-gray-800 p-3 rounded-lg shadow hover:bg-gray-50 transition">
            <i class="fas fa-phone-alt text-green-500 text-2xl mr-5"></i> <!-- Increased gap -->
            <div>
                <h3 class="font-semibold text-base">Emergency Phone</h3>
                <p class="text-sm">For urgent matters, call us directly.</p>
                <p class="text-sm font-bold">(123) 456-7890</p>
            </div>
        </div>

        <!-- Hotline -->
        <div class="flex items-center bg-white text-gray-800 p-3 rounded-lg shadow hover:bg-gray-50 transition">
            <i class="fas fa-phone text-red-500 text-2xl mr-5"></i> <!-- Increased gap -->
            <div>
                <h3 class="font-semibold text-base">Hotline</h3>
                <p class="text-sm">For general inquiries, reach our hotline.</p>
                <p class="text-sm font-bold">(987) 654-3210</p>
            </div>
        </div>

        <!-- Support Email -->
        <div class="flex items-center bg-white text-gray-800 p-3 rounded-lg shadow hover:bg-gray-50 transition">
            <i class="fas fa-envelope text-blue-500 text-2xl mr-5"></i> <!-- Increased gap -->
            <div>
                <h3 class="font-semibold text-base">Support Email</h3>
                <p class="text-sm">You can also reach us by email for assistance.</p>
                <p class="text-sm font-bold">support@example.com</p>
            </div>
        </div>
    </div>
    <p class="mt-4 text-base">If you cannot find a solution through the form, please don't hesitate to use any of these methods.</p>
</div>

            <!-- Support Form -->
            <form action="${pageContext.request.contextPath}/admin/supportHandler" method="post" class="space-y-6">
                <div>
                    <label class="block text-gray-700 font-medium mb-1">Full Name</label>
                    <input type="text" name="name" required class="w-full border border-gray-300 rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">
                </div>

                <div>
                    <label class="block text-gray-700 font-medium mb-1">Email Address</label>
                    <input type="email" name="email" required class="w-full border border-gray-300 rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400">
                </div>

                <div>
                    <label class="block text-gray-700 font-medium mb-1">Issue Description</label>
                    <textarea name="description" rows="4" required class="w-full border border-gray-300 rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400"></textarea>
                </div>

                <div class="flex justify-end">
    <button type="submit" class="bg-blue-600 text-white px-6 py-2 rounded hover:bg-blue-700 transition-all">
        <i class="fas fa-paper-plane mr-2"></i>Submit
    </button>
</div>
            </form>
        </main>
    </div>

</body>
</html>