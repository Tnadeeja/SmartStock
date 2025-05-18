<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.smartstock.model.AlertModel" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>alerts</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />

    <!-- TailwindCSS for styling -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Font Awesome for icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <!-- Custom CSS -->
    <style>
        /* Base Alert Box Style */
        .alert-box {
            transition: all 0.3s ease;
            padding: 1rem 1.5rem;
            margin-bottom: 1rem;
            border-radius: 0.75rem; /* Slightly rounded corners */
            box-shadow: 0px 4px 12px rgba(0, 0, 0, 0.1);
            opacity: 0.85;
            display: flex;
            align-items: center;
            background-color: white; /* White background for all alerts */
        }

        /* Icon and text layout */
        .alert-box .alert-icon {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-right: 1rem;
            font-size: 1.25rem;
        }

        .alert-box .alert-content {
            flex: 1;
        }

        .alert-box .alert-content h3 {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.25rem;
        }

        .alert-box .alert-content p {
            color: #666;
            font-size: 0.875rem;
        }

        /* Custom icon colors based on post role */
        .alert-box.admin .alert-icon {
            background-color: #f87171; /* Red background for Admin */
            color: white;
        }

        .alert-box.stock-manager .alert-icon {
            background-color: #60a5fa; /* Blue background for Stock Manager */
            color: white;
        }

        .alert-box.sales-manager .alert-icon {
            background-color: #fbbf24; /* Yellow background for Sales Manager */
            color: white;
        }

        /* Hover effects */
        .alert-box:hover {
            box-shadow: 0px 6px 20px rgba(0, 0, 0, 0.15);
        }
    </style>
</head>
<body class="bg-gray-100 text-dark-blue">

<div class="flex">
    <jsp:include page="partials/slideBar.jsp" />
    
    <main class="flex-1 p-6">

        <!-- Wrap all alerts in a space-y-6 container to add spacing between each alert -->
<div id="alert-container" class="space-y-3">
    <c:forEach var="alert" items="${alerts}">
        <div class="bg-white p-4 rounded-lg shadow-sm border border-gray-200 flex items-start gap-4">
            <!-- Icon with dynamic color based on post -->
            <div class="w-10 h-10 rounded-full flex items-center justify-center
                        ${alert.post == 'admin' ? 'bg-red-100 text-red-600' :
                          alert.post == 'stock manager' ? 'bg-blue-100 text-blue-600' :
                          alert.post == 'sales manager' ? 'bg-yellow-100 text-yellow-500' : 
                          'bg-gray-100 text-gray-600'}">
                <i class="fas fa-bell"></i>
            </div>

            <!-- Text content -->
            <div class="flex-1">
                <!-- Message first -->
                <p class="text-lg font-semibold text-gray-800 mb-2">
                    ${alert.description}
                </p>

                <!-- Name, post, and email below in uniform gray -->
                <h3 class="text-sm text-gray-210 text-right whitespace-nowrap">
                    ${alert.name}
                    <span class="mx-1">|</span>
                    ${alert.post}
                    <span class="mx-1">•</span>
                    ${alert.email}
                </h3>
            </div>
        </div>
    </c:forEach>
</div>
<!-- Hidden No Alerts Message -->
<div id="no-alerts-message" class="text-center text-gray-500 mt-10 text-lg hidden">
    No alerts available at the moment.
</div>
    </main>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        const alertContainer = document.getElementById("alert-container");
        const noAlertsMessage = document.getElementById("no-alerts-message");

        // Check if the container has any children (i.e., any alert boxes)
        if (!alertContainer.hasChildNodes() || alertContainer.children.length === 0) {
            noAlertsMessage.classList.remove("hidden");
        }
    });
</script>


</body>
</html>