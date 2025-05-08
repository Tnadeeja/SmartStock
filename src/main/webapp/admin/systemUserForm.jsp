<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add New User</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen">

  <div class="flex h-[calc(100vh-64px)]">
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 p-6 flex flex-col">
      <div class="flex-1 flex flex-col">

<form action="${pageContext.request.contextPath}/admin/systemUser" method="post" class="flex-1 flex flex-col space-y-6">

  <!-- Hidden ID field for updates -->
  <c:if test="${not empty user}">
    <input type="hidden" name="id" value="${user.userId}" />
  </c:if>

  <!-- Email -->
  <div>
    <label class="block text-gray-700 font-medium mb-1">Email</label>
    <input type="email" name="email" value="${not empty user ? user.email : ''}" required
           class="w-full border border-[#2955D9] rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#0A4DA6]" />
  </div>

  <!-- Password -->
  <div>
    <label class="block text-gray-700 font-medium mb-1">Password</label>
    <input type="password" name="password" value="${not empty user ? user.password : ''}" required
           class="w-full border border-[#2955D9] rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#0A4DA6]" />
  </div>

  <!-- Filename -->
  <div>
    <label class="block text-gray-700 font-medium mb-1">Filename</label>
    <input type="text" name="filename" value="${not empty user ? user.filename : ''}"
           class="w-full border border-[#2955D9] rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#0A4DA6]" />
  </div>

  <!-- Role -->
  <div>
    <label class="block text-gray-700 font-medium mb-1">Role</label>
    <select name="role" required
            class="w-full border border-[#2955D9] rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-[#0A4DA6]">
      <option value="">-- Select Role --</option>
      <option value="Admin" ${not empty user && user.role == 'Admin' ? 'selected' : ''}>Admin</option>
      <option value="Stock Manager" ${not empty user && user.role == 'Stock Manager' ? 'selected' : ''}>Stock Manager</option>
      <option value="Sales Manager" ${not empty user && user.role == 'Sales Manager' ? 'selected' : ''}>Sales Manager</option>
    </select>
  </div>

  <!-- Created At (Read-only, only shown on edit) -->
  <c:if test="${not empty user.createdAt}">
    <div>
      <label class="block text-gray-700 font-medium mb-1">Created At</label>
      <input type="text" value="${user.createdAt}" readonly
             class="w-full bg-gray-100 border border-[#2955D9] rounded px-4 py-2" />
    </div>
  </c:if>

  <!-- Buttons -->
  <div class="pt-4 mt-auto">
    <div class="flex justify-end space-x-4">
      <button type="submit" class="bg-[#0A4DA6] text-white px-6 py-2 rounded hover:bg-[#0D448C] transition-all">
        <i class="fas fa-save mr-2"></i>Save
      </button>
      <button type="button" onclick="window.history.back()" class="bg-[#142B59] text-white px-6 py-2 rounded hover:bg-[#0D448C] transition-all">
        Discard
      </button>
    </div>
  </div>
</form>

      </div>
    </main>
  </div>

</body>
</html>
