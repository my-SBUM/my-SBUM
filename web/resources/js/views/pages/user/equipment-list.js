// user/equipment-list.js – katalog peminjaman peralatan (PDF 1 & 2)
import { EquipmentCard } from "@/views/components/EquipmentCard.js";
import { SearchFilterBar } from "@/views/components/SearchFilterBar.js";
import { Pagination } from "@/views/components/Pagination.js";

export function equipmentList({ equips, pagination, info, categories, state }) {
    return `
  <div class="mb-6">
    <h2 class="text-2xl font-extrabold text-slate-900">Peminjaman Peralatan</h2>
    <p class="mt-1 text-sm text-slate-500">Cari dan pinjam peralatan yang tersedia di SBUM.</p>
  </div>
  ${SearchFilterBar({
      searchId: "equip-search",
      q: state.q,
      placeholder: "Cari peralatan atau kode aset...",
      filters: [
          {
              id: "filter-category",
              label: "Jenis Alat",
              value: state.category,
              options: categories.map((c) => [c, c]),
          },
          {
              id: "filter-status",
              label: "Status",
              value: state.status,
              options: [
                  ["tersedia", "Tersedia"],
                  ["tidak-tersedia", "Tidak Tersedia"],
              ],
          },
      ],
  })}
  <div class="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
    ${equips.map((e) => EquipmentCard(e)).join("")}
  </div>
  ${equips.length === 0 ? '<p class="card mt-6 p-8 text-center text-sm text-slate-400">Tidak ada peralatan yang cocok dengan filter.</p>' : ""}
  <div class="mt-6 flex flex-col items-center gap-3">
    ${pagination}
    <p class="text-xs text-slate-400">${info}</p>
  </div>`;
}
