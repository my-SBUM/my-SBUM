// BookingCard.js – kartu peminjaman utk halaman persetujuan & riwayat (border warna sesuai status)
import { StatusBadge } from "./StatusBadge.js";
import { icon } from "./icons.js";

const BORDER = {
  menunggu: "border-l-status-menunggu",
  disetujui: "border-l-status-disetujui",
  diterima: "border-l-status-disetujui",
  ditolak: "border-l-status-ditolak",
};

/** data: booking, opts: { mode: 'approval'|'history', onApprove, onReject, onCancel, detailHref } */
export function BookingCard(b, { mode = "history", detailHref = "#" } = {}) {
  const actions =
    mode === "approval"
      ? `<div class="mt-4 flex gap-2 border-t border-line pt-3">
        <button data-approve="${b.id}" class="btn-green flex-1 !py-2 text-xs">${icon("check", "h-4 w-4")} Setujui</button>
        <button data-reject="${b.id}" class="btn-danger flex-1 !py-2 text-xs">${icon("x", "h-4 w-4")} Tolak</button>
      </div>`
      : mode === "history"
        ? `<div class="mt-4 flex gap-2 border-t border-line pt-3">
          <a href="${detailHref}" class="btn-ghost flex-1 !py-2 text-xs">Detail</a>
          ${b.status === "menunggu" ? `<button data-cancel="${b.id}" class="btn-danger flex-1 !py-2 text-xs">Batalkan</button>` : ""}
        </div>`
        : "";

  return `
  <article class="card border-l-4 ${BORDER[b.status] || "border-l-slate-300"} p-4">
    <div class="flex items-start justify-between gap-2">
      <div>
        <p class="text-xs font-bold uppercase tracking-wide text-brand">${b.code}</p>
        <h3 class="text-base font-bold text-slate-900">${b.item}</h3>
        <p class="text-sm text-slate-500">${b.activity}</p>
      </div>
      ${StatusBadge(b.status)}
    </div>
    <dl class="mt-3 grid grid-cols-2 gap-x-4 gap-y-2 text-xs">
      <div><dt class="font-semibold text-slate-500">Peminjam</dt><dd class="text-slate-800">${b.borrower} <span class="text-slate-400">(${b.role})</span></dd></div>
      <div><dt class="font-semibold text-slate-500">Email</dt><dd class="truncate text-slate-800">${b.email}</dd></div>
      <div><dt class="font-semibold text-slate-500">PIC</dt><dd class="text-slate-800">${b.pic}</dd></div>
      <div><dt class="font-semibold text-slate-500">No. Telp</dt><dd class="text-slate-800">${b.phone}</dd></div>
      <div><dt class="font-semibold text-slate-500">Hari/Tanggal</dt><dd class="text-slate-800">${b.date}</dd></div>
      <div><dt class="font-semibold text-slate-500">Waktu</dt><dd class="text-slate-800">${b.start} - ${b.end}</dd></div>
      <div><dt class="font-semibold text-slate-500">Jenis</dt><dd class="capitalize text-slate-800">${b.type}</dd></div>
      <div><dt class="font-semibold text-slate-500">Kegiatan</dt><dd class="text-slate-800">${b.kind}</dd></div>
    </dl>
    ${actions}
  </article>`;
}
