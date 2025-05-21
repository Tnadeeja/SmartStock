<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>customer form</title>
  <link rel="shortcut icon" href="${pageContext.request.contextPath}/admin/assets/picture/favicon-white.png" type="image/png" />
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen bg-[#f9fafb] text-gray-800 font-sans">

  <div class="flex h-full">
    <jsp:include page="partials/slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 flex items-center justify-center overflow-auto px-6 py-12">
      <div class="w-full max-w-4xl space-y-12">

        <!-- Page Header -->
        <h1 class="text-3xl font-semibold text-[#142B59] border-b-2 border-[#2955D9] pb-3 text-center">
          Add Customer
        </h1>

        <form action="${pageContext.request.contextPath}/admin/customer" method="post" class="space-y-12">
          <c:if test="${not empty customer}">
              <input type="hidden" name="id" value="${customer.customerId}" />
          </c:if>

          <!-- Customer Info: Name & Email -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div>
  <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Customer Name</label>
  <input type="text" name="name" value="${customer.name}" required
         class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
</div>

            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Customer Email</label>
              <input type="email" name="email" value="${customer.email}" required
                     class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
            </div>
          </div>

          <!-- Customer Info: Phone & Address -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
            <div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Customer Phone</label>
             <input type="tel" name="phone" value="${customer.phone}" required
       pattern="[0-9]{7,15}"
       title="Enter a valid phone number (7 to 15 digits)"
       class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
             
            </div>
			<div>
            <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Created At</label>
            <input type="date" name="createdAt" value="<fmt:formatDate value='${customer.createdAt}' pattern='yyyy-MM-dd'/>" required
                   class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-3 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm" />
          </div>
            
          </div>

          <!-- Created At -->
			<div>
              <label class="block text-sm font-medium text-[#0A4DA6] mb-2">Customer Address</label>
              <textarea name="address" required
                        class="w-full border border-[#2955D9] rounded-lg bg-white px-4 py-0 text-base focus:outline-none focus:ring-2 focus:ring-[#0A4DA6] shadow-sm min-h-[48px] resize-none">${customer.address}</textarea>
            </div>
          <!-- Action Buttons -->
          <div class="flex justify-end space-x-6 pt-4">
            <button type="submit"
                    class="bg-[#0A4DA6] hover:bg-[#0D448C] text-white font-medium px-6 py-2 rounded-full shadow transition">
              <i class="fas fa-save mr-2"></i>Save
            </button>
            <button type="button" onclick="window.history.back()"
                    class="border border-[#142B59] text-[#142B59] hover:bg-[#142B59] hover:text-white font-medium px-6 py-2 rounded-full transition">
              Discard
            </button>
          </div>

        </form>
      </div>
    </main>
  </div>
  <script>
    document.querySelector('input[name="phone"]').addEventListener('input', function () {
        this.value = this.value.replace(/\D/g, '');
    });
</script>

<script>
  // Function to allow only letters and spaces in the input fields
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
  window.onload = function () {
    // Customer Name input
    document.querySelector('[name="name"]').addEventListener('keypress', allowOnlyLetters);

    // Phone input field
    document.querySelector('[name="phone"]').addEventListener('keypress', allowOnlyPhoneChars);

    // Add form submit validation for minimum digits
    const form = document.querySelector('form');
    const minDigits = 7;

    if (form) {
      form.addEventListener('submit', function (event) {
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

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const createdAtInput = document.querySelector('input[name="createdAt"]');
    if (createdAtInput) {
      const today = new Date().toISOString().split("T")[0]; // Format: yyyy-MM-dd
      createdAtInput.value = today;
    }
  });
</script>

</body>
</html>
