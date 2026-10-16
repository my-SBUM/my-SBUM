// admin/admin-form.js – form tambah/edit administrator (PDF 7)
export function adminForm({ admin }) {
    const v = (k, d = "") => admin?.[k] ?? d;
    return `
  <div class="mb-6">
    <a href="#/admin/kelola-admin" class="text-xs font-semibold text-brand hover:underline">← Kembali ke Daftar Admin</a>
    <h2 class="mt-2 text-2xl font-extrabold text-slate-900">${admin ? "Edit Administrator" : "Tambah Administrator Baru"}</h2>
    <p class="mt-1 text-sm text-slate-500">Lengkapi data administrator di bawah ini.</p>
  </div>
  <form id="form-admin" class="card max-w-2xl p-6">
    <div class="grid gap-4 sm:grid-cols-2">
      <div class="sm:col-span-2">
        <label class="label" for="aname">Nama Lengkap *</label>
        <input id="aname" name="aname" class="input" required value="${v("name")}" placeholder="cth: Dr. Ir. Hendra W.">
      </div>
      <div>
        <label class="label" for="aemail">Email Institusi *</label>
        <input id="aemail" name="aemail" type="email" class="input" required value="${v("email")}" placeholder="nama@polibatam.ac.id">
      </div>
      <div>
        <label class="label" for="anip">NIP *</label>
        <input id="anip" name="anip" class="input" required value="${v("nip")}">
      </div>
      <div>
        <label class="label" for="aphone">Nomor Telepon/WhatsApp *</label>
        <input id="aphone" name="aphone" class="input" required value="${v("phone")}">
      </div>
      <div>
        <label class="label" for="adept">Departemen / Unit Kerja *</label>
        <input id="adept" name="adept" class="input" required value="${v("department")}" placeholder="cth: Koordinator Laboratorium">
      </div>
    </div>
    <label class="mt-5 flex items-center gap-2 text-sm text-slate-600">
      <input id="astatus" name="astatus" type="checkbox" class="rounded" ${admin?.status !== "nonaktif" ? "checked" : ""}>
      Status Akun Aktif
    </label>
    <div class="mt-6 flex justify-end gap-2">
      <a href="#/admin/kelola-admin" class="btn-ghost">Batal</a>
      <button type="submit" class="btn-primary">Simpan Admin</button>
    </div>
  </form>`;
}
