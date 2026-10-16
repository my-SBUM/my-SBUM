// public/landing.js – halaman landing (PDF 3)
import { icon } from "@/views/components/icons.js";

export function landing() {
    const feature = (t, d, ic) => `
    <div class="card p-6">
      <div class="mb-4 grid h-11 w-11 place-items-center rounded-xl bg-brand-soft text-brand">${icon(ic)}</div>
      <h3 class="mb-1.5 text-base font-bold text-slate-800">${t}</h3>
      <p class="text-sm leading-relaxed text-slate-500">${d}</p>
    </div>`;

    const step = (n, t, d) => `
    <div class="relative rounded-2xl border border-line bg-white p-6">
      <span class="mb-4 grid h-10 w-10 place-items-center rounded-full bg-brand text-sm font-extrabold text-white">${n}</span>
      <h3 class="mb-1.5 text-base font-bold text-slate-800">${t}</h3>
      <p class="text-sm leading-relaxed text-slate-500">${d}</p>
    </div>`;

    return `
  <!-- HERO -->
  <section class="bg-brand-soft">
    <div class="mx-auto grid max-w-7xl items-center gap-10 px-4 py-14 lg:grid-cols-2 lg:px-8 lg:py-20">
      <div>
        <span class="mb-4 inline-flex items-center gap-2 rounded-full bg-white px-3 py-1 text-xs font-semibold text-brand shadow-sm">
          <span class="h-2 w-2 rounded-full bg-brand-light"></span> Layanan kampus kini lebih praktis
        </span>
        <h1 class="mb-4 text-4xl font-extrabold leading-tight text-slate-900 lg:text-5xl">
          Pinjam ruang dan peralatan kampus, <span class="text-brand-light">tanpa ribet.</span>
        </h1>
        <p class="mb-6 max-w-lg text-base leading-relaxed text-slate-600">
          mySBUM memudahkan mahasiswa dan dosen Politeknik Negeri Batam mengajukan peminjaman
          ruangan dan peralatan kampus — dari cek jadwal sampai persetujuan, semua dalam satu portal.
        </p>
        <div class="flex flex-wrap gap-3">
          <a href="#/login" class="btn-green">Mulai pengajuan ${icon("arrow-right", "h-4 w-4")}</a>
          <a href="#cara-kerja" class="btn-ghost">Lihat cara kerja ${icon("arrow-right", "h-4 w-4")}</a>
        </div>
      </div>
      <div class="relative hidden justify-self-center lg:block" aria-hidden="true">
        <div class="h-72 w-72 rounded-full bg-brand-light/40"></div>
        <div class="card absolute -top-8 left-8 w-72 p-5 shadow-lg">
          <div class="mb-3 grid h-10 w-10 place-items-center rounded-full bg-status-disetujui-bg text-status-disetujui">${icon("check", "h-5 w-5")}</div>
          <p class="text-base font-bold text-slate-800">Disetujui!</p>
          <p class="text-sm text-slate-500">Ruang Kelas A101 siap pakai.</p>
        </div>
        <div class="card absolute -bottom-10 -right-4 w-56 p-4 shadow-lg">
          <p class="text-xs font-semibold text-slate-400">Status Pengajuan</p>
          <p class="text-sm font-bold text-brand">Menunggu Persetujuan</p>
        </div>
      </div>
    </div>
  </section>

  <!-- FITUR -->
  <section id="fitur" class="mx-auto max-w-7xl px-4 py-16 lg:px-8">
    <div class="mb-10 text-center">
      <h2 class="text-3xl font-extrabold text-slate-900">Semua jadi lebih sederhana</h2>
      <p class="mt-2 text-sm text-slate-500">Kelola kegiatan kampus tanpa antre dan tanpa dokumen kertas.</p>
    </div>
    <div class="grid gap-6 md:grid-cols-3">
      ${feature("Jadwal real-time", "Ketersediaan ruangan dan peralatan diperbarui langsung, jadi tidak ada bentrok jadwal.", "clock")}
      ${feature("Pengajuan terarah", "Form pengajuan tiga langkah memastikan data kegiatanmu lengkap dan tepat sasaran.", "file")}
      ${feature("Status selalu jelas", "Pantau status pengajuan (menunggu, disetujui, ditolak) kapan saja dari dashboard.", "check-circle")}
    </div>
  </section>

  <!-- CARA KERJA -->
  <section id="cara-kerja" class="bg-white py-16">
    <div class="mx-auto max-w-7xl px-4 lg:px-8">
      <div class="mb-10 text-center">
        <h2 class="text-3xl font-extrabold text-slate-900">Cara kerja</h2>
        <p class="mt-2 text-sm text-slate-500">Tiga langkah sederhana dari pengajuan sampai persetujuan.</p>
      </div>
      <div class="grid gap-6 md:grid-cols-3">
        ${step(1, "Pilih kebutuhan", "Tentukan ruangan atau peralatan yang ingin dipinjam dari katalog.")}
        ${step(2, "Isi pengajuan", "Lengkapi form kegiatan, waktu, dan penanggung jawab secara daring.")}
        ${step(3, "Pantau persetujuan", "Cek status pengajuan dan notifikasi hasil persetujuan di dashboard.")}
      </div>
    </div>
  </section>

  <!-- STATISTIK GELAP -->
  <section id="layanan" class="bg-brand-deep py-16 text-white">
    <div class="mx-auto grid max-w-7xl grid-cols-2 gap-8 px-4 text-center lg:grid-cols-4 lg:px-8">
      ${[
          ["1.200+", "Pengguna aktif"],
          ["28", "Ruang terdaftar"],
          ["96", "Peralatan siap pinjam"],
          ["4,8/5", "Kepuasan pengguna"],
      ]
          .map(
              ([v, l]) =>
                  `<div><p class="text-4xl font-extrabold">${v}</p><p class="mt-1 text-sm text-white/60">${l}</p></div>`,
          )
          .join("")}
    </div>
  </section>

  <!-- CTA -->
  <section class="mx-auto max-w-7xl px-4 py-16 lg:px-8">
    <div class="card grid items-center gap-6 p-8 lg:grid-cols-2">
      <div>
        <p class="mb-1 text-xs font-bold uppercase tracking-widest text-brand-light">Siap memulai?</p>
        <h2 class="text-2xl font-extrabold text-slate-900 lg:text-3xl">Wujudkan kegiatan kampusmu hari ini.</h2>
      </div>
      <form onsubmit="location.hash='#/login'; return false" class="flex flex-col gap-3 sm:flex-row">
        <label class="sr-only" for="cta-nim">NIM</label>
        <input id="cta-nim" class="input" placeholder="Masukkan NIM / NIP" />
        <button class="btn-green shrink-0 justify-center">Lanjutkan pengajuan ${icon("arrow-right", "h-4 w-4")}</button>
      </form>
    </div>
  </section>`;
}
