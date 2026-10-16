// user/room-list.js – katalog peminjaman ruangan (PDF 1 & 2)
import { RoomCard } from "@/views/components/RoomCard.js";
import { SearchFilterBar } from "@/views/components/SearchFilterBar.js";
import { Pagination } from "@/views/components/Pagination.js";

export function roomList({
    rooms,
    pagination,
    info,
    buildings,
    floors,
    state,
}) {
    return `
  <div class="mb-6">
    <h2 class="text-2xl font-extrabold text-slate-900">Peminjaman Ruangan</h2>
    <p class="mt-1 text-sm text-slate-500">Cari dan pilih ruangan yang tersedia untuk kegiatanmu.</p>
  </div>
  ${SearchFilterBar({
      searchId: "room-search",
      q: state.q,
      placeholder: "Cari ruangan, gedung, atau kode...",
      filters: [
          {
              id: "filter-building",
              label: "Gedung",
              value: state.building,
              options: buildings.map((b) => [b, b]),
          },
          {
              id: "filter-floor",
              label: "Lantai",
              value: state.floor,
              options: floors.map((f) => [f, f]),
          },
      ],
  })}
  <div class="grid gap-5 sm:grid-cols-2 lg:grid-cols-3">
    ${rooms.map((r) => RoomCard(r)).join("")}
  </div>
  ${rooms.length === 0 ? '<p class="card mt-6 p-8 text-center text-sm text-slate-400">Tidak ada ruangan yang cocok dengan filter.</p>' : ""}
  <div class="mt-6 flex flex-col items-center gap-3">
    ${pagination}
    <p class="text-xs text-slate-400">${info}</p>
  </div>`;
}
