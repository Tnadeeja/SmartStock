<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>category form</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen bg-[#f9fafb] text-gray-800 font-sans">

  <div class="flex h-full">
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 flex items-center justify-center">
      <div class="w-full max-w-2xl px-8 py-10">

        <!-- Header -->
        <h1 class="text-3xl font-semibold text-[#142B59] mb-8 border-b-2 border-[#2955D9] pb-3 text-center">
          Add Category
        </h1>

        <form action="${pageContext.request.contextPath}/admin/category" method="post" class="space-y-6">
          <!-- Hidden ID field for updates -->
          <c:if test="${not empty category}">
            <input type="hidden" name="id" value="${category.categoryId}" />
          </c:if>

          <!-- Category Name -->
          <div>
  <label class="block text-sm font-semibold text-[#0A4DA6] mb-2">Category Name</label>
  <input type="text" name="categoryName" value="${category.categoryName}" required
         class="w-full border-b-2 border-[#2955D9] bg-transparent text-lg px-2 py-2 focus:outline-none focus:ring-0 focus:border-[#0A4DA6] transition-all" />
</div>

          <!-- Buttons -->
          <div class="pt-6 flex justify-center space-x-4">
            <button type="submit"
                    class="bg-[#0A4DA6] hover:bg-[#0D448C] text-white font-medium px-6 py-2 rounded-full shadow transition">
              <i class="fas fa-save mr-2"></i>Save
            </button>
            <button type="button" onclick="window.history.back()"
                    class="bg-transparent border border-[#142B59] hover:bg-[#142B59] hover:text-white text-[#142B59] font-medium px-6 py-2 rounded-full transition">
              Discard
            </button>
          </div>
        </form>

      </div>
    </main>
  </div>

<script>
  // Function to allow only letters and spaces in the input fields
  function allowOnlyLetters(event) {
    const char = String.fromCharCode(event.which || event.keyCode); // Get the character pressed
    const regex = /^[A-Za-z\s]*$/; // Regex that allows only letters and spaces
    if (!regex.test(char)) {
      event.preventDefault(); // Prevent the input if it's not a letter or space
    }
  }

  // Attach the event listeners to the input fields
  window.onload = function() {
    // Category Name input
    document.querySelector('[name="categoryName"]').addEventListener('keypress', allowOnlyLetters);
  };
</script>

</body>
</html>
