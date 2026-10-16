// ManageEquipmentController.js â€“ kelola peralatan: stat, search kode aset, edit modal
import { Controller } from "@/core/Controller.js";
import { DashboardLayout } from "@/views/layouts/DashboardLayout.js";
import { manageEquipments } from "@/views/pages/admin/equipments.js";
import { EquipmentModel } from "@/models/EquipmentModel.js";

export class ManageEquipmentController extends Controller {
    async index() {
        const equips = new EquipmentModel();
        const state = { q: "", category: "", condition: "" };

        const draw = () => {
            const rows = equips
                .search({ q: state.q, category: state.category })
                .filter(
                    (e) => !state.condition || e.status === state.condition,
                );
            const data = {
                title: "Kelola Peralatan",
                crumbs: [
                    { label: "Dashboard", href: "#/dashboard" },
                    { label: "Kelola Peralatan" },
                ],
                routePath: "/kelola-peralatan",
                stats: { ready: 142, borrowed: 36, maintenance: 6 }, // angka sesuai PDF
                rows,
                state,
                categories: equips.categories,
            };
            this.setLayout(DashboardLayout);
            this.render(manageEquipments(data), data);
            this.bind(state, draw, equips);
        };
        draw();
    }

    bind(state, draw, equips) {
        document.getElementById("e-search")?.addEventListener("input", (e) => {
            state.q = e.target.value;
            draw();
        });
        document
            .getElementById("e-category")
            ?.addEventListener("change", (e) => {
                state.category = e.target.value;
                draw();
            });
        document
            .getElementById("e-condition")
            ?.addEventListener("change", (e) => {
                state.condition = e.target.value;
                draw();
            });
        document.getElementById("e-reset")?.addEventListener("click", () => {
            state.q = "";
            state.category = "";
            state.condition = "";
            draw();
        });
        document.querySelectorAll("[data-edit]").forEach((b) => {
            b.addEventListener("click", () => {
                const eq = equips.find(b.dataset.edit);
                const wrap = document.createElement("div");
                wrap.className =
                    "fixed inset-0 z-50 grid place-items-center bg-black/50 p-4 overflow-auto";
                wrap.innerHTML = `<div class="card w-full max-w-lg p-6">
          <h3 class="mb-4 text-lg font-bold">Edit Peralatan â€” ${eq.code}</h3>
          <form id="ef">
            <label class="label" for="ef-name">Nama Peralatan</label>
            <input id="ef-name" class="input mb-3" value="${eq.name}" required>
            <div class="grid grid-cols-2 gap-3 mb-3">
              <div><label class="label" for="ef-stock">Stok</label><input id="ef-stock" type="number" class="input" value="${eq.stock}"></div>
              <div><label class="label" for="ef-status">Status</label>
                <select id="ef-status" class="input">
                  <option value="tersedia" ${eq.status === "tersedia" ? "selected" : ""}>Tersedia</option>
                  <option value="tidak-tersedia" ${eq.status !== "tersedia" ? "selected" : ""}>Tidak Tersedia</option>
                </select></div>
            </div>
            <label class="label" for="ef-loc">Lokasi</label><input id="ef-loc" class="input mb-5" value="${eq.location}">
            <div class="flex justify-end gap-2">
              <button type="button" id="ef-cancel" class="btn-ghost">Batal</button>
              <button type="submit" class="btn-primary">Simpan Peralatan</button>
            </div>
          </form></div>`;
                document.body.appendChild(wrap);
                wrap.querySelector("#ef-cancel").onclick = () => wrap.remove();
                wrap.querySelector("#ef").onsubmit = (e) => {
                    e.preventDefault();
                    equips.save({
                        id: eq.id,
                        name: wrap.querySelector("#ef-name").value,
                        stock: Number(wrap.querySelector("#ef-stock").value),
                        status: wrap.querySelector("#ef-status").value,
                        location: wrap.querySelector("#ef-loc").value,
                    });
                    wrap.remove();
                    draw();
                };
            });
        });
    }
}
export default ManageEquipmentController;


