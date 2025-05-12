<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    String picture = (String) session.getAttribute("filename");
    String email = (String) session.getAttribute("email");
    String currentPage = request.getRequestURI(); // Get the current page URI
%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Support Form</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="min-h-screen bg-gray-100">

<div class="flex min-h-screen">
    <!-- Sidebar -->
    <div class="w-64 bg-gray-900 text-white">
        <jsp:include page="partials/slideBar.jsp" />
    </div>

    <!-- Main Content -->
    <main class="flex-1 p-5">

        <!-- Support Contact Info -->
        <div class="bg-gradient-to-r from-blue-500 to-indigo-600 text-white shadow-lg rounded-lg p-4 mb-4">
            <h2 class="text-2xl font-semibold mb-2">Need Assistance? We're Here to Help!</h2>
            <p class="mb-4 text-base">Our support team is available to assist you. Please use the contact methods below to get in touch with us:</p>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                <div class="flex items-start bg-white text-gray-800 p-4 rounded-lg shadow hover:bg-gray-50">
                    <i class="fas fa-phone-alt text-green-600 text-2xl mr-4 mt-1"></i>
                    <div>
                        <h3 class="font-semibold">Emergency Phone</h3>
                        <p class="text-sm">For urgent matters, call us directly.</p>
                        <p class="text-sm font-bold">${emergencyPhone}</p>
                    </div>
                </div>

                <div class="flex items-start bg-white text-gray-800 p-4 rounded-lg shadow hover:bg-gray-50">
                    <i class="fas fa-phone text-[#dc2626] text-2xl mr-4 mt-1"></i>
                    <div>
                        <h3 class="font-semibold">Hotline</h3>
                        <p class="text-sm">For general inquiries, reach our hotline.</p>
                        <p class="text-sm font-bold">${hotline}</p>
                    </div>
                </div>

                <div class="flex items-start bg-white text-gray-800 p-4 rounded-lg shadow hover:bg-gray-50">
                    <i class="fas fa-envelope text-[#2955D9] text-2xl mr-4 mt-1"></i>
                    <div>
                        <h3 class="font-semibold">Support Email</h3>
                        <p class="text-sm">You can also reach us by email.</p>
                        <p class="text-sm font-bold">${supportEmail}</p>
                    </div>
                </div>
            </div>

			 <c:if test="${sessionScope.role == 'admin'}">
            <div class="flex justify-end mt-6">
                <button onclick="toggleEditForm()" class="bg-yellow-600 text-white px-4 py-2 rounded hover:bg-yellow-500 flex items-center gap-2 transition">
                    <i class="fas fa-edit mr-2"></i>Edit Contact Information
                </button>
            </div>
            </c:if>
        </div>

		<!-- Edit Contact Modal -->
<div id="editContactForm" class="fixed inset-0 z-50 flex items-center justify-center bg-white/70 backdrop-blur-sm hidden transition-opacity duration-300">
    <div class="relative bg-white rounded-2xl shadow-2xl w-full max-w-md p-6 border-t-8 border-[#0A4DA6]">
        <!-- Close Button -->
        <button onclick="toggleEditForm()" class="absolute top-3 right-3 text-[#142B59] hover:text-[#2955D9] transition-colors">
            <i class="fas fa-times text-lg"></i>
        </button>

        <!-- Header -->
        <h3 class="text-2xl font-semibold text-[#142B59] mb-5">Edit Contact Information</h3>

        <!-- Form -->
        <form action="${pageContext.request.contextPath}/admin/supportHandler" method="post" class="space-y-4 text-[#0D448C]">
            <input type="hidden" name="action" value="updateContact">

            <!-- Emergency Phone -->
            <div>
                <label class="block font-medium mb-1">Emergency Phone</label>
                <input type="text" name="emergencyPhone" value="${emergencyPhone}"
                       class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:border-[#2955D9] transition-all">
            </div>

            <!-- Hotline -->
            <div>
                <label class="block font-medium mb-1">Hotline</label>
                <input type="text" name="hotline" value="${hotline}"
                       class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:border-[#2955D9] transition-all">
            </div>

            <!-- Support Email -->
            <div>
                <label class="block font-medium mb-1">Support Email</label>
                <input type="email" name="supportEmail" value="${supportEmail}"
                       class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:border-[#2955D9] transition-all">
            </div>

            <!-- Submit Button -->
            <div class="flex justify-end pt-3">
                <button type="submit" class="bg-[#2955D9] hover:bg-[#2964D9] text-white px-5 py-2 rounded-xl shadow-md transition">
                    <i class="fas fa-save mr-2"></i>Update
                </button>
            </div>
        </form>
    </div>
</div>

        <!-- Support Request Form -->
    <!-- Support Request Form -->
<form action="${pageContext.request.contextPath}/admin/supportHandler" method="post" class="space-y-6">
    <input type="hidden" name="action" value="submitSupportRequest" />

    <!-- Name, Post, Email Row -->
    <div class="grid grid-cols-1 md:grid-cols-3 gap-4">
        <div>
            <label class="block text-gray-700 font-medium mb-1">Name</label>
            <input type="text" name="name" required 
                   value="<%= name != null ? name : "" %>"
                   class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:border-[#2955D9] transition">
        </div>

        <div>
            <label class="block text-gray-700 font-medium mb-1">Post</label>
            <input type="text" name="post" required 
                   value="<%= role != null ? role : "" %>"
                   class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:border-[#2955D9] transition">
        </div>

        <div>
            <label class="block text-gray-700 font-medium mb-1">Email Address</label>
            <input type="email" name="email" required 
                   value="<%= email != null ? email : "" %>"
                   class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:border-[#2955D9] transition">
        </div>
    </div>

    <!-- Issue Description -->
    <div>
        <label class="block text-gray-700 font-medium mb-1">Issue Description</label>
        <textarea name="description" rows="4" required 
                  class="w-full border border-gray-300 rounded-xl px-4 py-2 focus:outline-none focus:border-[#2955D9] transition"></textarea>
    </div>

    <!-- Submit Button -->
    <div class="flex justify-end">
        <button type="submit" 
                class="bg-[#2955D9] hover:bg-[#2964D9] text-white px-6 py-2 rounded-xl shadow transition-all">
            <i class="fas fa-paper-plane mr-2"></i>Submit
        </button>
    </div>
</form>
    </main>
</div>
<!-- Modal Toggle Script -->
<script>
    function toggleEditForm() {
        const modal = document.getElementById('editContactForm');
        modal.classList.toggle('hidden');
    }
</script>
</body>
</html>