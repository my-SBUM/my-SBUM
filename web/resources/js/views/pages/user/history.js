// user/history.js – riwayat peminjaman: tab status + search + batalkan (PDF 1/2)
import { StatusBadge } from "@/views/components/StatusBadge.js";

export function history({ counts, rows, state }) {
    const tabs = [
        ["semua", `Semua (${counts.semua})`],
        ["disetujui", `Disetujui (${counts.disetujui})`],
        ["menunggu", `Menunggu (${counts.menunggu})`],
        ["ditolak", `Ditolak (${counts.ditolak})`],
    ];
    const borderColor = {
        menunggu: "border-l-status-menunggu",
        disetujui: "border-l-status-disetujui",
        ditolak: "border-l-status-ditolak",
    };

    const cards = rows
        .map(
            (b) => `
    <div class="card border-l-4 ${borderColor[b.status]} p-5">
      <div class="mb-2 flex items-center justify-between">
        <div>
          <p class="text-sm font-bold text-slate-800">${b.item}</p>
          <p class="text-xs text-slate-400">${b.activity} • ${b.code}</p>
        </div>
        ${StatusBadge(b.status)}
      </div>
      <div class="grid grid-cols-2 gap-x-4 gap-y-1.5 text-xs">
        <div><p class="text-slate-400">Tanggal</p><p class="font-semibold text-slate-700">${b.date}</p></div>
        <div><p class="text-slate-400">Waktu</p><p class="font-semibold text-slate-700">${b.start}–${b.end}</p></div>
        <div><p class="text-slate-400">Jenis</p><p class="font-semibold text-slate-700">${b.type === "ruangan" ? "Ruangan" : "Alat"}</p></div>
        <div><p class="text-slate-400">PIC</p><p class="font-semibold text-slate-700">${b.pic}</p></div>
      </div>
      <div class="mt-4 flex gap-2">
        <button class="btn-ghost flex-1 justify-center !py-2 text-xs">Detail</button>
        ${b.status === "menunggu" ? `<button data-cancel="${b.id}" class="btn-danger flex-1 justify-center !py-2 text-xs">Batalkan</button>` : ""}
      </div>
    </div>`,
        )
        .join("");

    return `
  <div class="mb-6">
    <h2 class="text-2xl font-extrabold text-slate-900">Riwayat &amp; Log</h2>
    <p class="mt-1 text-sm text-slate-500">Semua pengajuan peminjaman yang pernah dibuat.</p>
  </div>
  <div class="mb-4 flex flex-wrap items-center gap-2">
    ${tabs
        .map(
            ([k, l]) => `
      <button data-tab="${k}" class="rounded-lg px-4 py-2 text-xs font-bold uppercase tracking-wide ${state.tab === k ? "bg-brand text-white" : "bg-slate-100 text-slate-500 hover:bg-slate-200"}" ${state.tab === k ? 'aria-current="true"' : ""}>${l}</button>`,
        )
        .join("")}
    <div class="ml-auto flex gap-2">
      <input id="h-search" class="input !w-64 !py-2 text-sm" placeholder="Cari kode booking / kegiatan / pemohon..." value="${state.q}">
      <button class="btn-ghost !py-2 text-xs">Filter Lanjutan</button>
    </div>
  </div>
  <div class="grid gap-5 md:grid-cols-2 xl:grid-cols-3">
    ${cards || '<p class="card col-span-full p-8 text-center text-sm text-slate-400">Tidak ada riwayat untuk filter ini.</p>'}
  </div>`;
}
