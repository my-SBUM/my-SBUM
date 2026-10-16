// admin/admins.js – daftar administrator (PDF 7)
export function adminList({ rows, total, pages, page, stats }) {
    const trs = rows
        .map(
            (a) => `
    <tr class="border-b border-line last:border-0">
      <td class="py-3 pl-4 pr-2">
        <p class="text-sm font-semibold text-slate-800">${a.name}</p>
        <p class="text-xs text-slate-400">NIP ${a.nip}</p>
      </td>
      <td class="px-2 py-3 text-sm text-slate-600">${a.department}</td>
      <td class="px-2 py-3">
        <span class="rounded-full px-2.5 py-0.5 text-[11px] font-bold ${a.status === "aktif" ? "bg-status-disetujui-bg text-status-disetujui" : "bg-slate-200 text-slate-500"}">${a.status.toUpperCase()}</span>
      </td>
      <td class="py-3 pl-2 pr-4 text-right">
        <a href="#/admin/kelola-admin/${a.id}/edit" class="rounded-md p-1.5 text-slate-400 hover:bg-slate-100 hover:text-brand" title="Edit">✎</a>
        <button data-del="${a.id}" class="rounded-md p-1.5 text-slate-400 hover:bg-red-50 hover:text-red-600" title="Hapus">🗑</button>
      </td>
    </tr>`,
        )
        .join("");

    return `
  <div class="mb-6 flex flex-wrap items-end justify-between gap-3">
    <div>
      <h2 class="text-2xl font-extrabold text-slate-900">Kelola Admin</h2>
      <p class="mt-1 text-sm text-slate-500">Daftar administrator &amp; otoritas sistem mySBUM.</p>
    </div>
    <a href="#/admin/kelola-admin/tambah" class="btn-primary">Tambah Admin Baru</a>
  </div>
  <div class="mb-6 grid gap-4 sm:grid-cols-2 xl:grid-cols-4">
    ${[
        ["Total Pengguna Aktif", stats.total, "Akun"],
        ["PIC Laboratorium", stats.pic, "PIC"],
        ["Dosen Pembina", stats.dosen, "Dosen"],
        ["Akun Nonaktif/Suspend", stats.nonaktif, "Akun"],
    ]
        .map(
            ([l, v, s]) =>
                `<div class="card p-4"><p class="text-xs text-slate-400">${l}</p><p class="text-2xl font-extrabold text-slate-800">${v}</p><p class="text-[11px] text-slate-400">${s}</p></div>`,
        )
        .join("")}
  </div>
  <div class="card">
    <div class="flex items-center justify-between border-b border-line px-4 py-3.5">
      <h3 class="text-sm font-bold text-slate-800">Daftar Administrator &amp; Otoritas</h3>
      <input id="a-search" class="input !w-64 !py-2 text-sm" placeholder="Cari nama / NIP...">
    </div>
    <table class="w-full text-left">
      <thead><tr class="border-b border-line text-[11px] uppercase tracking-wide text-slate-400">
        <th class="py-2.5 pl-4 pr-2 font-semibold">Pengguna &amp; NIP</th>
        <th class="px-2 py-2.5 font-semibold">Departemen / Unit Kerja</th>
        <th class="px-2 py-2.5 font-semibold">Status</th>
        <th class="py-2.5 pl-2 pr-4 text-right font-semibold">Aksi</th>
      </tr></thead>
      <tbody>${trs || '<tr><td colspan="4" class="p-4 text-sm text-slate-400">Tidak ada data.</td></tr>'}</tbody>
    </table>
    <div class="flex items-center justify-between px-4 py-3 text-xs text-slate-400">
      <span>Menampilkan ${rows.length} dari ${total} administrator</span>
      <div class="flex gap-1">
        ${Array.from({ length: pages }, (_, i) => i + 1)
            .map(
                (p) => `
          <button data-page="${p}" class="rounded-md px-2.5 py-1 font-semibold ${p === page ? "bg-brand text-white" : "bg-slate-100 text-slate-600 hover:bg-slate-200"}">${p}</button>`,
            )
            .join("")}
      </div>
    </div>
  </div>`;
}
