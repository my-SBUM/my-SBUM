// Controller.js – base class: render(view, data) & setLayout()
import { mount } from "@/core/View.js";

export class Controller {
  constructor() {
    this.layout = null;
  }

  /** Tentukan layout (komponen yang menerima html konten) */
  setLayout(layoutFn) {
    this.layout = layoutFn;
  }

  /** Render konten (opsional dibungkus layout) ke #app */
  render(contentHtml, data = {}) {
    const app = document.getElementById("app");
    const finalHtml = this.layout
      ? this.layout(contentHtml, data)
      : contentHtml;
    mount(app, finalHtml);
  }

  /** Ambil query hash: #/path?x=1 -> {x:1} */
  query() {
    const q = location.hash.split("?")[1] || "";
    return Object.fromEntries(new URLSearchParams(q));
  }
}
