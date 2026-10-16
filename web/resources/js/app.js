// app.js - interaksi ringan frontend mySBUM (frontend-only)

// Toggle langkah wizard pengajuan (stepper)
function initWizard() {
    const steps = document.querySelectorAll("[data-step-panel]");
    if (!steps.length) return;
    const show = (n) => {
        steps.forEach((s) => {
            s.classList.toggle("hidden", s.dataset.stepPanel !== String(n));
        });
        document.querySelectorAll("[data-step-dot]").forEach((d) => {
            const n2 = Number(d.dataset.stepDot);
            d.classList.toggle("bg-emerald-700", n2 <= n);
            d.classList.toggle("text-white", n2 <= n);
            d.classList.toggle("bg-slate-200", n2 > n);
            d.classList.toggle("text-slate-500", n2 > n);
        });
    };
    document.querySelectorAll("[data-next]").forEach((b) =>
        b.addEventListener("click", () => show(Math.min(Number(b.dataset.next) + 1, steps.length))));
    document.querySelectorAll("[data-back]").forEach((b) =>
        b.addEventListener("click", () => show(Math.max(Number(b.dataset.back) - 1, 1))));
    show(1);
}

// Tab dashboard PIC: kelola ruangan / kelola peralatan
function initTabs() {
    const btns = document.querySelectorAll("[data-tab]");
    if (!btns.length) return;
    const activate = (key) => {
        btns.forEach((b) => {
            const on = b.dataset.tab === key;
            b.classList.toggle("bg-emerald-700", on);
            b.classList.toggle("text-white", on);
            b.classList.toggle("bg-slate-100", !on);
            b.classList.toggle("text-slate-500", !on);
        });
        document.querySelectorAll("[data-tab-panel]").forEach((p) => {
            p.classList.toggle("hidden", p.dataset.tabPanel !== key);
        });
    };
    btns.forEach((b) => b.addEventListener("click", () => activate(b.dataset.tab)));
    activate(btns[0].dataset.tab);
}

// Modal konfirmasi generik
function initModals() {
    document.querySelectorAll("[data-modal-open]").forEach((btn) => {
        btn.addEventListener("click", () => {
            document.getElementById(btn.dataset.modalOpen)?.classList.remove("hidden");
        });
    });
    document.querySelectorAll("[data-modal-close]").forEach((btn) => {
        btn.addEventListener("click", () => {
            btn.closest(".modal-overlay")?.classList.add("hidden");
        });
    });
}

document.addEventListener("DOMContentLoaded", () => {
    initWizard();
    initTabs();
    initModals();
});
