// user/booking-room-form.js – wizard pengajuan ruangan 3 langkah (PDF 6)
import { Stepper } from "@/views/components/Stepper.js";

export function bookingRoomForm({ rooms, draft }) {
    const room = rooms.find((r) => String(r.id) === String(draft.roomId));
    const steps = ["Cek Jadwal", "Isi Form", "Konfirmasi"];

    // ---- Langkah 1 ----
    const step1 = `
  <div class="card p-6">
    <h3 class="mb-1 text-base font-bold text-slate-800">Cek Ketersediaan Jadwal</h3>
    <p class="mb-5 text-sm text-slate-500">Pilih ruangan, tanggal, dan waktu peminjaman.</p>
    <div class="grid gap-4 sm:grid-cols-2">
      <div class="sm:col-span-2">
        <label class="label" for="w-room">Ruangan</label>
        <select id="w-room" class="input">${rooms.map((r) => `<option value="${r.id}" ${String(r.id) === String(draft.roomId) ? "selected" : ""}>${r.name} — ${r.building}</option>`).join("")}</select>
      </div>
      <div><label class="label" for="w-date">Tanggal</label><input id="w-date" type="date" class="input" value="${draft.date}"></div>
      <div class="grid grid-cols-2 gap-3">
        <div><label class="label" for="w-start">Jam Mulai</label><input id="w-start" type="time" class="input" value="${draft.start}"></div>
        <div><label class="label" for="w-end">Jam Selesai</label><input id="w-end" type="time" class="input" value="${draft.end}"></div>
      </div>
    </div>
    <button id="btn-check" class="btn-ghost mt-5">Tampilkan Jadwal Tersedia</button>
    ${
        draft.available === true
            ? `
      <div class="mt-5 rounded-xl bg-brand-soft p-4">
        <div class="flex items-center justify-between">
          <p class="text-sm font-bold text-brand">Waktu tersedia</p>
          <span class="rounded-full bg-brand px-2.5 py-0.5 text-[11px] font-bold text-white">TERSEDIA</span>
        </div>
        <p class="mt-2 text-sm text-slate-600">Ruangan: ${room?.name || "-"} • Tanggal: ${draft.date} • Waktu: ${draft.start}–${draft.end}</p>
      </div>`
            : draft.available === false
              ? `
      <div class="mt-5 rounded-xl bg-status-ditolak-bg p-4 text-sm text-status-ditolak font-semibold">
        Waktu bentrok dengan peminjaman lain. Silakan pilih jadwal berbeda.
      </div>`
              : ""
    }
    <div class="mt-6 flex justify-between">
      <button id="btn-back-1" class="btn-ghost" onclick="location.hash='#/ruangan'">Batal</button>
      <button id="btn-to-form" class="btn-primary" ${draft.available !== true ? "disabled" : ""}>Lanjutkan ke Isi Form →</button>
    </div>
  </div>`;

    // ---- Langkah 2 ----
    const step2 = `
  <div class="card p-6">
    <div class="mb-5 rounded-xl bg-brand-soft p-4 text-sm text-slate-700">
      <span class="font-bold text-brand">Ruangan terpilih:</span> ${room?.name || "-"} • ${draft.date} • ${draft.start}–${draft.end}
    </div>
    <form id="form-step2">
      <h4 class="mb-3 text-sm font-bold uppercase tracking-wide text-slate-500">Informasi Peminjam</h4>
      <div class="grid gap-4 sm:grid-cols-2">
        <div><label class="label" for="pname">Nama</label><input id="pname" name="pname" class="input" required value="${draft.name}"></div>
        <div><label class="label" for="pnim">NIM/NIP</label><input id="pnim" name="pnim" class="input" required value="${draft.nim}"></div>
        <div class="sm:col-span-2"><label class="label" for="pemail">Email</label><input id="pemail" name="pemail" type="email" class="input" required value="${draft.email}"></div>
      </div>
      <h4 class="mb-3 mt-6 text-sm font-bold uppercase tracking-wide text-slate-500">Informasi Kegiatan</h4>
      <div class="grid gap-4 sm:grid-cols-2">
        <div><label class="label" for="ppic">Penanggung Jawab</label><input id="ppic" name="ppic" class="input" required value="${draft.pic}"></div>
        <div><label class="label" for="pkind">Jenis Kegiatan</label>
          <select id="pkind" name="pkind" class="input">${["Akademik", "Non-akademik", "Rapat", "Seminar", "Event"].map((k) => `<option ${draft.kind === k ? "selected" : ""}>${k}</option>`).join("")}</select></div>
        <div class="sm:col-span-2"><label class="label" for="pdesc">Deskripsi Kegiatan</label><textarea id="pdesc" name="pdesc" rows="3" class="input">${draft.desc}</textarea></div>
      </div>
      <label class="mt-4 flex items-start gap-2 text-sm text-slate-600">
        <input id="w-agree" type="checkbox" class="mt-1 rounded" ${draft.agree ? "checked" : ""} required>
        Saya menyetujui ketentuan peminjaman ruangan kampus.
      </label>
      <div class="mt-6 flex justify-between">
        <button type="button" id="btn-back-2" class="btn-ghost">Kembali ke Cek Jadwal</button>
        <button type="button" id="btn-to-confirm" class="btn-primary">Lanjutkan ke Konfirmasi →</button>
      </div>
    </form>
  </div>`;

    // ---- Langkah 3 ----
    const step3 = `
  <div class="card p-6">
    <div class="mb-5 rounded-xl bg-brand-soft p-4">
      <p class="text-sm font-bold text-brand">Jadwal berhasil dipilih</p>
      <p class="text-sm text-slate-600">${room?.name || "-"} • ${draft.date} • ${draft.start}–${draft.end}</p>
    </div>
    <h4 class="mb-2 text-sm font-bold uppercase tracking-wide text-slate-500">Ringkasan Peminjaman</h4>
    <div class="mb-5 grid gap-4 rounded-xl border border-line p-4 text-sm sm:grid-cols-2">
      <div><p class="text-slate-400">Nama</p><p class="font-semibold text-slate-700">${draft.name}</p></div>
      <div><p class="text-slate-400">NIM/NIP</p><p class="font-semibold text-slate-700">${draft.nim}</p></div>
      <div><p class="text-slate-400">Email</p><p class="font-semibold text-slate-700">${draft.email}</p></div>
      <div><p class="text-slate-400">Penanggung Jawab</p><p class="font-semibold text-slate-700">${draft.pic}</p></div>
      <div><p class="text-slate-400">Jenis Kegiatan</p><p class="font-semibold text-slate-700">${draft.kind}</p></div>
      <div class="sm:col-span-2"><p class="text-slate-400">Deskripsi</p><p class="font-semibold text-slate-700">${draft.desc || "-"}</p></div>
    </div>
    <label class="flex items-start gap-2 text-sm text-slate-600">
      <input id="w-statement" type="checkbox" class="mt-1 rounded" ${draft.statement ? "checked" : ""}>
      Saya menyatakan data di atas benar dan akan bertanggung jawab atas fasilitas yang dipinjam.
    </label>
    <div class="mt-6 flex justify-between">
      <button type="button" id="btn-back-3" class="btn-ghost">Kembali ke Isi Form</button>
      <button id="btn-submit" class="btn-green">Kirim Pengajuan</button>
    </div>
  </div>`;

    const stepsHtml = [step1, step2, step3];
    return `
  <div class="mb-6">
    <h2 class="text-2xl font-extrabold text-slate-900">Pengajuan Peminjaman Ruangan</h2>
    <p class="mt-1 text-sm text-slate-500">Selesaikan tiga langkah untuk mengajukan peminjaman.</p>
  </div>
  ${Stepper(steps, draft.step)}
  <div class="mt-6">${stepsHtml[draft.step - 1]}</div>`;
}
