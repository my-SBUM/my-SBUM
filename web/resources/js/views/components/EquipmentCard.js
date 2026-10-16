// EquipmentCard.js – kartu peralatan: foto, badge status, kategori, stok, aksi
import { StatusBadge } from "./StatusBadge.js";
import { icon } from "./icons.js";

export function EquipmentCard(eq) {
  return `
  <article class="card overflow-hidden flex flex-col">
    <div class="relative h-40 bg-brand-soft">
      <img src="${eq.image}" alt="${eq.name}" class="h-full w-full object-cover" loading="lazy" />
      <span class="absolute right-3 top-3">${StatusBadge(eq.status)}</span>
    </div>
    <div class="flex flex-1 flex-col p-4">
      <p class="mb-1 flex items-center gap-1 text-xs font-medium text-slate-500">
        ${icon("package", "h-3.5 w-3.5")} ${eq.category} &middot; ${eq.location}
      </p>
      <h3 class="text-base font-bold text-slate-900">${eq.name}</h3>
      <p class="mt-1 mb-4 flex-1 text-sm text-slate-500">${eq.description}</p>
      <p class="mb-3 text-xs font-semibold text-slate-600">Stok: <span class="text-brand">${eq.available}</span> dari ${eq.stock} unit</p>
      <div class="flex gap-2">
        <a href="#/alat" class="btn-ghost flex-1 !py-2 text-xs">Detail</a>
        ${eq.status === "tersedia" ? `<button data-equip="${eq.id}" class="btn-primary flex-1 !py-2 text-xs">Pinjam Peralatan</button>` : `<button class="btn-primary flex-1 !py-2 text-xs opacity-50" disabled>Pinjam Peralatan</button>`}
      </div>
    </div>
  </article>`;
}
