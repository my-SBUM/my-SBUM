// admin/calendar.js – kalender peminjaman (PDF 7 & 8): stat, filter, grid bulanan, panel detail
import { CalendarGrid } from "@/views/components/CalendarGrid.js";

export function calendar({ stats, bookings, state }) {
    return `
  <div class="mb-6">
    <h2 class="text-2xl font-extrabold text-slate-900">Kalender Peminjaman</h2>
    <p class="mt-1 text-sm text-slate-500">Pantau jadwal peminjaman ruangan &amp; peralatan.</p>
  </div>
  <div class="mb-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
    ${[
        ["Total aktif", stats.totalAktif, "text-slate-800"],
        ["Menunggu", stats.menunggu, "text-status-menunggu"],
        ["Disetujui", stats.disetujui, "text-status-disetujui"],
        ["Ruangan", 22, "text-slate-800"],
    ]
        .map(
            ([l, v, c]) =>
                `<div class="card p-4"><p class="text-xs text-slate-400">${l}</p><p class="text-2xl font-extrabold ${c}">${v}</p></div>`,
        )
        .join("")}
  </div>
  <div class="mb-4 flex flex-wrap items-center gap-2">
    <select id="cal-type" class="input !w-auto !py-2 text-sm">
      <option value="">Jenis: Semua</option><option value="ruangan">Ruangan</option><option value="alat">Alat</option>
    </select>
    <select id="cal-status" class="input !w-auto !py-2 text-sm">
      <option value="">Status: Semua</option><option value="menunggu">Menunggu</option><option value="disetujui">Disetujui</option>
    </select>
    <div class="ml-auto flex gap-2">
      <button class="btn-danger !py-2 text-xs">Download PDF</button>
      <button class="btn-green !py-2 text-xs">Download Excel</button>
    </div>
  </div>
  <div class="grid gap-6 lg:grid-cols-5">
    <div class="card p-5 lg:col-span-3">
      <div class="mb-4 flex items-center justify-between">
        <button id="cal-prev" class="btn-ghost !p-2" aria-label="Sebelumnya">‹</button>
        <div class="flex items-center gap-3">
          <h3 class="text-sm font-bold text-slate-800" id="cal-title"></h3>
          <button id="cal-today" class="rounded-md bg-slate-100 px-2.5 py-1 text-xs font-semibold text-slate-600 hover:bg-slate-200">Hari ini</button>
        </div>
        <button id="cal-next" class="btn-ghost !p-2" aria-label="Berikutnya">›</button>
      </div>
      ${CalendarGrid(bookings, state)}
    </div>
    <div class="card p-5 lg:col-span-2">
      <h3 id="cal-title" class="mb-4 text-sm font-bold text-slate-800"></h3>
      <div id="cal-detail" class="text-sm text-slate-400">Pilih tanggal pada kalender untuk melihat acara.</div>
    </div>
  </div>`;
}
