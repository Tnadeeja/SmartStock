<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Profile</title>

    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 text-dark-blue p-6">
    <div class="bg-white shadow rounded-lg p-6 max-w-3xl mx-auto">
        <h1 class="text-3xl font-bold mb-6">Your Profile</h1>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
                <label class="block font-medium text-lg">Email</label>
                <p class="text-lg">${user.email}</p>
            </div>
            <div>
                <label class="block font-medium text-lg">Role</label>
                <p class="text-lg">${user.role}</p>
            </div>
            <div>
                <label class="block font-medium text-lg">Profile Picture</label>
                <img src="uploads/${user.filename}" alt="Profile Picture" class="w-32 h-32 rounded-full object-cover">
            </div>
            <div>
                <label class="block font-medium text-lg">Account Created</label>
                <p class="text-lg">
                    <fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </p>
            </div>
        </div>
    </div>
</body>
</html>