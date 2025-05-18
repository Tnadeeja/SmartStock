<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <title>unauthorized</title>
    <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="min-h-screen flex items-center justify-center bg-gradient-to-br from-[#0A4DA6] via-[#2955D9] to-[#142B59] text-white">
    <div class="text-center bg-white/10 backdrop-blur-md p-10 rounded-xl shadow-2xl max-w-md w-full">
        <div class="text-6xl font-extrabold mb-4 text-white">403</div>
        <h1 class="text-2xl font-semibold mb-2">Access Denied</h1>
        <p class="mb-6 text-sm text-white/80">You do not have permission to access this page.</p>
        <a href="${pageContext.request.contextPath}/admin/login.jsp"
           class="inline-block px-5 py-2 bg-white text-[#2955D9] font-semibold rounded-full hover:bg-[#E0E7FF] transition">
            Return to Login
        </a>
    </div>
</body>
</html>