<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${param.title} - Online Submission System</title>
    <!-- Tailwind CSS via CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        primary: '#3B82F6',
                        secondary: '#10B981',
                        accent: '#8B5CF6',
                        danger: '#EF4444',
                        warning: '#F59E0B',
                        info: '#3B82F6',
                        success: '#10B981',
                    }
                }
            }
        }
    </script>
    <!-- Additional styles -->
    <style type="text/tailwindcss">
        @layer components {
            .btn {
                @apply px-4 py-2 rounded font-medium transition-colors duration-200;
            }
            .btn-primary {
                @apply bg-primary text-white hover:bg-blue-700;
            }
            .btn-secondary {
                @apply bg-secondary text-white hover:bg-green-700;
            }
            .btn-danger {
                @apply bg-danger text-white hover:bg-red-700;
            }
            .form-input {
                @apply w-full px-3 py-2 border border-gray-300 rounded-md focus:outline-none focus:ring-2 focus:ring-primary focus:border-transparent;
            }
            .form-label {
                @apply block text-sm font-medium text-gray-700 mb-1;
            }
            .card {
                @apply bg-white rounded-lg shadow-md overflow-hidden;
            }
        }
    </style>
</head>
<body class="bg-gray-100 min-h-screen"> 