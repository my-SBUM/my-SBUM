// menu.js – menu sidebar per role (label bagian atas: OPERASIONAL UTAMA)
export const menus = {
  koordinator: [
    { label: "Dashboard", icon: "layout-dashboard", path: "/dashboard" },
    { label: "Peminjaman Ruangan", icon: "door-open", path: "/ruangan" },
    { label: "Peminjaman Alat", icon: "wrench", path: "/alat" },
    { label: "Persetujuan", icon: "check-circle", path: "/persetujuan" },
    { label: "Riwayat & Log", icon: "history", path: "/riwayat" },
    { label: "Kelola Ruangan", icon: "building", path: "/kelola-ruangan" },
    { label: "Kelola Peralatan", icon: "package", path: "/kelola-peralatan" },
  ],
  admin: [
    { label: "Dashboard", icon: "layout-dashboard", path: "/admin" },
    { label: "Persetujuan", icon: "check-circle", path: "/admin/persetujuan" },
    { label: "Kelola Ruangan", icon: "building", path: "/kelola-ruangan" },
    { label: "Kelola Peralatan", icon: "package", path: "/kelola-peralatan" },
    { label: "Kalender", icon: "calendar", path: "/admin/kalender" },
    { label: "Kelola Admin", icon: "users", path: "/admin/kelola-admin" },
  ],
};
