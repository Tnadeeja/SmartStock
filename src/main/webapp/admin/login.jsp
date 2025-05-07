<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
	
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Login</title>
  <script src="https://cdn.tailwindcss.com"></script>
  <style>
    body {
      background: linear-gradient(135deg, #0D121F 20%, #0072ff 100%);
    }
    @keyframes slideFadeInLeft {
      0% {
        opacity: 0;
        transform: translateX(-50px);
      }
      100% {
        opacity: 1;
        transform: translateX(0);
      }
    }
    @keyframes slideFadeInRight {
      0% {
        opacity: 0;
        transform: translateX(50px);
      }
      100% {
        opacity: 1;
        transform: translateX(0);
      }
    }
    .animate-slide-fade-left {
      animation: slideFadeInLeft 1s ease-out forwards;
    }
    .animate-slide-fade-right {
      animation: slideFadeInRight 1s ease-out forwards;
    }
  </style>
</head>
<body class="relative h-screen flex items-center justify-center text-white font-sans overflow-hidden translate-x-1 translate-y-50">

  <!-- Background geometric shapes -->
  <div class="absolute w-[600px] h-[600px] bg-blue-600 rounded-full top-[-200px] left-[-200px] opacity-30 blur-3xl shadow-2xl"></div>
  <div class="absolute w-[500px] h-[500px] bg-purple-700 rounded-full bottom-[-150px] right-[-150px] opacity-30 blur-3xl shadow-2xl"></div>
  <div class="absolute w-full h-full bg-gradient-to-br from-transparent via-blue-800/20 to-transparent mix-blend-overlay pointer-events-none"></div>

  <!-- Logo -->
  <div class="absolute top-6 left-6 text-white text-sm font-semibold z-10">SmartStock</div>

  <!-- Left Welcome text -->
  <div class="absolute left-10 top-1/2 transform -translate-y-1/2 text-4xl font-bold text-white z-10 animate-slide-fade-left">
    Welcome Back!
  </div>

  <!-- Right Login prompt -->
  <div class="absolute right-10 top-1/2 transform -translate-y-1/2 text-4xl font-bold text-right text-white z-10 animate-slide-fade-right">
    Let's Login to<br>Your Account
  </div>

  <!-- Login Card -->
  <div class="relative z-10 bg-white/5 backdrop-blur-xl border border-white/10 shadow-xl rounded-2xl p-10 w-full max-w-md">
    <form action= "${pageContext.request.contextPath}/admin/login" method= "POST" class="space-y-6">
      <div>
        <label class="block text-sm text-white mb-1" for="email">Email</label>
<input id="email" name="email" type="email" 
       class="w-full px-4 py-3 rounded-lg bg-white/10 border border-white/20 text-white placeholder-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500"
       placeholder="Enter your email"/>
        
      </div>
      <div>
        <label class="block text-sm text-white mb-1" for="password">Password</label>
        <input id="password" type="password" name="password" class="w-full px-4 py-3 rounded-lg bg-white/10 border border-white/20 text-white placeholder-gray-300 focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your password"/>
      </div>
      <div>
      
     <c:if test="${not empty error}">
    <div class="bg-red-500/20 text-red-400 border border-red-500 rounded-lg p-4 mb-4">
       <p>${error}</p>
    </div>
</c:if>
     
        <button type="submit" class="w-full bg-blue-600 hover:bg-blue-700 text-white font-semibold py-3 rounded-full shadow-md transition-all duration-300">
          Login
        </button>
      </div>
    </form>
  </div>

  <!-- Footer -->
  <div class="absolute bottom-6 text-center w-full text-white text-xs z-10">Privacy Policy</div>

</body>
</html>
