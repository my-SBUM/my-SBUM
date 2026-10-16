﻿// RoomBookingController.js â€“ katalog ruangan + wizard pengajuan (3 langkah)
import { Controller } from "@/core/Controller.js";
import { DashboardLayout } from "@/views/layouts/DashboardLayout.js";
import { roomList } from "@/views/pages/user/room-list.js";
import { bookingRoomForm } from "@/views/pages/user/booking-room-form.js";
import { RoomModel } from "@/models/RoomModel.js";
import { BookingModel } from "@/models/BookingModel.js";
import { Pagination } from "@/views/components/Pagination.js";
import { Router } from "@/core/Router.js";

const PER_PAGE = 6;

export class RoomBookingController extends Controller {
    /** Katalog ruangan: search + filter + pagination (data dari API PHP) */
    async index() {
        const rooms = new RoomModel();
        await rooms.load();
        const state = { q: "", building: "", floor: "", page: 1 };

        const draw = () => {
            const all = rooms.search(state);
            const pages = Math.max(1, Math.ceil(all.length / PER_PAGE));
            state.page = Math.min(state.page, pages);
            const slice = all.slice(
                (state.page - 1) * PER_PAGE,
                state.page * PER_PAGE,
            );
            const data = {
                title: "Peminjaman Ruangan",
                crumbs: [
                    { label: "Dashboard", href: "#/dashboard" },
                    { label: "Peminjaman Ruangan" },
                ],
                routePath: "/ruangan",
                rooms: slice,
                pagination: Pagination(state.page, pages, (p) => {
                    state.page = p;
                    draw();
                }),
                info: `Menampilkan ${slice.length} dari ${rooms.all().length} ruangan total di Kampus Utama Politeknik Negeri Batam`,
                buildings: rooms.buildings,
                floors: rooms.floors,
                state,
            };
            this.setLayout(DashboardLayout);
            this.render(roomList(data), data);
            this.bind(state, draw);
        };

        draw();
    }

    bind(state, draw) {
        document
            .getElementById("room-search")
            ?.addEventListener("input", (e) => {
                state.q = e.target.value;
                state.page = 1;
                draw();
            });
        ["filter-building", "filter-floor"].forEach((id) => {
            document.getElementById(id)?.addEventListener("change", (e) => {
                state.building =
                    document.getElementById("filter-building").value;
                state.floor = document.getElementById("filter-floor").value;
                state.page = 1;
                draw();
            });
        });
        document.querySelectorAll("[data-room]").forEach((btn) => {
            btn.addEventListener("click", () => {
                Router.navigate(`/ruangan/ajukan?id=${btn.dataset.room}`);
            });
        });
    }

    /** Wizard pengajuan ruangan (draft state di controller, bukan DOM) */
    async create() {
        const rooms = new RoomModel();
        const bookings = new BookingModel();
        await Promise.all([rooms.load(), bookings.load()]);
        const draft = {
            step: 1,
            roomId: this.routeParams?.id || null,
            date: "",
            start: "",
            end: "",
            available: null,
            name: "",
            nim: "",
            email: "",
            pic: "",
            kind: "Akademik",
            desc: "",
            agree: false,
            statement: false,
        };

        const data = {
            title: "Pengajuan Peminjaman Ruangan",
            crumbs: [
                { label: "Dashboard", href: "#/dashboard" },
                { label: "Peminjaman Ruangan", href: "#/ruangan" },
                { label: "Ajukan" },
            ],
            routePath: "/ruangan/ajukan",
            rooms: rooms.all(),
            draft,
        };

        const draw = () => {
            this.setLayout(DashboardLayout);
            this.render(
                bookingRoomForm({ ...data, draft: { ...draft } }),
                data,
            );
            this.bindWizard(draft, draw, bookings);
        };
        draw();
    }

    bindWizard(draft, draw, bookings) {
        const $ = (id) => document.getElementById(id);
        const toast = (m) => alert(m);

        $("btn-check")?.addEventListener("click", () => {
            draft.roomId = $("w-room").value;
            draft.date = $("w-date").value;
            draft.start = $("w-start").value;
            draft.end = $("w-end").value;
            if (!draft.roomId || !draft.date || !draft.start || !draft.end)
                return toast("Lengkapi jadwal terlebih dahulu.");
            if (draft.start >= draft.end)
                return toast("Jam selesai harus setelah jam mulai.");
            draft.available = !bookings.isConflict({
                type: "ruangan",
                itemId: draft.roomId,
                date: draft.date,
                start: draft.start,
                end: draft.end,
            });
            draw();
        });

        $("btn-to-form")?.addEventListener("click", () => {
            draft.step = 2;
            draw();
        });
        $("btn-back-1")?.addEventListener("click", () => {
            draft.step = 1;
            draw();
        });

        $("btn-to-confirm")?.addEventListener("click", () => {
            const f = $("form-step2");
            if (!f.reportValidity()) return;
            draft.agree = $("w-agree").checked;
            if (!draft.agree)
                return toast("Centang persetujuan ketentuan terlebih dahulu.");
            draft.name = f.pname.value;
            draft.nim = f.pnim.value;
            draft.email = f.pemail.value;
            draft.pic = f.ppic.value;
            draft.kind = f.pkind.value;
            draft.desc = f.pdesc.value;
            draft.step = 3;
            draw();
        });
        $("btn-back-2")?.addEventListener("click", () => {
            draft.step = 2;
            draw();
        });
        $("w-statement")?.addEventListener("change", (e) => {
            draft.statement = e.target.checked;
        });

        $("btn-submit")?.addEventListener("click", () => {
            if (!draft.statement)
                return toast("Centang pernyataan kebenaran terlebih dahulu.");
            bookings.save({
                code: bookings.nextCode("ruangan"),
                type: "ruangan",
                item: new RoomModel().find(draft.roomId)?.name || "",
                itemId: draft.roomId,
                borrower: draft.name,
                role: "Mahasiswa",
                email: draft.email,
                pic: draft.pic,
                phone: "-",
                activity: draft.desc || draft.kind,
                kind: draft.kind,
                date: draft.date,
                start: draft.start,
                end: draft.end,
                status: "menunggu",
                createdAt: new Date().toISOString(),
            });
            Modal_show(
                `Pengajuan ruangan <b>${draft.code || ""}</b> berhasil dikirim dan sedang menunggu persetujuan.`,
            );
            document
                .getElementById("modal-ok")
                ?.addEventListener("click", () => Router.navigate("/riwayat"));
        });
    }
}
export default RoomBookingController;

// helper: tampilkan modal sederhana (di sini demi kesederhanaan, dibuat inline)
function Modal_show(html) {
    const wrap = document.createElement("div");
    wrap.className =
        "fixed inset-0 z-50 grid place-items-center bg-black/50 p-4";
    wrap.innerHTML = `<div class="card max-w-sm w-full p-6 text-center">
    <div class="mx-auto mb-3 grid h-12 w-12 place-items-center rounded-full bg-brand-soft text-brand-light text-2xl">âœ“</div>
    <h3 class="mb-2 text-lg font-bold text-slate-800">Pengajuan Terkirim</h3>
    <p class="mb-5 text-sm text-slate-500">${html}</p>
    <button id="modal-ok" class="btn-primary w-full justify-center">Lihat Riwayat</button>
  </div>`;
    document.body.appendChild(wrap);
}


