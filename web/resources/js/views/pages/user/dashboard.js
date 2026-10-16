// user/dashboard.js – dashboard Koordinator Lab (PDF 1 & 2)
import { StatCard } from "@/views/components/StatCard.js";
import { StatusBadge } from "@/views/components/StatusBadge.js";
import { ActivityFeed } from "@/views/components/ActivityFeed.js";
import { icon } from "@/views/components/icons.js";

export function dashboard({
    stats,
    totalRooms,
    totalEquips,
    pending,
    activities,
}) {
    const rows = pending
        .map(
            (b) => `
    <tr class="border-b border-line last:border-0">
      <td class="py-3 pl-4 pr-2">
        <p class="text-sm font-semibold text-slate-800">${b.item}</p>
        <p class="text-xs text-slate-400">${b.code}</p>
      </td>
      <td class="px-2 py-3">
        <p class="text-xs text-slate-500">${b.type === "ruangan" ? "Ruangan" : "Peralatan"} • ${b.date} • ${b.start}–${b.end}</p>
        ${b.pic ? `<p class="text-xs text-slate-400">PIC: ${b.pic}</p>` : ""}
      </td>
      <td class="py-3 pl-2 pr-4 text-right">${StatusBadge(b.status)}</td>
    </tr>`,
        )
        .join("");

    return `
  <div class="mb-6">
    <h2 class="text-2xl font-extrabold text-slate-900">Halaman Dashboard</h2>
    <p class="mt-1 text-sm text-slate-500">Ringkasan aktivitas peminjaman hari ini.</p>
  </div>
  <div class="mb-6 grid gap-4 md:grid-cols-3">
    ${StatCard("Perlu disetujui", stats.menunggu, "Fasilitas", { badge: "Butuh Tindakan Segera", badgeClass: "bg-status-menunggu-bg text-amber-600", tone: "text-status-menunggu", ic: "check-circle" })}
    ${StatCard("Total ruangan", totalRooms, "", { sub: `${stats.ruanganAktif} dalam peminjaman`, ic: "building" })}
    ${StatCard("Total Peralatan", totalEquips, "", { sub: `${stats.alatAktif} dalam peminjaman`, ic: "package" })}
  </div>
  <div class="grid gap-6 lg:grid-cols-3">
    <div class="card lg:col-span-2">
      <div class="flex items-center justify-between border-b border-line px-4 py-3.5">
        <h3 class="text-sm font-bold text-slate-800">Peminjaman yang diajukan</h3>
        <a href="#/persetujuan" class="text-xs font-semibold text-brand hover:underline">Lihat Semua (${stats.menunggu})</a>
      </div>
      <table class="w-full text-left">
        <thead><tr class="border-b border-line text-[11px] uppercase tracking-wide text-slate-400">
          <th class="py-2.5 pl-4 pr-2 font-semibold">Item Peminjaman</th>
          <th class="px-2 py-2.5 font-semibold">Kategori & Waktu</th>
          <th class="py-2.5 pl-2 pr-4 text-right font-semibold">Status</th>
        </tr></thead>
        <tbody>${rows || '<tr><td colspan="3" class="p-4 text-sm text-slate-400">Tidak ada pengajuan menunggu.</td></tr>'}</tbody>
      </table>
    </div>
    <div class="card">
      <div class="flex items-center justify-between border-b border-line px-4 py-3.5">
        <h3 class="text-sm font-bold text-slate-800">Aktivitas Terbaru</h3>
        <a id="link-all-activity" href="#/riwayat" class="text-xs font-semibold text-brand hover:underline">Lihat Semua Aktivitas &gt;</a>
      </div>
      <div class="p-4">${ActivityFeed(activities)}</div>
    </div>
  </div>`;
}
