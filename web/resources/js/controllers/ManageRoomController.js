// ManageRoomController.js â€“ kelola ruangan: stat, search, filter, edit modal
import { Controller } from "@/core/Controller.js";
import { DashboardLayout } from "@/views/layouts/DashboardLayout.js";
import { manageRooms } from "@/views/pages/admin/rooms.js";
import { RoomModel } from "@/models/RoomModel.js";

export class ManageRoomController extends Controller {
    async index() {
        const rooms = new RoomModel();
        const state = { q: "", status: "" };

        const draw = () => {
            const rows = rooms
                .search({ q: state.q, building: "", floor: "" })
                .filter((r) => !state.status || r.status === state.status);
            const data = {
                title: "Kelola Ruangan",
                crumbs: [
                    { label: "Dashboard", href: "#/dashboard" },
                    { label: "Kelola Ruangan" },
                ],
                routePath: "/kelola-ruangan",
                stats: {
                    ready: rooms.all().filter((r) => r.status === "tersedia")
                        .length,
                    inUse: 14, // angka sesuai PDF
                    maintenance: rooms.countByStatus("tidak-tersedia"),
                },
                rows,
                state,
            };
            this.setLayout(DashboardLayout);
            this.render(manageRooms(data), data);
            this.bind(state, draw, rooms);
        };
        draw();
    }

    bind(state, draw, rooms) {
        document.getElementById("r-search")?.addEventListener("input", (e) => {
            state.q = e.target.value;
            draw();
        });
        document.getElementById("r-status")?.addEventListener("change", (e) => {
            state.status = e.target.value;
            draw();
        });
        document.querySelectorAll("[data-edit]").forEach((b) => {
            b.addEventListener("click", () => {
                const room = rooms.find(b.dataset.edit);
                const wrap = document.createElement("div");
                wrap.className =
                    "fixed inset-0 z-50 grid place-items-center bg-black/50 p-4 overflow-auto";
                wrap.innerHTML = `<div class="card w-full max-w-lg p-6">
          <h3 class="mb-4 text-lg font-bold">Edit Ruangan â€” ${room.code}</h3>
          <form id="rf">
            <label class="label" for="rf-name">Nama Ruangan</label>
            <input id="rf-name" class="input mb-3" value="${room.name}" required>
            <div class="grid grid-cols-2 gap-3 mb-3">
              <div><label class="label" for="rf-cap">Kapasitas</label><input id="rf-cap" type="number" class="input" value="${room.capacity}"></div>
              <div><label class="label" for="rf-status">Status</label>
                <select id="rf-status" class="input">
                  <option value="tersedia" ${room.status === "tersedia" ? "selected" : ""}>Tersedia</option>
                  <option value="tidak-tersedia" ${room.status !== "tersedia" ? "selected" : ""}>Tidak Tersedia</option>
                </select></div>
            </div>
            <label class="label" for="rf-pic">PIC</label><input id="rf-pic" class="input mb-5" value="${room.pic}">
            <div class="flex justify-end gap-2">
              <button type="button" id="rf-cancel" class="btn-ghost">Batal</button>
              <button type="submit" class="btn-primary">Simpan</button>
            </div>
          </form></div>`;
                document.body.appendChild(wrap);
                wrap.querySelector("#rf-cancel").onclick = () => wrap.remove();
                wrap.querySelector("#rf").onsubmit = (e) => {
                    e.preventDefault();
                    rooms.save({
                        id: room.id,
                        name: wrap.querySelector("#rf-name").value,
                        capacity: Number(wrap.querySelector("#rf-cap").value),
                        status: wrap.querySelector("#rf-status").value,
                        pic: wrap.querySelector("#rf-pic").value,
                    });
                    wrap.remove();
                    draw();
                };
            });
        });
    }
}
export default ManageRoomController;


