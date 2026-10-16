// Layouts/PublicLayout.js – navbar landing + footer gelap
import { icon } from "@/views/components/icons.js";

const navLinks = [
  ["#/#fitur", "Fitur"],
  ["#/#layanan", "Ruangan & Peralatan"],
  ["#/#cara-kerja", "Cara Kerja"],
  ["#/#tentang", "Tentang"],
];

function navbar() {
  return `
  <header class="sticky top-0 z-40 border-b border-line bg-white/90 backdrop-blur">
    <div class="mx-auto flex max-w-7xl items-center justify-between px-4 py-3 lg:px-8">
      <a href="#/" class="flex items-center gap-2">
        <span class="grid h-9 w-9 place-items-center rounded-lg bg-brand text-white font-extrabold">S</span>
        <span class="text-lg font-extrabold text-slate-900">mySBUM <span class="text-xs font-semibold text-brand">POLIBATAM</span></span>
      </a>
      <nav class="hidden items-center gap-6 text-sm font-medium text-slate-600 md:flex" aria-label="Navigasi utama">
        ${navLinks.map(([h, l]) => `<a class="hover:text-brand" href="${h}">${l}</a>`).join("")}
      </nav>
      <a href="#/login" class="btn-primary !py-2">Masuk ${icon("arrow-right", "h-4 w-4")}</a>
    </div>
  </header>`;
}

function footer() {
  const col = (title, items) => `
    <div>
      <h3 class="mb-3 text-sm font-bold uppercase tracking-wider text-white/80">${title}</h3>
      <ul class="space-y-2 text-sm text-white/60">
        ${items.map((i) => `<li><a class="hover:text-white" href="${i[0]}">${i[1]}</a></li>`).join("")}
      </ul>
    </div>`;
  return `
  <footer id="tentang" class="bg-brand-deep text-white">
    <div class="mx-auto grid max-w-7xl gap-10 px-4 py-14 md:grid-cols-2 lg:grid-cols-4 lg:px-8">
      <div>
        <div class="mb-3 flex items-center gap-2">
          <span class="grid h-9 w-9 place-items-center rounded-lg bg-brand text-white font-extrabold">S</span>
          <span class="text-lg font-extrabold">mySBUM</span>
        </div>
        <p class="text-sm leading-relaxed text-white/60">
          Sistem peminjaman alat & ruangan Sarana Bersama dan Urusan Mandiri (SBUM)
          Politeknik Negeri Batam. Ajukan, pantau, dan kelola peminjaman dalam satu portal.
        </p>
      </div>
      ${col("Layanan", [
        ["#/", "Peminjaman Ruangan"],
        ["#/", "Peminjaman Peralatan"],
        ["#/", "Kalendar Kegiatan"],
        ["#/", "Portal Persetujuan"],
      ])}
      ${col("Bantuan", [
        ["#/", "Panduan Penggunaan"],
        ["#/", "FAQ"],
        ["#/", "Hubungi Kami"],
        ["#/", "Syarat & Ketentuan"],
      ])}
      ${col("Kampus", [
        ["#/", "Politeknik Negeri Batam"],
        ["#/", "Kampus Utama"],
        ["#/", "Gedung Teaching Factory"],
        ["#/", "Gedung Kuliah Bersama"],
      ])}
    </div>
    <div class="border-t border-white/10">
      <div class="mx-auto flex max-w-7xl flex-col items-center justify-between gap-3 px-4 py-5 text-sm text-white/50 md:flex-row lg:px-8">
        <p>&copy; 2026 Politeknik Negeri Batam. Seluruh hak cipta dilindungi.</p>
        <div class="flex items-center gap-2">
          <span class="sr-only">Pilih bahasa</span>
          <label class="text-white/50" for="lang-sel">Bahasa</label>
          <select id="lang-sel" class="rounded-md border border-white/20 bg-white/10 px-2 py-1 text-xs text-white focus:outline-none">
            <option value="id">Indonesia</option>
            <option value="en">English</option>
          </select>
        </div>
      </div>
    </div>
  </footer>`;
}

/** Layout halaman publik: bungkus konten dengan navbar + footer */
export function PublicLayout(content) {
  return `${navbar()}<main>${content}</main>${footer()}`;
}
