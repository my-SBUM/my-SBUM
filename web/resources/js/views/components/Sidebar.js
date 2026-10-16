// Sidebar.js – navigasi samping dashboard: menu per role, collapse & drawer mobile
import { menus } from "@/config/menu.js";
import { icon } from "./icons.js";

export function Sidebar(routePath) {
  const user = window.__mysbumUser || { name: "Pengguna", roleLabel: "" };
  const items = menus[user.role] || menus.koordinator;

  const link = (m) => {
    const active = routePath === m.path;
    return `
    <a href="#${m.path}" ${active ? 'aria-current="page"' : ""}
       class="flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium transition
              ${active ? "bg-brand text-white shadow-sm" : "text-slate-600 hover:bg-slate-100 hover:text-brand"}">
      ${icon(m.icon, "h-5 w-5 shrink-0")}
      <span>${m.label}</span>
    </a>`;
  };

  return `
  <aside id="sidebar" class="fixed inset-y-0 left-0 z-50 flex w-64 -translate-x-full flex-col border-r border-line bg-white transition-transform lg:translate-x-0" aria-label="Sidebar navigasi">
    <div class="flex items-center justify-between px-4 py-4">
      <a href="#/" class="flex items-center gap-2">
        <span class="grid h-9 w-9 place-items-center rounded-lg bg-brand text-white font-extrabold">S</span>
        <span class="font-extrabold text-slate-900">mySBUM</span>
      </a>
      <button id="btn-collapse" class="rounded-md p-1.5 text-slate-400 hover:bg-slate-100 hover:text-brand" title="Collapse sidebar" aria-label="Collapse sidebar">
        ${icon("panel-left", "h-5 w-5")}
      </button>
    </div>
    <nav class="flex-1 space-y-1 overflow-y-auto px-3 pb-4">
      <p class="mb-2 px-3 text-[11px] font-bold uppercase tracking-widest text-slate-400">Operasional Utama</p>
      ${items.map(link).join("")}
    </nav>
    <div class="border-t border-line p-4">
      <div class="flex items-center gap-3">
        <span class="grid h-9 w-9 place-items-center rounded-full bg-brand-soft text-brand font-bold">${(user.name || "?").charAt(0)}</span>
        <div class="min-w-0">
          <p class="truncate text-sm font-semibold text-slate-800">${user.name || ""}</p>
          <p class="truncate text-xs text-slate-500">${user.roleLabel || user.role || ""}</p>
        </div>
        <a href="#/login" id="btn-logout" class="ml-auto rounded-md p-1.5 text-slate-400 hover:bg-red-50 hover:text-red-600" title="Keluar" aria-label="Keluar">
          ${icon("logout", "h-5 w-5")}
        </a>
      </div>
    </div>
  </aside>
  <div id="sidebar-backdrop" class="fixed inset-0 z-40 hidden bg-black/40 lg:hidden"></div>`;
}

/** Pasang perilaku collapse/drawer sidebar (dipanggil oleh DashboardLayout setelah render) */
export function initSidebar() {
  const aside = document.getElementById("sidebar");
  const backdrop = document.getElementById("sidebar-backdrop");
  const collapse = document.getElementById("btn-collapse");
  const openBtn = document.getElementById("btn-open-sidebar");
  const logout = document.getElementById("btn-logout");
  if (!aside) return;

  const close = () => {
    aside.classList.add("-translate-x-full");
    backdrop?.classList.add("hidden");
  };
  const open = () => {
    aside.classList.remove("-translate-x-full");
    backdrop?.classList.remove("hidden");
  };

  collapse?.addEventListener("click", () => close());
  openBtn?.addEventListener("click", open);
  backdrop?.addEventListener("click", close);
  logout?.addEventListener("click", () => {
    localStorage.removeItem("mysbum:user");
  });
}
