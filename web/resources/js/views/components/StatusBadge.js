// StatusBadge.js – badge status peminjaman/ruangan/alat dengan warna konsisten
const MAP = {
  menunggu: ["bg-status-menunggu-bg text-amber-600", "Menunggu"],
  disetujui: ["bg-status-disetujui-bg text-status-disetujui", "Disetujui"],
  diterima: ["bg-status-disetujui-bg text-status-disetujui", "Diterima"],
  ditolak: ["bg-status-ditolak-bg text-status-ditolak", "Ditolak"],
  tersedia: ["bg-status-disetujui-bg text-status-disetujui", "Tersedia"],
  "tidak-tersedia": [
    "bg-status-tidak-tersedia-bg text-red-500",
    "Tidak Tersedia",
  ],
};

export function StatusBadge(status, labelOverride = "") {
  const [cls, label] = MAP[status] || ["bg-slate-100 text-slate-600", status];
  return `<span class="inline-flex items-center rounded-full px-2.5 py-1 text-[11px] font-bold uppercase tracking-wide ${cls}">${labelOverride || label}</span>`;
}
