// Topbar.js – topbar dashboard: tombol drawer mobile, breadcrumb, user kanan atas
import { icon } from "./icons.js";

export function Topbar({ title, crumbs = [] }) {
  const bc = crumbs.length
    ? crumbs
        .map((c, i) =>
          i < crumbs.length - 1
            ? `<a href="${c.href}" class="hover:text-brand">${c.label}</a>`
            : `<span class="font-semibold text-slate-700" aria-current="page">${c.label}</span>`,
        )
        .join(`<span class="mx-1 text-slate-300">/</span>`)
    : "";
  const user = window.__mysbumUser || { name: "Pengguna", roleLabel: "" };

  return `
  <header class="sticky top-0 z-30 flex items-center gap-3 border-b border-line bg-white/90 px-4 py-3 backdrop-blur lg:px-8">
    <button id="btn-open-sidebar" class="rounded-md p-1.5 text-slate-500 hover:bg-slate-100 lg:hidden" aria-label="Buka menu">
      ${icon("menu", "h-6 w-6")}
    </button>
    <nav class="hidden text-sm text-slate-500 lg:block" aria-label="Breadcrumb">${bc}</nav>
    <h1 class="text-sm font-semibold text-slate-500 lg:hidden">${title || ""}</h1>
    <div class="ml-auto flex items-center gap-3">
      <button class="rounded-md p-1.5 text-slate-400 hover:bg-slate-100" aria-label="Notifikasi">${icon("bell", "h-5 w-5")}</button>
      <div class="flex items-center gap-2 rounded-full border border-line py-1 pl-1 pr-3">
        <span class="grid h-8 w-8 place-items-center rounded-full bg-brand text-xs font-bold text-white">${(user.name || "?").charAt(0)}</span>
        <div class="hidden sm:block">
          <p class="text-xs font-semibold leading-tight text-slate-800">${user.name || ""}</p>
          <p class="text-[11px] leading-tight text-slate-500">${user.roleLabel || ""}</p>
        </div>
      </div>
    </div>
  </header>`;
}
