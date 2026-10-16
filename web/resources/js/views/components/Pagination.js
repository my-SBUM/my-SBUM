// Pagination.js – kontrol halaman: Pagination(page, pages, onSelect) + initPagination()
export function Pagination(page, pages, onSelect) {
  window.__gotoPage = (p) => onSelect && onSelect(p);
  const btn = (p, label = p, active = p === page) => `
    <button data-page-goto="${p}" ${active ? 'aria-current="page"' : ""} class="rounded-md px-3 py-1.5 text-xs font-semibold transition
      ${active ? "bg-brand text-white" : "border border-line bg-white text-slate-600 hover:bg-slate-50"}">${label}</button>`;
  let out = "";
  if (page > 1) out += btn(page - 1, "‹");
  for (let i = 1; i <= pages; i++) out += btn(i);
  if (page < pages) out += btn(page + 1, "›");
  return `<div class="flex items-center gap-1.5">${out}</div>`;
}

/** Pasang listener tombol halaman (dipanggil controller setelah render) */
export function initPagination(root = document) {
  root.querySelectorAll("[data-page-goto]").forEach((b) => {
    b.addEventListener("click", () => window.__gotoPage?.(Number(b.dataset.pageGoto)));
  });
}
