// ApprovalController.js â€“ halaman persetujuan (koordinator & admin): setujui/tolak mock
import { Controller } from "@/core/Controller.js";
import { DashboardLayout } from "@/views/layouts/DashboardLayout.js";
import { approvals } from "@/views/pages/user/approvals.js";
import { BookingModel } from "@/models/BookingModel.js";

export class ApprovalController extends Controller {
    async index() {
        const bookings = new BookingModel();
        const isAdmin = this.user?.role === "admin";
        const state = { tab: "alat", status: "", q: "" };

        const draw = () => {
            const stats = bookings.stats();
            const rows = bookings
                .all()
                .filter(
                    (b) =>
                        b.type === state.tab &&
                        (!state.status || b.status === state.status) &&
                        (!state.q ||
                            `${b.item} ${b.code} ${b.borrower}`
                                .toLowerCase()
                                .includes(state.q.toLowerCase())),
                );
            const data = {
                title: "Halaman Peminjaman",
                crumbs: [
                    {
                        label: "Dashboard",
                        href: `#${isAdmin ? "/admin" : "/dashboard"}`,
                    },
                    { label: "Persetujuan" },
                ],
                routePath: isAdmin ? "/admin/persetujuan" : "/persetujuan",
                stats,
                rows,
                state,
            };
            this.setLayout(DashboardLayout);
            this.render(approvals(data), data);
            this.bind(state, draw, bookings);
        };
        draw();
    }

    bind(state, draw, bookings) {
        document.getElementById("tab-alat")?.addEventListener("click", () => {
            state.tab = "alat";
            draw();
        });
        document
            .getElementById("tab-ruangan")
            ?.addEventListener("click", () => {
                state.tab = "ruangan";
                draw();
            });
        document
            .getElementById("ap-status")
            ?.addEventListener("change", (e) => {
                state.status = e.target.value;
                draw();
            });
        document.getElementById("ap-search")?.addEventListener("input", (e) => {
            state.q = e.target.value;
            draw();
        });
        document
            .querySelectorAll("[data-approve],[data-reject]")
            .forEach((b) => {
                const id = b.dataset.approve || b.dataset.reject;
                const status = b.dataset.approve ? "disetujui" : "ditolak";
                b.addEventListener("click", () => {
                    bookings.save({ id: Number(id), status });
                    draw();
                });
            });
    }
}
export default ApprovalController;


