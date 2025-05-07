<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications</title>

    <!-- TailwindCSS for styling -->
    <script src="https://cdn.tailwindcss.com"></script>
    
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf-autotable/3.5.23/jspdf.plugin.autotable.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Custom Script for Tabs -->
    <script>
        function switchTab(tabName) {
            // Hide all tabs
            document.querySelectorAll('.tab-content').forEach(tab => tab.classList.add('hidden'));

            // Remove active class from all tabs
            document.querySelectorAll('.tab').forEach(tab => tab.classList.remove('text-blue-600', 'border-blue-500', 'bg-blue-50'));

            // Show the selected tab
            document.getElementById(tabName).classList.remove('hidden');

            // Mark the selected tab as active
            document.getElementById(tabName + '-tab').classList.add('text-blue-600', 'border-blue-500', 'bg-blue-50');
        }
    </script>

    <style>
        .tab {
            transition: all 0.2s ease;
        }

        .tab:hover {
            background-color: #f0f9ff; /* Light blue on hover */
            cursor: pointer;
        }

        .tab:focus {
            outline: none;
            box-shadow: 0 0 0 2px rgba(59, 130, 246, 0.5); /* Blue focus outline */
        }
    </style>
    
</head>
<body class="bg-gray-100 min-h-screen font-sans">
    
	<div class="flex">
        <!-- Include sidebar -->
        <jsp:include page="partials/slideBar.jsp" />
        <!-- Main Content -->
        <main class="flex-1 p-6">

            <!-- Tabs for switching -->
            <div class="flex space-x-4 mb-6 border-b border-gray-300">
                <!-- User Notifications Tab -->
                <button id="user-tab" class="tab text-lg font-semibold py-2 px-4 border-b-2 border-transparent text-gray-600" onclick="switchTab('user')">
                    Your Notifications
                </button>
                <!-- Admin Notifications Tab -->
                <button id="admin-tab" class="tab text-lg font-semibold py-2 px-4 border-b-2 border-transparent text-gray-600" onclick="switchTab('admin')">
                    Admin Notifications
                </button>
            </div>

            <!-- Notification Content Sections -->
            <section>
                <!-- User Notifications Section -->
                <div id="user" class="tab-content hidden">
                    <div class="space-y-4 mt-4">
                        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 flex items-start gap-4">
                            <div class="w-10 h-10 rounded-full bg-blue-100 flex items-center justify-center text-blue-600">
                                <i class="fas fa-bell"></i>
                            </div>
                            <div class="flex-1">
                                <h3 class="font-bold text-gray-800">New Product Added</h3>
                                <p class="text-sm text-gray-600">A new product has been added to your inventory.</p>
                                <span class="text-xs text-gray-400">5 mins ago</span>
                            </div>
                        </div>
                        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 flex items-start gap-4">
                            <div class="w-10 h-10 rounded-full bg-green-100 flex items-center justify-center text-green-600">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="flex-1">
                                <h3 class="font-bold text-gray-800">Task Completed</h3>
                                <p class="text-sm text-gray-600">You successfully updated product information.</p>
                                <span class="text-xs text-gray-400">2 hours ago</span>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Admin Notifications Section -->
                <div id="admin" class="tab-content hidden">
                    <div class="space-y-4 mt-4">
                        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 flex items-start gap-4">
                            <div class="w-10 h-10 rounded-full bg-red-100 flex items-center justify-center text-red-600">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="flex-1">
                                <h3 class="font-bold text-gray-800">Stock Alert</h3>
                                <p class="text-sm text-gray-600">Some products are running low on stock.</p>
                                <span class="text-xs text-gray-400">1 day ago</span>
                            </div>
                        </div>
                        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 flex items-start gap-4">
                            <div class="w-10 h-10 rounded-full bg-yellow-100 flex items-center justify-center text-yellow-600">
                                <i class="fas fa-user-plus"></i>
                            </div>
                            <div class="flex-1">
                                <h3 class="font-bold text-gray-800">New User Registered</h3>
                                <p class="text-sm text-gray-600">A new user has joined the system.</p>
                                <span class="text-xs text-gray-400">2 days ago</span>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </main>
    </div>

    <script>
        // Default to show User Notifications when page loads
        window.onload = function() {
            switchTab('user');
        }
    </script>
</body>
</html>