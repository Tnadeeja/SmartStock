<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Privacy Policy</title>
    
    <!-- Tailwind CDN (Proper link) -->
    <script src="https://cdn.tailwindcss.com"></script>

    <!-- Custom Theme (optional colors override) -->
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#2955D9',
                        secondary: '#2964D9',
                        tertiary: '#142B59',
                        accent: '#0A4DA6',
                        dark: '#0D448C',
                        danger: '#dc2626',
                    },
                },
            },
        };
    </script>
</head>
<body class="bg-gray-50 text-gray-800 font-sans">

    <!-- Container -->
    <main class="max-w-4xl mx-auto px-6 py-12 bg-white shadow-xl rounded-xl mt-12 mb-16 transition-all duration-300">

        <!-- Back Button -->
        <div class="mb-6">
            <button 
                onclick="history.back()" 
                class="inline-flex items-center px-4 py-2 bg-primary text-white font-medium rounded-md shadow hover:bg-dark transition duration-200"
            >
                ← Back
            </button>
        </div>

        <!-- Title -->
        <header class="text-center mb-10">
            <h1 class="text-4xl font-bold text-primary mb-2">Privacy Policy</h1>
            <p class="text-sm text-gray-500">Last updated: May 19, 2025</p>
        </header>

        <!-- Introduction -->
        <section class="space-y-4 border-l-4 border-primary pl-4 bg-gray-50 rounded-md p-4">
            <p class="text-lg leading-relaxed text-gray-700">
                This Privacy Policy describes Our policies and procedures on the collection, use and disclosure of Your information when You use the Service and tells You about Your privacy rights and how the law protects You.
            </p>
        </section>

        <!-- Section -->
        <section class="mt-10">
            <h2 class="text-2xl font-semibold text-primary border-b pb-2 mb-4">Interpretation and Definitions</h2>

            <div class="space-y-6">
                <div>
                    <h3 class="text-xl font-semibold text-tertiary mb-2">Interpretation</h3>
                    <p class="text-gray-700 leading-relaxed">
                        The words of which the initial letter is capitalized have meanings defined under the following conditions...
                    </p>
                </div>

                <div>
                    <h3 class="text-xl font-semibold text-tertiary mb-2">Definitions</h3>
                    <p class="text-gray-700 mb-2">For the purposes of this Privacy Policy:</p>
                    <ul class="list-disc pl-6 space-y-2 text-gray-700">
                        <li><strong>Account</strong> – a unique account created for You...</li>
                        <li><strong>Affiliate</strong> – an entity that controls, is controlled by...</li>
                        <li><strong>Company</strong> – refers to Limited, online...</li>
                        <li><strong>Cookies</strong> – small files placed on Your device...</li>
                        <li><strong>Country</strong> – Sri Lanka</li>
                        <li><strong>Device</strong> – any device that can access the Service...</li>
                        <li><strong>Personal Data</strong> – any information that relates to an identifiable individual.</li>
                        <li><strong>Service</strong> – refers to the Website.</li>
                        <li><strong>Service Provider</strong> – a person who processes data for the Company.</li>
                        <li><strong>Usage Data</strong> – data collected automatically when using the Service.</li>
                        <li><strong>You</strong> – the individual accessing the Service...</li>
                    </ul>
                </div>
            </div>
        </section>

        <!-- Collecting Data -->
        <section class="mt-12">
            <h2 class="text-2xl font-semibold text-primary border-b pb-2 mb-4">Collecting and Using Your Personal Data</h2>

            <div class="space-y-6">
                <div>
                    <h3 class="text-xl font-semibold text-tertiary mb-2">Types of Data Collected</h3>

                    <div class="mt-2 space-y-6">
                        <div class="bg-gray-50 rounded-md p-4 border-l-4 border-accent">
                            <h4 class="text-lg font-semibold text-primary mb-1">Personal Data</h4>
                            <p class="text-gray-700 leading-relaxed">We may ask You to provide certain personally identifiable information...</p>
                            <ul class="list-disc pl-6 space-y-2 text-gray-700 mt-2">
                                <li>Email address</li>
                                <li>First name and last name</li>
                                <li>Phone number</li>
                                <li>Address, State, ZIP/Postal code, City</li>
                                <li>Usage Data</li>
                            </ul>
                        </div>

                        <div class="bg-gray-50 rounded-md p-4 border-l-4 border-accent">
                            <h4 class="text-lg font-semibold text-primary mb-1">Usage Data</h4>
                            <p class="text-gray-700 leading-relaxed">Usage Data is collected automatically...</p>
                            <p class="text-gray-700 leading-relaxed">This may include information such as your IP address, browser type, time spent, etc.</p>
                        </div>

                        <div class="bg-gray-50 rounded-md p-4 border-l-4 border-accent">
                            <h4 class="text-lg font-semibold text-primary mb-1">Tracking Technologies and Cookies</h4>
                            <p class="text-gray-700 leading-relaxed">We use Cookies and similar technologies to track activity and store certain data.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <!-- Contact Info -->
        <section class="mt-12 border-t pt-6">
            <h2 class="text-2xl font-semibold text-primary mb-4">Contact Us</h2>
            <p class="text-gray-700 mb-2">If you have any questions about this Privacy Policy, you can contact us:</p>
            <ul class="list-disc pl-6 space-y-2">
                <li>
                    By email: 
                    <a href="mailto:smartstock@gmail.com" class="text-primary hover:underline transition duration-200">
                        smartstock@gmail.com
                    </a>
                </li>
            </ul>
        </section>
    </main>
</body>
</html>