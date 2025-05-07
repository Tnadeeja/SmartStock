<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <style>
        .bg-primary { background-color: #2955D9; }
        .hover\:bg-primary-dark:hover { background-color: #2964D9; }
        .text-primary { color: #2955D9; }
        .text-dark-blue { color: #142B59; }
        .border-primary { border-color: #0A4DA6; }
        .bg-dark-blue { background-color: #142B59; }
    </style>
</head>
<body class="font-sans">
<!-- Sidebar -->
<aside class="w-64 bg-gray-900 text-gray-300 min-h-screen p-3 space-y-4">

	<!-- User Profile Section -->
        <div class="flex items-center gap-3 p-4 bg-dark-blue rounded-lg shadow-sm border border-gray-700">
            <!-- Profile Picture -->
            <div class="w-14 h-14 rounded-full overflow-hidden border-2 border-blue-400">
                <img src="https://i.pravatar.cc/50?img=5" alt="User Profile" class="w-full h-full object-cover">
            </div>
            <!-- User Details -->
            <div class="flex flex-col">
                <span class="text-xl font-bold text-white">John Doe</span>
                <span class="text-sm text-blue-300">Sales Manager</span>
            </div>
        </div>
    
    <nav class="space-y-2">
        <!-- Dashboard -->
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="flex items-center px-3 py-2 rounded-lg bg-primary text-white">
            <i class="fas fa-tachometer-alt mr-3 text-white"></i>
            Dashboard
        </a>

        <!-- Category -->
        <a href="${pageContext.request.contextPath}/admin/category" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-th-list mr-3 text-gray-400"></i>
            Category
        </a>

        <!-- Product -->
        <a href="#" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-cogs mr-3 text-gray-400"></i>
            Product
        </a>

        <!-- Customer -->
        <a href="#" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-users mr-3 text-gray-400"></i>
            Customer
        </a>

        <!-- Supplier -->
        <a href="#" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-truck mr-3 text-gray-400"></i>
            Supplier
        </a>

        <!-- Purchase Product -->
        <a href="${pageContext.request.contextPath}/admin/PurchaseDashboard" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-cart-plus mr-3 text-gray-400"></i>
            Purchase Product
        </a>

        <!-- Outgoing Product -->
        <a href="${pageContext.request.contextPath}/admin/outgoing" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-truck-moving mr-3 text-gray-400"></i>
            Outgoing Product
        </a>

        <!-- Return Product -->
        <a href="${pageContext.request.contextPath}/admin/return" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-undo mr-3 text-gray-400"></i>
            Return Product
        </a>

        <!-- Divider -->
        <hr class="border-gray-700 my-3">

        <!-- Notification -->
        <a href="#" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-bell mr-3 text-gray-400"></i>
            Notification
        </a>

        <!-- System Users -->
        <a href="#" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-users-cog mr-3 text-gray-400"></i>
            System Users
        </a>

        <!-- Support -->
        <a href="${pageContext.request.contextPath}/admin/supportHandler" class="flex items-center px-3 py-2 rounded-lg hover:bg-gray-800 hover:text-primary transition">
            <i class="fas fa-life-ring mr-3 text-gray-400"></i>
            Support
        </a>

        <!-- Log Out -->
        <a href="${pageContext.request.contextPath}/admin/login.jsp" class="flex items-center px-3 py-2 rounded-lg hover:bg-red-600 hover:text-white transition">
            <i class="fas fa-sign-out-alt mr-3 text-gray-400"></i>
            Log Out
        </a>
    </nav>
</aside>
</body>
</html>