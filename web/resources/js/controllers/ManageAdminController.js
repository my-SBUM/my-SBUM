// ManageAdminController.js â€“ daftar/tambah/edit/hapus admin (persist ke localStorage)
import { Controller } from "@/core/Controller.js";
import { DashboardLayout } from "@/views/layouts/DashboardLayout.js";
import { adminList } from "@/views/pages/admin/admins.js";
import { adminForm } from "@/views/pages/admin/admin-form.js";
import { AdminModel } from "@/models/AdminModel.js";
import { Router } from "@/core/Router.js";

export class ManageAdminController extends Controller {
    async index() {
        const model = new AdminModel();
        const state = { q: "", page: 1 };
        const PER = 5;

        const draw = () => {
            const rows = model.filter(
                (a) =>
                    !state.q ||
                    `${a.name} ${a.nip}`
                        .toLowerCase()
                        .includes(state.q.toLowerCase()),
            );
            const pages = Math.max(1, Math.ceil(rows.length / PER));
            state.page = Math.min(state.page, pages);
            const data = {
                title: "Kelola Admin",
                crumbs: [
                    { label: "Dashboard", href: "#/admin" },
                    { label: "Kelola Admin" },
                ],
                routePath: "/admin/kelola-admin",
                rows: rows.slice((state.page - 1) * PER, state.page * PER),
                total: rows.length,
                pages,
                page: state.page,
                stats: {
                    total: 45,
                    pic: 12,
                    dosen: 30,
                    nonaktif: rows.filter((a) => a.status === "nonaktif")
                        .length,
                },
                state,
            };
            this.setLayout(DashboardLayout);
            this.render(adminList(data), data);
            this.bind(state, draw, model);
        };
        draw();
    }

    bind(state, draw, model) {
        document.getElementById("a-search")?.addEventListener("input", (e) => {
            state.q = e.target.value;
            state.page = 1;
            draw();
        });
        document.querySelectorAll("[data-page]").forEach((b) => {
            b.addEventListener("click", () => {
                state.page = Number(b.dataset.page);
                draw();
            });
        });
        document.querySelectorAll("[data-del]").forEach((b) => {
            b.addEventListener("click", () => {
                if (!confirm("Hapus administrator ini?")) return;
                model.remove(b.dataset.del);
                draw();
            });
        });
    }

    async create() {
        const data = {
            title: "Tambah Administrator",
            crumbs: [
                { label: "Dashboard", href: "#/admin" },
                { label: "Kelola Admin", href: "#/admin/kelola-admin" },
                { label: "Tambah" },
            ],
            routePath: "/admin/kelola-admin/tambah",
            admin: null,
        };
        this.setLayout(DashboardLayout);
        this.render(adminForm(data), data);
        this.bindForm(
            new AdminModel(),
            data,
            "Administrator baru berhasil disimpan.",
        );
    }

    async edit() {
        const model = new AdminModel();
        const admin = model.find(this.routeParams?.id);
        if (!admin) return Router.navigate("/admin/kelola-admin");
        const data = {
            title: "Edit Administrator",
            crumbs: [
                { label: "Dashboard", href: "#/admin" },
                { label: "Kelola Admin", href: "#/admin/kelola-admin" },
                { label: "Edit" },
            ],
            routePath: `/admin/kelola-admin/${admin.id}/edit`,
            admin,
        };
        this.setLayout(DashboardLayout);
        this.render(adminForm(data), data);
        this.bindForm(
            model,
            data,
            "Perubahan administrator berhasil disimpan.",
        );
    }

    bindForm(model, data, msg) {
        const form = document.getElementById("form-admin");
        form.addEventListener("submit", (e) => {
            e.preventDefault();
            if (!form.reportValidity()) return;
            const row = {
                id: data.admin?.id || undefined,
                name: form.aname.value.trim(),
                email: form.aemail.value.trim(),
                nip: form.anip.value.trim(),
                phone: form.aphone.value.trim(),
                department: form.adept.value.trim(),
                status: form.astatus.checked ? "aktif" : "nonaktif",
            };
            model.save(row);
            alert(msg);
            Router.navigate("/admin/kelola-admin");
        });
    }
}
export default ManageAdminController;






