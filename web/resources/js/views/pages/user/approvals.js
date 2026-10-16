// user/approvals.js – halaman persetujuan: 3 stat, tab ALAT/RUANGAN, kartu peminjaman
import { StatusBadge } from "@/views/components/StatusBadge.js";
import { StatCard } from "@/views/components/StatCard.js";

export function approvals({ stats, rows, state, routePath }) {
    const cards = rows
        .map(
            (b) => `
    <div class="card border-l-4 ${b.status === "menunggu" ? "border-l-status-menunggu" : b.status === "disetujui" ? "border-l-status-disetujui" : "border-l-status-ditolak"} p-5">
      <div class="mb-3 flex items-center justify-between">
        <span class="text-xs font-extrabold tracking-wide text-slate-700">${b.code}</span>
        ${StatusBadge(b.status)}
      </div>
      <p class="text-sm font-bold text-slate-800">${b.item}</p>
      <div class="mt-3 grid grid-cols-2 gap-x-4 gap-y-2 text-xs">
        <div><p class="text-slate-400">Peminjam</p><p class="font-semibold text-slate-700">${b.borrower} <span class="font-normal text-slate-400">(${b.role})</span></p></div>
        <div><p class="text-slate-400">Email</p><p class="font-semibold text-slate-700">${b.email}</p></div>
        <div><p class="text-slate-400">PIC</p><p class="font-semibold text-slate-700">${b.pic}</p></div>
        <div><p class="text-slate-400">No. Telp</p><p class="font-semibold text-slate-700">${b.phone}</p></div>
        <div><p class="text-slate-400">Hari/Tanggal</p><p class="font-semibold text-slate-700">${b.date}</p></div>
        <div><p class="text-slate-400">Waktu</p><p class="font-semibold text-slate-700">${b.start}–${b.end}</p></div>
        <div><p class="text-slate-400">Jenis</p><p class="font-semibold text-slate-700">${b.type === "ruangan" ? "Ruangan" : "Alat"}</p></div>
        <div><p class="text-slate-400">Kegiatan</p><p class="font-semibold text-slate-700">${b.activity}</p></div>
      </div>
      ${
          b.status === "menunggu"
              ? `
      <div class="mt-4 flex gap-2">
        <button data-approve="${b.id}" class="btn-green flex-1 justify-center !py-2">Setujui</button>
        <button data-reject="${b.id}" class="btn-danger flex-1 justify-center !py-2">Tolak</button>
      </div>`
              : ""
      }
    </div>`,
        )
        .join("");

    const tab = (id, label, key) => `
    <button id="${id}" class="rounded-lg px-4 py-2 text-xs font-bold uppercase tracking-wide ${state.tab === key ? "bg-brand text-white" : "bg-slate-100 text-slate-500 hover:bg-slate-200"}">${label}</button>`;

    return `
  <div class="mb-6">
    <h2 class="text-2xl font-extrabold text-slate-900">Halaman Peminjaman</h2>
    <p class="mt-1 text-sm text-slate-500">Kelola persetujuan pengajuan peminjaman.</p>
  </div>
  <div class="mb-6 grid gap-4 md:grid-cols-3">
    ${StatCard("Telah disetujui", stats.disetujui, "", { ic: "check-circle", tone: "text-status-disetujui" })}
    ${StatCard("Perlu disetujui", stats.menunggu, "", { badge: "Butuh Aksi", badgeClass: "bg-status-menunggu-bg text-amber-600", tone: "text-status-menunggu", ic: "clock" })}
    ${StatCard("Telah ditolak", stats.ditolak, "", { ic: "x", tone: "text-status-ditolak" })}
  </div>
  <div class="mb-4 flex flex-wrap items-center gap-2">
    ${tab("tab-alat", "Alat", "alat")}
    ${tab("tab-ruangan", "Ruangan", "ruangan")}
    <div class="ml-auto flex flex-wrap items-center gap-2">
      <select id="ap-status" class="input !w-auto !py-2 text-sm">
        <option value="">Semua Status</option>
        ${["menunggu", "disetujui", "ditolak"].map((s) => `<option value="${s}" ${state.status === s ? "selected" : ""}>${s[0].toUpperCase() + s.slice(1)}</option>`).join("")}
      </select>
      <input id="ap-search" class="input !w-64 !py-2 text-sm" placeholder="Cari peralatan, kode, atau nama peminjam..." value="${state.q}">
    </div>
  </div>
  <div class="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
    ${cards || '<p class="card col-span-full p-8 text-center text-sm text-slate-400">Tidak ada data untuk filter ini.</p>'}
  </div>`;
}
