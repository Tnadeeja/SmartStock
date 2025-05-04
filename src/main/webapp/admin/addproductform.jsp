<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Add New Product</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
</head>
<body class="h-screen">

  <jsp:include page="header.jsp" />

  <div class="flex h-[calc(100vh-64px)]"> <!-- Assuming header is 64px high -->
    <jsp:include page="slideBar.jsp" />

    <!-- Main content -->
    <main class="flex-1 p-6 flex flex-col"> <!-- ✅ Added 'flex flex-col' -->
      <div class="flex-1 flex flex-col">

        <form action="purchaseStock?action=save" method="post" class="flex-1 flex flex-col space-y-6">
          
          <!-- Product Info -->
          <div>
            <label class="block text-gray-700 font-medium mb-1">Product Name</label>
            <input type="text" name="productName" required
                   class="w-full border border-gray-300 rounded px-4 py-2 focus:outline-none focus:ring-2 focus:ring-blue-400" />
          </div>

          <!-- Category & Supplier -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="block text-gray-700 font-medium mb-1">Category</label>
              <select name="categoryId" required
                      class="w-full border border-gray-300 rounded px-4 py-2 bg-white">
                <option value="">-- Select Category --</option>
              </select>
            </div>
            <div>
              <label class="block text-gray-700 font-medium mb-1">Supplier</label>
              <select name="supplierId" required
                      class="w-full border border-gray-300 rounded px-4 py-2 bg-white">
                <option value="">-- Select Supplier --</option>
              </select>
            </div>
          </div>

          <!-- Quantity & Price -->
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label class="block text-gray-700 font-medium mb-1">Quantity</label>
              <input type="number" name="quantity" required
                     class="w-full border border-gray-300 rounded px-4 py-2" />
            </div>
            <div>
              <label class="block text-gray-700 font-medium mb-1">Unit Price</label>
              <input type="number" step="0.01" name="unitPrice" required
                     class="w-full border border-gray-300 rounded px-4 py-2" />
            </div>
          </div>

          <!-- Dates -->
          <div class="grid grid-cols-1 md:grid-cols-3 gap-6">
            <div>
              <label class="block text-gray-700 font-medium mb-1">Manufacture Date</label>
              <input type="date" name="manufactureDate"
                     class="w-full border border-gray-300 rounded px-4 py-2" />
            </div>
            <div>
              <label class="block text-gray-700 font-medium mb-1">Expiry Date</label>
              <input type="date" name="expireDate"
                     class="w-full border border-gray-300 rounded px-4 py-2" />
            </div>
            <div>
              <label class="block text-gray-700 font-medium mb-1">Purchase Date</label>
              <input type="date" name="purchaseDate"
                     class="w-full border border-gray-300 rounded px-4 py-2" />
            </div>
          </div>

          <!-- Buttons -->
          <div class="pt-4 mt-auto">
            <div class="flex justify-end space-x-4">
              <button type="submit"
                      class="bg-green-600 text-white px-6 py-2 rounded hover:bg-green-700 transition-all">
                <i class="fas fa-save mr-2"></i>Save
              </button>
              <button type="button" onclick="window.close()"
                      class="bg-gray-500 text-white px-6 py-2 rounded hover:bg-gray-600 transition-all">
                Cancel
              </button>
            </div>
          </div>
        </form>
      </div>
    </main>
  </div>
</body>
</html>