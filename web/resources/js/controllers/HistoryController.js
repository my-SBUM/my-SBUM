// HistoryController.js â€“ riwayat peminjaman: tab status, search, batalkan (modal)
import { Controller } from "@/core/Controller.js";
import { DashboardLayout } from "@/views/layouts/DashboardLayout.js";
import { history } from "@/views/pages/user/history.js";
import { BookingModel } from "@/models/BookingModel.js";

export class HistoryController extends Controller {
    async index() {
        const bookings = new BookingModel();
        const state = { tab: "semua", q: "" };

        const draw = () => {
            const all = bookings.all();
            const counts = {
                semua: all.length,
                disetujui: 0,
                menunggu: 0,
                ditolak: 0,
            };
            all.forEach(
                (b) => counts[b.status] !== undefined && counts[b.status]++,
            );
            const rows = all.filter(
                (b) =>
                    (state.tab === "semua" || b.status === state.tab) &&
                    (!state.q ||
                        `${b.item} ${b.code} ${b.activity} ${b.borrower}`
                            .toLowerCase()
                            .includes(state.q.toLowerCase())),
            );
            const data = {
                title: "Riwayat & Log",
                crumbs: [
                    { label: "Dashboard", href: "#/dashboard" },
                    { label: "Riwayat" },
                ],
                routePath: "/riwayat",
                counts,
                rows,
                state,
            };
            this.setLayout(DashboardLayout);
            this.render(history(data), data);
            this.bind(state, draw, bookings);
        };
        draw();
    }

    bind(state, draw, bookings) {
        document.querySelectorAll("[data-tab]").forEach((t) => {
            t.addEventListener("click", () => {
                state.tab = t.dataset.tab;
                draw();
            });
        });
        document.getElementById("h-search")?.addEventListener("input", (e) => {
            state.q = e.target.value;
            draw();
        });
        document.querySelectorAll("[data-cancel]").forEach((b) => {
            b.addEventListener("click", () => {
                const id = b.dataset.cancel;
                const wrap = document.createElement("div");
                wrap.className =
                    "fixed inset-0 z-50 grid place-items-center bg-black/50 p-4";
                wrap.innerHTML = `<div class="card max-w-sm w-full p-6 text-center">
          <h3 class="mb-2 text-lg font-bold text-slate-800">Batalkan Peminjaman?</h3>
          <p class="mb-5 text-sm text-slate-500">Pengajuan dengan kode <b>${bookings.find(id)?.code || ""}</b> akan dibatalkan.</p>
          <div class="flex gap-2 justify-center">
            <button id="mc-no" class="btn-ghost">Batal</button>
            <button id="mc-yes" class="btn-danger">Ya, Batalkan</button>
          </div></div>`;
                document.body.appendChild(wrap);
                wrap.querySelector("#mc-no").onclick = () => wrap.remove();
                wrap.querySelector("#mc-yes").onclick = () => {
                    bookings.save({ id: Number(id), status: "ditolak" });
                    wrap.remove();
                    draw();
                };
            });
        });
    }
}
export default HistoryController;


