<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>system user form</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen bg-[#f9fafb] text-gray-800 font-sans">

  <div class="flex h-full">
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 flex flex-col items-center justify-start overflow-auto px-6 py-12">
      
      <!-- Page Header -->
      <h1 class="text-3xl font-semibold text-[#142B59] border-b-2 border-[#2955D9] pb-3 text-center mb-4">
        Add New User
      </h1>

      <div class="w-full max-w-8xl space-y-8">

        <form action="${pageContext.request.contextPath}/admin/systemUser" method="post" class="space-y-8">
          <c:if test="${not empty user}">
              <input type="hidden" name="id" value="${user.userId}" />
          </c:if>

          <!-- First Row: Name, Email, Password -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Name</label>
              <input type="text" name="name" value="${not empty user ? user.name : ''}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>

            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Email</label>
              <input type="email" name="email" value="${not empty user ? user.email : ''}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>

            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Password</label>
              <input type="password" name="password" value="${not empty user ? user.password : ''}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
          </div>

          <!-- Second Row: Role, Phone, Filename -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Role</label>
              <select name="role" required
                      class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm">
                <option value="">-- Select Role --</option>
                <option value="Admin" ${not empty user && user.role == 'Admin' ? 'selected' : ''}>Admin</option>
                <option value="Stock Manager" ${not empty user && user.role == 'Stock Manager' ? 'selected' : ''}>Stock Manager</option>
                <option value="Sales Manager" ${not empty user && user.role == 'Sales Manager' ? 'selected' : ''}>Sales Manager</option>
              </select>
            </div>

            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Phone</label>
              <input type="text" name="phone" value="${not empty user ? user.phone : ''}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>

            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Filename</label>
              <input type="text" name="filename" value="${not empty user ? user.filename : ''}"
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
          </div>

          <!-- Address (on its own line) -->
          <div>
            <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Address</label>
            <textarea name="address" rows="4" required
                      class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-sm focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm">${not empty user ? user.address : ''}</textarea>
          </div>

          <!-- Created At (Read-only, only shown on edit) -->
          <c:if test="${not empty user.createdAt}">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Created At</label>
              <input type="text" value="${user.createdAt}" readonly
                     class="w-full bg-gray-100 border border-[#2955D9] rounded-lg px-4 py-3 text-sm" />
            </div>
          </c:if>

          <!-- Action Buttons -->
          <div class="flex justify-end space-x-8 pt-6">
            <button type="submit"
                    class="bg-[#0A4DA6] hover:bg-[#0D448C] text-white font-medium px-8 py-3 rounded-full shadow transition">
              <i class="fas fa-save mr-2"></i>Save
            </button>
            <button type="button" onclick="window.history.back()"
                    class="border border-[#142B59] text-[#142B59] hover:bg-[#142B59] hover:text-white font-medium px-8 py-3 rounded-full transition">
              Discard
            </button>
          </div>

        </form>
      </div>
    </main>
  </div>

<script>
  // Function to allow only letters and spaces in the Name input field
  function allowOnlyLetters(event) {
    const char = String.fromCharCode(event.which || event.keyCode); // Get the character pressed
    const regex = /^[A-Za-z\s]*$/; // Regex that allows only letters and spaces
    if (!regex.test(char)) {
      event.preventDefault(); // Prevent the input if it's not a letter or space
    }
  }

  // Function to allow only numbers, spaces, and common phone symbols in the Phone input field
  function allowOnlyPhoneChars(event) {
    const char = String.fromCharCode(event.which || event.keyCode); // Get the character pressed
    const regex = /^[0-9\s\+\-\(\)]*$/; // Regex to allow numbers, spaces, +, -, (, and )

    const input = event.target;
    const currentValue = input.value;
    const digitCount = (currentValue.match(/\d/g) || []).length;

    const maxDigits = 15;  // Maximum number of digits allowed

    // If char is a digit and max is reached, prevent input
    if (/\d/.test(char) && digitCount >= maxDigits) {
      event.preventDefault();
      return;
    }

    if (!regex.test(char)) {
      event.preventDefault(); // Prevent the input if it's not allowed
    }
  }

  // Attach the event listeners to the input fields
  window.onload = function() {
    // Name input field (letters and spaces only)
    document.querySelector('[name="name"]').addEventListener('keypress', allowOnlyLetters);

    // Phone input field (numbers, spaces, and phone symbols only)
    document.querySelector('[name="phone"]').addEventListener('keypress', allowOnlyPhoneChars);

    // Add form submit validation for minimum digits
    const form = document.querySelector('form'); // Assumes there's a <form> element
    const minDigits = 7; // Minimum number of digits required

    if (form) {
      form.addEventListener('submit', function(event) {
        const phoneInput = form.querySelector('[name="phone"]');
        const digitCount = (phoneInput.value.match(/\d/g) || []).length;

        if (digitCount < minDigits) {
          event.preventDefault();
          alert(`Phone number must contain at least ${minDigits} digits.`);
        }
      });
    }
  };
</script>

</body>
</html>
