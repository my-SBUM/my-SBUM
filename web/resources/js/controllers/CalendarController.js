// CalendarController.js â€“ kalender peminjaman (grid bulanan + panel detail tanggal)
import { Controller } from "@/core/Controller.js";
import { DashboardLayout } from "@/views/layouts/DashboardLayout.js";
import { calendar } from "@/views/pages/admin/calendar.js";
import { BookingModel } from "@/models/BookingModel.js";

export class CalendarController extends Controller {
    async index() {
        const bookings = new BookingModel();
        const today = new Date();
        const state = {
            year: today.getFullYear(),
            month: today.getMonth(),
            type: "",
            status: "",
        };

        const draw = () => {
            const data = {
                title: "Kalender Peminjaman",
                crumbs: [
                    { label: "Dashboard", href: "#/admin" },
                    { label: "Kalender" },
                ],
                routePath: "/admin/kalender",
                stats: bookings.stats(),
                bookings: bookings.all(),
                state,
            };
            this.setLayout(DashboardLayout);
            this.render(calendar(data), data);
            this.bind(state, draw, bookings);
        };
        draw();
    }

    bind(state, draw, bookings) {
        document.getElementById("cal-prev")?.addEventListener("click", () => {
            state.month--;
            if (state.month < 0) {
                state.month = 11;
                state.year--;
            }
            draw();
        });
        document.getElementById("cal-next")?.addEventListener("click", () => {
            state.month++;
            if (state.month > 11) {
                state.month = 0;
                state.year++;
            }
            draw();
        });
        document.getElementById("cal-today")?.addEventListener("click", () => {
            const t = new Date();
            state.year = t.getFullYear();
            state.month = t.getMonth();
            draw();
        });
        document.getElementById("cal-type")?.addEventListener("change", (e) => {
            state.type = e.target.value;
            draw();
        });
        document
            .getElementById("cal-status")
            ?.addEventListener("change", (e) => {
                state.status = e.target.value;
                draw();
            });
        // judul bulan + auto-detail tanggal terpilih (default: 16 utk demo Juli 2026)
        const months = ["Januari", "Februari", "Maret", "April", "Mei", "Juni", "Juli", "Agustus", "September", "Oktober", "November", "Desember"];
        const titleEl = document.getElementById("cal-title");
        if (titleEl) titleEl.textContent = `${months[state.month]} ${state.year}`;
        if (!state.selected) state.selected = state.year === 2026 && state.month === 6 ? 16 : new Date().getDate();
        document.querySelector(`[data-day="${state.selected}"]`)?.click();
        document.querySelectorAll("[data-day]").forEach((c) => {
            c.addEventListener("click", () => {
                state.selected = c.dataset.day;
                // re-render panel detail
                const detail = document.getElementById("cal-detail");
                const iso = `${state.year}-${String(state.month + 1).padStart(2, "0")}-${String(state.selected).padStart(2, "0")}`;
                const rows = bookings.all().filter((b) => b.date === iso);
                const names = [
                    "Minggu",
                    "Senin",
                    "Selasa",
                    "Rabu",
                    "Kamis",
                    "Jumat",
                    "Sabtu",
                ];
                const months = [
                    "Januari",
                    "Februari",
                    "Maret",
                    "April",
                    "Mei",
                    "Juni",
                    "Juli",
                    "Agustus",
                    "September",
                    "Oktober",
                    "November",
                    "Desember",
                ];
                const d = new Date(iso);
                detail.innerHTML = `
          <h3 class="mb-4 text-sm font-bold text-slate-800">${names[d.getDay()]}, ${state.selected} ${months[state.month]} ${state.year}</h3>
          ${
              rows.length === 0
                  ? '<p class="text-sm text-slate-400">Tidak ada acara.</p>'
                  : rows
                        .map(
                            (b) => `
            <div class="mb-2 rounded-xl border border-line bg-white p-3">
              <div class="flex items-center justify-between">
                <span class="text-xs font-bold text-slate-700">${b.code}</span>
                <span class="rounded-full px-2 py-0.5 text-[11px] font-semibold ${b.status === "disetujui" ? "bg-status-disetujui-bg text-status-disetujui" : b.status === "menunggu" ? "bg-status-menunggu-bg text-amber-600" : "bg-status-ditolak-bg text-status-ditolak"}">${b.status.toUpperCase()}</span>
              </div>
              <p class="mt-1 text-sm font-semibold text-slate-700">${b.borrower} â€“ ${b.item}</p>
              <p class="text-xs text-slate-500">${b.start}â€“${b.end} â€¢ ${b.type === "ruangan" ? "Ruangan" : "Alat"} â€¢ ${b.activity}</p>
            </div>`,
                        )
                        .join("")
          }`;
            });
        });
    }
}
export default CalendarController;


