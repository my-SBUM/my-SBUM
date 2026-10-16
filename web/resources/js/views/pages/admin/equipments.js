// admin/equipments.js – kelola peralatan (PDF 1 & 8)
import { StatusBadge } from "@/views/components/StatusBadge.js";

export function manageEquipments({ stats, rows, state, categories }) {
    const cards = rows
        .map(
            (e) => `
    <div class="card overflow-hidden">
      <img src="${e.image}" alt="${e.name}" class="h-36 w-full object-cover" onerror="this.style.display='none'">
      <div class="p-4">
        <div class="mb-2 flex items-center justify-between">
          <span class="text-xs font-extrabold tracking-wide text-slate-700">${e.code}</span>
          ${StatusBadge(e.status)}
        </div>
        <p class="text-sm font-bold text-slate-800">${e.name}</p>
        <p class="mt-0.5 text-xs text-slate-500">${e.description}</p>
        <div class="mt-3 grid grid-cols-2 gap-2 text-xs">
          <div><p class="text-slate-400">Kategori</p><p class="font-semibold text-slate-700">${e.category}</p></div>
          <div><p class="text-slate-400">Stok</p><p class="font-semibold text-slate-700">${e.stock} unit</p></div>
          <div class="col-span-2"><p class="text-slate-400">Lokasi</p><p class="font-semibold text-slate-700">${e.location}</p></div>
        </div>
        <button data-edit="${e.id}" class="btn-primary mt-4 w-full justify-center !py-2 text-xs">Edit Peralatan</button>
      </div>
    </div>`,
        )
        .join("");

    return `
  <div class="mb-6">
    <h2 class="text-2xl font-extrabold text-slate-900">Kelola Peralatan</h2>
    <p class="mt-1 text-sm text-slate-500">Manajemen data peralatan SBUM.</p>
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
            "Sedang dipinjam",
            stats.borrowed,
            "Unit Terjadwal",
            "text-status-menunggu",
        ],
        [
            "Rusak/Servis",
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
    <input id="e-search" class="input !w-64 !py-2 text-sm" placeholder="Cari kode aset..." value="${state.q}">
    <select id="e-category" class="input !w-auto !py-2 text-sm">
      <option value="">Semua Kategori</option>
      ${categories.map((c) => `<option value="${c}" ${state.category === c ? "selected" : ""}>${c}</option>`).join("")}
    </select>
    <select id="e-condition" class="input !w-auto !py-2 text-sm">
      <option value="">Semua Kondisi</option>
      <option value="tersedia" ${state.condition === "tersedia" ? "selected" : ""}>Baik</option>
      <option value="tidak-tersedia" ${state.condition === "tidak-tersedia" ? "selected" : ""}>Maintenance</option>
    </select>
    <button id="e-reset" class="btn-ghost !py-2 text-xs">Reset</button>
  </div>
  <div class="grid gap-5 sm:grid-cols-2 xl:grid-cols-3">
    ${cards || '<p class="card col-span-full p-8 text-center text-sm text-slate-400">Tidak ada peralatan cocok dengan filter.</p>'}
  </div>`;
}
