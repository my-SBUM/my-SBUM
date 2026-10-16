<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'mySBUM - Politeknik Negeri Batam')</title>
    
    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">

    <!-- Vite Assets / Tailwind CSS -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])

    <!-- Alpine.js (Opsional untuk interactive UI seperti toggle password) -->
    <script defer src="https://cdn.jsdelivr.net/npm/alpinejs@3.x.x/dist/cdn.min.js"></script>

    <style>
        body {
            font-family: 'Plus Jakarta Sans', sans-serif;
        }
    </style>
</head>
<body class="bg-slate-100 text-slate-800 min-h-screen flex flex-col justify-beetwen items-center p-4 sm:p-6">
    <main class="w-full max-w-md my-auto fle flex-col items-center">
        @yield('content')
    </main>

    <!-- Global Footer -->
     <footer class="mt-8 text-center text-xs text-slate-500">
        <p>&copy; 2026 mySBUM Politeknik negeri batam. Sistem Peminjaman Alat dan Ruangan.</p>
     </footer>
</body>
</html>
