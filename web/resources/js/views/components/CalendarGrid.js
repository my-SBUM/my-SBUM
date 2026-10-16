// CalendarGrid.js – grid kalender bulanan dengan titik indikator acara per tanggal
const MONTHS = [
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
const DAY_HEADERS = ["Min", "Sen", "Sel", "Rab", "Kam", "Jum", "Sab"];

export function CalendarGrid(bookings, state) {
    const { year, month } = state;
    const first = new Date(year, month, 1).getDay();
    const daysInMonth = new Date(year, month + 1, 0).getDate();
    const today = new Date();

    const cells = [];
    for (let i = 0; i < first; i++) cells.push("<div></div>");
    for (let d = 1; d <= daysInMonth; d++) {
        const iso = `${year}-${String(month + 1).padStart(2, "0")}-${String(d).padStart(2, "0")}`;
        const events = bookings.filter(
            (b) =>
                b.date === iso &&
                (!state.type || b.type === state.type) &&
                (!state.status || b.status === state.status),
        );
        const isToday =
            d === today.getDate() &&
            month === today.getMonth() &&
            year === today.getFullYear();
        const highlight = d === 16 && MONTHS[month] === "Juli" && year === 2026;
        cells.push(`
      <button data-day="${d}" class="relative flex aspect-square flex-col items-center justify-center rounded-lg text-sm transition
        ${highlight || isToday ? "bg-brand text-white font-bold" : "hover:bg-slate-100 text-slate-700"}">
        ${d}
        ${
            events.length
                ? `
          <span class="absolute bottom-1 flex items-center gap-0.5">
            ${events
                .slice(0, 3)
                .map(
                    (e) =>
                        `<span class="h-1.5 w-1.5 rounded-full ${e.status === "disetujui" ? "bg-status-disetujui" : e.status === "menunggu" ? "bg-amber-400" : "bg-red-400"} ${highlight || isToday ? "ring-1 ring-white/50" : ""}"></span>`,
                )
                .join("")}
            ${events.length > 3 ? `<span class="text-[9px] ${highlight || isToday ? "text-white/80" : "text-slate-400"}">+${events.length - 3}</span>` : ""}
          </span>`
                : ""
        }
      </button>`);
    }

    // judul bulan dipasang oleh controller lewat #cal-title? di sini inline:
    return `
  <div class="grid grid-cols-7 gap-1 text-center text-[11px] font-bold uppercase text-slate-400">
    ${DAY_HEADERS.map((d) => `<div class="py-1">${d}</div>`).join("")}
  </div>
  <div class="grid grid-cols-7 gap-1">${cells.join("")}</div>`;
}
