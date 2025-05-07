<%
    String role = (String) session.getAttribute("role");
    if (role == null || !role.equals("admin")) {
        response.sendRedirect(request.getContextPath() + "/admin/unauthorized.jsp");
        return;
    }
%>



<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>SmartStock Admin Dashboard</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="bg-gray-100 font-sans">
 
 <div class="flex">
  <jsp:include page="partials/slideBar.jsp" />
 
 

    <!-- Main content placeholder -->
    <main class="flex-1 p-6">
      
    </main>

  </div>
</body>
</html>
