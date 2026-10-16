// auth/register.js – halaman register dengan validasi klien
export function register() {
    return `
  <div class="card w-full max-w-md p-8">
    <div class="mb-6 text-center">
      <h1 class="text-xl font-extrabold text-slate-900">Daftar Akun Baru</h1>
      <p class="mt-1 text-sm text-slate-500">Gunakan email institusi @polibatam.ac.id</p>
    </div>
    <form id="form-register">
      <div class="mb-4">
        <label class="label" for="r-name">Nama Lengkap</label>
        <input id="r-name" class="input" required minlength="3" placeholder="Nama lengkap">
      </div>
      <div class="mb-4">
        <label class="label" for="r-nim">NIM / NIP</label>
        <input id="r-nim" class="input" required pattern="[0-9]{8,}" placeholder="cth: 3312100001">
      </div>
      <div class="mb-4">
        <label class="label" for="r-email">Email Institusi</label>
        <input id="r-email" type="email" class="input" required pattern="[^@\\s]+@polibatam\\.ac\\.id$" placeholder="nama@polibatam.ac.id">
      </div>
      <div class="mb-4">
        <label class="label" for="r-pass">Password (min. 8 karakter)</label>
        <input id="r-pass" type="password" class="input" required minlength="8">
      </div>
      <div class="mb-4">
        <label class="label" for="r-pass2">Konfirmasi Password</label>
        <input id="r-pass2" type="password" class="input" required minlength="8">
      </div>
      <p id="register-msg" class="field-error mb-2 hidden"></p>
      <button class="btn-primary w-full justify-center">Daftar Akun</button>
    </form>
    <p class="mt-5 text-center text-sm text-slate-500">Sudah punya akun?
      <a href="#/login" class="font-semibold text-brand hover:underline">Login</a>
    </p>
  </div>`;
}
