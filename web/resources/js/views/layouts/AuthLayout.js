// Layouts/AuthLayout.js – kartu tengah + footer kecil untuk login/register
export function AuthLayout(content) {
  return `
  <div class="flex min-h-screen flex-col items-center justify-center bg-surface px-4 py-10">
    ${content}
    <p class="mt-6 text-center text-xs text-slate-400">&copy; 2026 mySBUM &mdash; Politeknik Negeri Batam</p>
  </div>`;
}
