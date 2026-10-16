// View.js – helper template: html`` tag sederhana + mount + escape
export function escape(str = "") {
  return String(str)
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}

/** Tag template literal biasa (supaya konsisten dengan pola html``) */
export function html(strings, ...values) {
  return strings.reduce((out, s, i) => out + s + (values[i] ?? ""), "");
}

/** Pasang HTML ke container lalu kembalikan elemen container */
export function mount(container, htmlString) {
  container.innerHTML = htmlString;
  return container;
}
