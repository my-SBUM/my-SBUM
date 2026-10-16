// Router.js – hash router: guard role, 404, pasang controller@method
import { routes } from "@/config/routes.js";
import { Store } from "@/core/Store.js";

export const Router = {
  init() {
    window.addEventListener("hashchange", () => this.resolve());
    this.resolve();
  },

  navigate(path) {
    location.hash = `#${path}`;
  },

  currentPath() {
    const raw = location.hash.replace(/^#/, "") || "/";
    return raw.split("?")[0];
  },

  resolve() {
    const path = this.currentPath();
    const route = this.match(path);

    if (!route) {
      this.render404();
      return;
    }

    const user = Store.getUser();
    if (route.roles[0] !== "publik" && !user) {
      this.navigate("/login");
      return;
    }
    if (route.roles[0] !== "publik" && !route.roles.includes(user.role)) {
      // role tidak berhak: alihkan ke dashboard sesuai role
      this.navigate(user.role === "admin" ? "/admin" : "/dashboard");
      return;
    }

    this.dispatch(route, path);
  },

  /** Cocokkan path dengan pola :param */
  match(path) {
    for (const r of routes) {
      const parts = r.path.split("/");
      const cur = path.split("/");
      if (parts.length !== cur.length) continue;
      const params = {};
      let ok = true;
      for (let i = 0; i < parts.length; i++) {
        if (parts[i].startsWith(":"))
          params[parts[i].slice(1)] = decodeURIComponent(cur[i]);
        else if (parts[i] !== cur[i]) {
          ok = false;
          break;
        }
      }
      if (ok) return { ...r, params };
    }
    return null;
  },

  async dispatch(route, path) {
    const mod = await import(`@/controllers/${route.controller}.js`);
    const CtrlClass = mod.default;
    const ctrl = new CtrlClass();
    ctrl.routeParams = route.params || {};
    ctrl.user = Store.getUser();
    ctrl[route.method](this.queryOf(path));
  },

  queryOf(path) {
    const q = location.hash.split("?")[1] || "";
    return Object.fromEntries(new URLSearchParams(q));
  },

  render404() {
    document.getElementById("app").innerHTML = `
      <div class="flex min-h-screen flex-col items-center justify-center gap-4 bg-surface p-8 text-center">
        <p class="text-6xl font-extrabold text-brand">404</p>
        <h1 class="text-xl font-bold">Halaman tidak ditemukan</h1>
        <p class="text-sm text-slate-500">Route <code>${this.currentPath()}</code> tidak terdaftar.</p>
        <a href="#/" class="btn-primary mt-2">Kembali ke Beranda</a>
      </div>`;
  },
};
