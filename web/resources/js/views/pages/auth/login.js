// auth/login.js – halaman login (PDF 4) dengan akun demo
import { icon } from "@/views/components/icons.js";

export function login() {
    return `
  <div class="card w-full max-w-md p-8">
    <div class="mb-6 text-center">
      <div class="mx-auto mb-3 grid h-12 w-12 place-items-center rounded-full bg-brand-soft text-brand">${icon("lock", "h-6 w-6")}</div>
      <h1 class="text-xl font-extrabold text-slate-900">Masuk ke mySBUM</h1>
      <p class="mt-1 text-sm text-slate-500">Sistem Peminjaman Alat & Ruangan Politeknik Negeri Batam</p>
    </div>
    <form id="form-login" novalidate>
      <div class="mb-4">
        <label class="label" for="username">NIM / NIP / Email Institusi</label>
        <input id="username" name="username" class="input" placeholder="cth: 3312100001 atau nama@polibatam.ac.id" required>
      </div>
      <div class="mb-2">
        <label class="label" for="password">Password</label>
        <div class="relative">
          <input id="password" name="password" type="password" class="input pr-10" placeholder="Password" required>
          <button type="button" id="toggle-pass" class="absolute right-3 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600" aria-label="Tampilkan password">${icon("eye", "h-5 w-5")}</button>
        </div>
        <div class="mt-1.5 flex items-center justify-between text-xs">
          <label class="flex items-center gap-2 text-slate-600"><input type="checkbox" checked class="rounded"> Ingat saya</label>
          <a href="#" class="font-semibold text-brand hover:underline">Lupa sandi?</a>
        </div>
      </div>
      <p id="login-error" class="field-error mb-2 hidden"></p>
      <button class="btn-primary mt-2 w-full justify-center">Masuk ${icon("arrow-right", "h-4 w-4")}</button>
    </form>
    <div class="mt-5 rounded-xl bg-brand-soft p-4 text-xs text-slate-600">
      <p class="mb-2 font-bold text-brand">Portal Resmi — Akun demo:</p>
      <div class="flex flex-col gap-1.5">
        <button data-demo="hendra@polibatam.ac.id" class="rounded-lg bg-white px-3 py-1.5 text-left font-medium hover:ring-1 hover:ring-brand">
          Koordinator Lab: hendra@polibatam.ac.id
        </button>
        <button data-demo="admin@polibatam.ac.id" class="rounded-lg bg-white px-3 py-1.5 text-left font-medium hover:ring-1 hover:ring-brand">
          Admin SBUM: admin@polibatam.ac.id
        </button>
        <p class="text-[11px] text-slate-400">Password demo: demo123</p>
      </div>
    </div>
    <p class="mt-5 text-center text-sm text-slate-500">Belum punya akun?
      <a href="#/register" class="font-semibold text-brand hover:underline">Daftar Akun Baru</a>
    </p>
  </div>`;
}
