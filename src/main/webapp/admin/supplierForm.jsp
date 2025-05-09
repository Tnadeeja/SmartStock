<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add New Customer</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen">

  <div class="flex h-[calc(100vh-64px)]"> <!-- Assuming header is 64px high -->
    <jsp:include page="partials/slideBar.jsp" /> <!-- Sidebar -->

    <!-- Main content -->
    <main class="flex-1 p-6 flex flex-col"> <!-- Main form container -->
      <div class="flex-1 flex flex-col">

       <form action="${pageContext.request.contextPath}/admin/supplier" method="post" class="flex-1 flex flex-col space-y-6">
    <!-- Hidden ID field for supplier edit -->
    <c:if test="${not empty supplier}">
        <input type="hidden" name="id" value="${supplier.supplierId}">
    </c:if>

    <!-- Supplier Info -->
    <div>
        <label class="block text-gray-700 font-medium mb-1">Supplier Name</label>
        <input type="text" name="name" id="name" value="${supplier.name}" required
               class="w-full border border-[#2955D9] rounded px-4 py-2" />
    </div>

    <div>
        <label class="block text-gray-700 font-medium mb-1">Supplier Email</label>
        <input type="email" name="email" id="email" value="${supplier.email}" required
               class="w-full border border-[#2955D9] rounded px-4 py-2" />
    </div>

    <div>
        <label class="block text-gray-700 font-medium mb-1">Supplier Phone</label>
        <input type="text" name="phone" id="phone" value="${supplier.phone}" required
               class="w-full border border-[#2955D9] rounded px-4 py-2" />
    </div>

    <div>
        <label class="block text-gray-700 font-medium mb-1">Supplier Address</label>
        <textarea name="address" id="address" required
                  class="w-full border border-[#2955D9] rounded px-4 py-2">${supplier.address}</textarea>
    </div>

    <div>
        <label class="block text-gray-700 font-medium mb-1">Created At</label>
        <input type="date" name="createdAt" id="createdAt" value="<fmt:formatDate value='${supplier.createdAt}' pattern='yyyy-MM-dd'/>" required
               class="w-full border border-[#2955D9] rounded px-4 py-2" />
    </div>

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
