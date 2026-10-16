// admin/rooms.js – kelola ruangan (PDF 1 & 8)
import { StatusBadge } from "@/views/components/StatusBadge.js";

export function manageRooms({ stats, rows, state }) {
    const cards = rows
        .map(
            (r) => `
    <div class="card overflow-hidden">
      <img src="${r.image}" alt="${r.name}" class="h-40 w-full object-cover" onerror="this.style.display='none'">
      <div class="p-4">
        <div class="mb-2 flex items-center justify-between">
          <span class="text-xs font-semibold text-slate-400">${r.building} • ${r.floor}</span>
          ${StatusBadge(r.status)}
        </div>
        <p class="text-sm font-bold text-slate-800">${r.name}</p>
        <p class="mt-0.5 text-xs text-slate-500">${r.description}</p>
        <div class="mt-3 grid grid-cols-2 gap-2 text-xs">
          <div><p class="text-slate-400">Kode</p><p class="font-semibold text-slate-700">${r.code}</p></div>
          <div><p class="text-slate-400">Kapasitas</p><p class="font-semibold text-slate-700">${r.capacity} orang</p></div>
          <div><p class="text-slate-400">PIC</p><p class="font-semibold text-slate-700">${r.pic}</p></div>
          <div class="col-span-2"><p class="text-slate-400">Fasilitas</p>
            <div class="mt-1 flex flex-wrap gap-1">${r.facilities.map((f) => `<span class="rounded-full bg-slate-100 px-2 py-0.5 text-[11px] text-slate-600">${f}</span>`).join("")}</div>
          </div>
        </div>
        <button data-edit="${r.id}" class="btn-primary mt-4 w-full justify-center !py-2 text-xs">Edit Ruangan</button>
      </div>
    </div>`,
        )
        .join("");

    return `
  <div class="mb-6">
    <h2 class="text-2xl font-extrabold text-slate-900">Kelola Ruangan</h2>
    <p class="mt-1 text-sm text-slate-500">Manajemen data ruangan Kampus Utama.</p>
  </div>
  <div class="mb-6 grid gap-4 sm:grid-cols-3">
    ${[
        [
            "Siap digunakan",
            stats.ready,
            "Unit Siap Pakai",
            "text-status-disetujui",
        ],
        [
            "Sedang dipakai",
            stats.inUse,
            "Unit Aktif Sekarang",
            "text-status-menunggu",
        ],
        [
            "Tidak tersedia",
            stats.maintenance,
            "Unit Maintenance",
            "text-status-ditolak",
        ],
    ]
        .map(
            ([l, v, s, c]) =>
                `<div class="card p-4"><p class="text-xs text-slate-400">${l}</p><p class="text-2xl font-extrabold ${c}">${v}</p><p class="text-[11px] text-slate-400">${s}</p></div>`,
        )
        .join("")}
  </div>
  <div class="mb-4 flex flex-wrap gap-2">
    <input id="r-search" class="input !w-64 !py-2 text-sm" placeholder="Cari ruangan atau kode..." value="${state.q}">
    <select id="r-status" class="input !w-auto !py-2 text-sm">
      <option value="">Semua Status</option>
      <option value="tersedia" ${state.status === "tersedia" ? "selected" : ""}>Tersedia</option>
      <option value="tidak-tersedia" ${state.status === "tidak-tersedia" ? "selected" : ""}>Tidak Tersedia</option>
    </select>
  </div>
  <div class="grid gap-5 sm:grid-cols-2 xl:grid-cols-3">
    ${cards || '<p class="card col-span-full p-8 text-center text-sm text-slate-400">Tidak ada ruangan cocok dengan filter.</p>'}
  </div>`;
}
