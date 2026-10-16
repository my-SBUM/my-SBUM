// admin/dashboard.js – dashboard Admin SBUM (PDF 7 & 8): bar chart SVG, aktivitas, antrean
import { StatCard } from "@/views/components/StatCard.js";
import { BarChart } from "@/views/components/BarChart.js";
import { ActivityFeed } from "@/views/components/ActivityFeed.js";

export function adminDashboard({ stats, activities, queue }) {
    // Data tren mingguan mock: [selesai, menunggu, ditolak] per hari (Sen-Min)
    const series = [
        [8, 3, 1],
        [12, 4, 0],
        [10, 2, 1],
        [15, 5, 2],
        [19, 6, 1],
        [13, 4, 0],
        [7, 2, 1],
    ];
    const queueCards = queue
        .map(
            (b) => `
    <div class="mb-3 rounded-xl border border-line p-4">
      <div class="flex items-start justify-between gap-2">
        <div>
          <p class="text-sm font-bold text-slate-800">${b.activity}</p>
          <p class="text-xs text-slate-400">${b.borrower} • ${b.date}</p>
        </div>
        <span class="rounded-full bg-status-menunggu-bg px-2 py-0.5 text-[11px] font-bold text-amber-600">MENUNGGU</span>
      </div>
      <div class="mt-2 flex items-center gap-2 text-xs text-slate-600">
        <span class="rounded-md bg-slate-100 px-2 py-0.5 font-semibold">${b.item}</span>
      </div>
      <button data-review="${b.id}" class="btn-primary mt-3 w-full justify-center !py-2 text-xs">Tinjau &amp; Setujui</button>
    </div>`,
        )
        .join("");

    return `
  <div class="mb-6">
    <p class="mb-1 text-[11px] font-bold uppercase tracking-widest text-brand-light">Portal Kendali Terpadu SBUM</p>
    <h2 class="text-2xl font-extrabold text-slate-900">Selamat Datang, Admin Pengelola SBUM</h2>
    <p class="mt-1 text-sm text-slate-500">Pusat Operasional Sarana Bersama &amp; Urusan Mandiri Kampus Utama Politeknik Negeri Batam</p>
  </div>

  <!-- Bar filter -->
  <div class="card mb-6 flex flex-wrap items-center gap-3 p-4">
    <div class="flex gap-1.5">
      ${["Minggu ini", "Bulan ini", "Custom"].map((l, i) => `<button class="rounded-lg px-3.5 py-2 text-xs font-semibold ${i === 0 ? "bg-brand text-white" : "bg-slate-100 text-slate-500 hover:bg-slate-200"}">${l}</button>`).join("")}
    </div>
    <select class="input !w-auto !py-2 text-sm"><option>Semua Status</option><option>Menunggu</option><option>Disetujui</option><option>Ditolak</option></select>
    <button class="btn-ghost !py-2 text-xs">Muat ulang</button>
  </div>

  <!-- 4 Stat -->
  <div class="mb-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
    ${StatCard("Menunggu Verifikasi", stats.menunggu, "Fasilitas", { badge: "Butuh Tindakan Segera", badgeClass: "bg-status-menunggu-bg text-amber-600", tone: "text-status-menunggu", ic: "clock" })}
    ${StatCard("Total Ruangan Siap", 24, "", { ic: "building" })}
    ${StatCard("Dipinjam", stats.totalAktif, "Fasilitas", { ic: "package" })}
    ${StatCard("Disetujui", stats.disetujui, "Fasilitas", { tone: "text-status-disetujui", ic: "check-circle" })}
  </div>

  <div class="grid gap-6 lg:grid-cols-3">
    <!-- Chart -->
    <div class="card p-5 lg:col-span-2">
      <div class="mb-4 flex flex-wrap items-center justify-between gap-2">
        <h3 class="text-sm font-bold text-slate-800">Monitoring Okupansi &amp; Tren Aktivitas Fasilitas</h3>
        <div class="flex items-center gap-3 text-[11px] font-semibold">
          <span class="flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-sm bg-brand-light"></span>Selesai</span>
          <span class="flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-sm bg-amber-400"></span>Menunggu</span>
          <span class="flex items-center gap-1"><span class="h-2.5 w-2.5 rounded-sm bg-red-400"></span>Ditolak</span>
        </div>
      </div>
      ${BarChart(series)}
      <div class="mt-4 flex flex-wrap items-center justify-between gap-2 rounded-xl bg-brand-soft px-4 py-2.5 text-xs font-semibold text-slate-600">
        <span>Puncak penggunaan mingguan: <b class="text-brand">Jumat (84 Sesi)</b></span>
        <span class="text-status-disetujui">+14.2% vs minggu lalu</span>
      </div>
    </div>
    <!-- Aktivitas -->
    <div class="card">
      <div class="border-b border-line px-4 py-3.5"><h3 class="text-sm font-bold text-slate-800">Aktivitas Terkini</h3></div>
      <div class="p-4">${ActivityFeed(activities)}</div>
    </div>
  </div>

  <!-- Antrean -->
  <div class="card mt-6 p-5">
    <div class="mb-1 flex flex-wrap items-center justify-between gap-2">
      <div>
        <h3 class="text-sm font-bold text-slate-800">Antrean Permohonan Masuk</h3>
        <p class="text-xs text-slate-400">Verifikasi Tahap 3 – Final Otorisasi Admin SBUM</p>
      </div>
      <a href="#/admin/persetujuan" class="text-xs font-semibold text-brand hover:underline">Lihat Semua Antrean Verifikasi (${stats.menunggu})</a>
    </div>
    <div class="mt-4 grid gap-3 md:grid-cols-3">${queueCards}</div>
  </div>`;
}
