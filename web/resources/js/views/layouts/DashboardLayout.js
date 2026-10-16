// Layouts/DashboardLayout.js – sidebar + topbar + slot konten utama
import { Sidebar, initSidebar } from "@/views/components/Sidebar.js";
import { Topbar } from "@/views/components/Topbar.js";

/** Bungkus konten dashboard; data: { title, crumbs, routePath, user } */
export function DashboardLayout(content, data = {}) {
  const { title = "", crumbs = [], routePath = "", user = {} } = data;
  window.__mysbumUser = user; // sederhana: dibaca Sidebar/Topbar (di-init setelahnya oleh controller)

  const layout = `
  <div class="min-h-screen bg-surface">
    ${Sidebar(routePath)}
    <div id="dash-main" class="lg:pl-64">
      ${Topbar({ title, crumbs })}
      <main class="mx-auto max-w-7xl px-4 py-6 lg:px-8">${content}</main>
    </div>
  </div>`;
  // pasang event setelah DOM terpasang
  setTimeout(initSidebar, 0);
  return layout;
}
