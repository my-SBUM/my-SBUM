// StatCard.js – kartu statistik ringkas: StatCard(label, value, suffix, opts)
import { icon } from "./icons.js";

export function StatCard(label, value, suffix = "", opts = {}) {
  const { badge, badgeClass, sub, tone = "text-slate-900", ic = "info" } = opts;
  return `
  <div class="card p-5">
    <div class="flex items-start justify-between gap-3">
      <div>
        <p class="text-sm font-medium text-slate-500">${label}</p>
        <p class="mt-1 text-3xl font-extrabold ${tone}">${value} <span class="text-sm font-semibold text-slate-400">${suffix}</span></p>
        ${sub ? `<p class="mt-1 text-xs font-medium text-slate-500">${sub}</p>` : ""}
      </div>
      <span class="grid h-11 w-11 shrink-0 place-items-center rounded-xl bg-brand-soft text-brand">${icon(ic, "h-6 w-6")}</span>
    </div>
    ${badge ? `<span class="mt-3 inline-block rounded-full px-2.5 py-1 text-[11px] font-bold ${badgeClass || "bg-brand-soft text-brand"}">${badge}</span>` : ""}
  </div>`;
}
