// Breadcrumb.js – navigasi breadcrumb di bawah topbar
export function Breadcrumb(items = []) {
  // items: [{label, href?}]
  const parts = items.map((it, i) =>
    it.href && i < items.length - 1
      ? `<a href="${it.href}" class="hover:text-brand">${it.label}</a>`
      : `<span class="font-semibold text-slate-700" aria-current="page">${it.label}</span>`,
  );
  return `<nav aria-label="Breadcrumb" class="mb-4 flex items-center gap-1 text-sm text-slate-500">
    ${parts.join(`<span class="text-slate-300">/</span>`)}
  </nav>`;
}
