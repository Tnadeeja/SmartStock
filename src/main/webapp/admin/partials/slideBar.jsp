<%
    String name = (String) session.getAttribute("name");
    String role = (String) session.getAttribute("role");
    String picture = (String) session.getAttribute("filename");
    String currentPage = request.getRequestURI(); // Get the current page URI
%>

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
        .active-tab { background-color: #2955D9; color: white; }
        .hover\:bg-primary-dark:hover { background-color: #2964D9; }
    </style>
</head>
<body class="font-sans">
<!-- Sidebar -->
<aside class="w-64 bg-gray-900 text-gray-300 min-h-screen p-3 space-y-4">

    <!-- User Profile Section -->
    <div class="flex items-center gap-3 p-4 bg-dark-blue rounded-lg shadow-sm border border-gray-700">
        <!-- Profile Picture -->
        <div class="w-14 h-14 rounded-full overflow-hidden border-2 border-blue-400">
            <img src="/SmartStock/admin/assets/picture/${user.filename}" width="100">
        </div>
        <!-- User Details -->
        <div class="flex flex-col">
            <span class="text-xl font-bold text-white"><%= name %></span>
            <span class="text-sm text-blue-300"><%= role %></span>
        </div>
    </div>
    
    <nav class="space-y-2">
        <!-- Dashboard -->
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("dashboard") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-tachometer-alt mr-3 text-white"></i>
            Dashboard
        </a>

        <!-- Category -->
        <a href="${pageContext.request.contextPath}/admin/category" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("category") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-th-list mr-3 text-white"></i>
            Category
        </a>

        <!-- Product -->
        <a href="${pageContext.request.contextPath}/admin/product" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("product") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-cogs mr-3 text-white"></i>
            Product
        </a>

        <!-- Customer -->
        <a href="#" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("customer") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-users mr-3 text-white"></i>
            Customer
        </a>

        <!-- Supplier -->
        <a href="#" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("supplier") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-truck mr-3 text-white"></i>
            Supplier
        </a>

        <!-- Purchase Product -->
        <a href="${pageContext.request.contextPath}/admin/PurchaseDashboard" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("PurchaseDashboard") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-cart-plus mr-3 text-white"></i>
            Purchase Product
        </a>

        <!-- Outgoing Product -->
        <a href="${pageContext.request.contextPath}/admin/outgoing" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("outgoing") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-truck-moving mr-3 text-white"></i>
            Outgoing Product
        </a>

        <!-- Return Product -->
        <a href="${pageContext.request.contextPath}/admin/return" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("return") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-undo mr-3 text-white"></i>
            Return Product
        </a>

        <!-- Divider -->
        <hr class="border-gray-700 my-3">

        <!-- Notification -->
        <a href="#" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("notification") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-bell mr-3 text-white"></i>
            Notification
        </a>

        <!-- System Users -->
        <a href="${pageContext.request.contextPath}/admin/systemUser" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("systemUser") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-users-cog mr-3 text-white"></i>
            System Users
        </a>

        <!-- Support -->
        <a href="${pageContext.request.contextPath}/admin/supportHandler" class="flex items-center px-3 py-2 rounded-lg <%= currentPage.contains("supportHandler") ? "active-tab" : "hover:bg-gray-800 hover:text-primary" %>">
            <i class="fas fa-life-ring mr-3 text-white"></i>
            Support
        </a>

        <!-- Log Out -->
        <a href="${pageContext.request.contextPath}/admin/login.jsp" class="flex items-center px-3 py-2 rounded-lg hover:bg-red-600 hover:text-white transition">
            <i class="fas fa-sign-out-alt mr-3 text-white"></i>
            Log Out
        </a>
    </nav>
</aside>
</body>
</html>