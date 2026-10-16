SCAFFOLD STRUKTUR LARAVEL mySBUM

PENTING:
- Scaffold ini membuat kerangka file/folder, bukan aplikasi yang sudah selesai.
- Jalankan hanya di root project Laravel yang benar.
- Script PowerShell tidak menimpa file yang sudah ada.
- Jika folder saat ini belum merupakan project Laravel, buat project terlebih dahulu dengan:
    composer create-project laravel/laravel mySBUM
- Setelah itu salin/merge scaffold ini ke root project Laravel.
- RoleMiddleware memerlukan kolom users.role dan perlu didaftarkan sebagai alias middleware sesuai versi Laravel.
- Rute fitur, migration, autentikasi, dan aturan persetujuan perlu dilengkapi.
