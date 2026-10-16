// RoomCard.js – kartu ruangan: foto, badge status, nama, deskripsi, aksi Detail & Pinjam
import { StatusBadge } from "./StatusBadge.js";
import { icon } from "./icons.js";

export function RoomCard(room) {
  return `
  <article class="card overflow-hidden flex flex-col">
    <div class="relative h-40 bg-brand-soft">
      <img src="${room.image}" alt="${room.name}" class="h-full w-full object-cover" loading="lazy" />
      <span class="absolute right-3 top-3">${StatusBadge(room.status)}</span>
    </div>
    <div class="flex flex-1 flex-col p-4">
      <p class="mb-1 flex items-center gap-1 text-xs font-medium text-slate-500">
        ${icon("map", "h-3.5 w-3.5")} ${room.building} &middot; ${room.floor}
      </p>
      <h3 class="text-base font-bold text-slate-900">${room.name}</h3>
      <p class="mt-1 mb-4 flex-1 text-sm text-slate-500">${room.description}</p>
      <div class="flex gap-2">
        <a href="#/ruangan" class="btn-ghost flex-1 !py-2 text-xs">Detail</a>
        ${room.status === "tersedia" ? `<button data-room="${room.id}" class="btn-primary flex-1 !py-2 text-xs">Pinjam Ruangan</button>` : `<button class="btn-primary flex-1 !py-2 text-xs opacity-50" disabled>Pinjam Ruangan</button>`}
      </div>
    </div>
  </article>`;
}
