 // Modal.js – modal generik sederhana (overlay + kartu konten)
export function Modal(contentHtml) {
  const wrap = document.createElement('div');
  wrap.className = 'fixed inset-0 z-50 grid place-items-center bg-black/50 p-4';
  wrap.innerHTML = `<div class="card w-full max-w-lg p-6">${contentHtml}</div>`;
  wrap.addEventListener('click', (e) => { if (e.target === wrap) wrap.remove(); });
  document.body.appendChild(wrap);
  return wrap;
}
