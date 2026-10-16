// ActivityFeed.js – daftar aktivitas terbaru dengan titik waktu
const TONE = {
    approved: "bg-status-disetujui-bg text-status-disetujui",
    returned: "bg-blue-100 text-blue-600",
    new: "bg-status-menunggu-bg text-amber-600",
    issue: "bg-status-ditolak-bg text-status-ditolak",
    cancelled: "bg-slate-100 text-slate-500",
};

export function ActivityFeed(items) {
    return `
  <ul class="space-y-4">
    ${items
        .map(
            (a) => `
      <li class="flex gap-3">
        <span class="grid h-8 w-8 shrink-0 place-items-center rounded-full text-xs font-bold ${TONE[a.kind] || TONE.cancelled}">${a.time.split(":")[0]}</span>
        <div class="min-w-0">
          <p class="text-sm font-semibold text-slate-700">${a.title}</p>
          <p class="truncate text-xs text-slate-400">${a.detail}</p>
          <p class="text-[11px] text-slate-300">${a.time}</p>
        </div>
      </li>`,
        )
        .join("")}
  </ul>`;
}
