// Stepper.js – indikator 3 langkah wizard: Cek Jadwal -> Isi Form -> Konfirmasi
import { icon } from "./icons.js";

export function Stepper(steps, current) {
  const labels = steps || ["Cek Jadwal", "Isi Form", "Konfirmasi"];
  const dot = (i, label) => {
    const done = i < current,
      active = i === current;
    return `
    <div class="flex flex-1 flex-col items-center gap-2 sm:flex-none sm:flex-row sm:gap-3">
      <span class="grid h-9 w-9 place-items-center rounded-full text-sm font-bold
        ${done ? "bg-brand-light text-white" : active ? "bg-brand text-white" : "bg-slate-200 text-slate-500"}">
        ${done ? icon("check", "h-4 w-4") : i + 1}
      </span>
      <span class="text-xs font-semibold sm:text-sm ${active ? "text-brand" : done ? "text-brand-light" : "text-slate-400"}">${label}</span>
    </div>`;
  };
  const line = (i) =>
    `<div class="hidden h-0.5 flex-1 sm:block ${i < current ? "bg-brand-light" : "bg-slate-200"}"></div>`;
  return `
  <div class="card mb-6 flex items-center gap-3 px-6 py-5 sm:gap-4">
    ${dot(0, labels[0])}${line(1)}${dot(1, labels[1])}${line(2)}${dot(2, labels[2])}
  </div>`;
}
