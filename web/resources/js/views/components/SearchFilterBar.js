// SearchFilterBar.js – search bar + dropdown filter; pasangan state dari controller
import { icon } from "./icons.js";

/** data: { searchId, q, placeholder, filters: [{ id, label, value, options: [value,label][] }] } */
export function SearchFilterBar({
  searchId = "search",
  q = "",
  placeholder = "Cari...",
  filters = [],
}) {
  return `
  <div class="card mb-6 flex flex-col gap-3 p-4 md:flex-row md:items-center">
    <div class="relative flex-1">
      <span class="pointer-events-none absolute left-3 top-1/2 -translate-y-1/2 text-slate-400">${icon("search", "h-5 w-5")}</span>
      <input type="search" id="${searchId}" value="${q}" class="input !pl-10" placeholder="${placeholder}" aria-label="Pencarian" />
    </div>
    ${filters
      .map(
        (f) => `
      <select id="${f.id}" class="input md:w-44" aria-label="${f.label}">
        <option value="">${f.label}: Semua</option>
        ${(f.options || []).map(([v, l]) => `<option value="${v}" ${f.value === v ? "selected" : ""}>${l}</option>`).join("")}
      </select>`,
      )
      .join("")}
  </div>`;
}
