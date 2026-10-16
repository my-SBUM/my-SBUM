﻿ // EquipmentBookingController.js â€“ katalog alat + wizard pengajuan alat
import { Controller } from '@/core/Controller.js';
import { DashboardLayout } from '@/views/layouts/DashboardLayout.js';
import { equipmentList } from '@/views/pages/user/equipment-list.js';
import { bookingEquipmentForm } from '@/views/pages/user/booking-equipment-form.js';
import { EquipmentModel } from '@/models/EquipmentModel.js';
import { BookingModel } from '@/models/BookingModel.js';
import { Pagination } from '@/views/components/Pagination.js';
import { Router } from '@/core/Router.js';

const PER_PAGE = 6;

export class EquipmentBookingController extends Controller {
  async index() {
    const equips = new EquipmentModel();
    const state = { q: '', category: '', status: '', page: 1 };

    const draw = () => {
      const all = equips.search(state);
      const pages = Math.max(1, Math.ceil(all.length / PER_PAGE));
      state.page = Math.min(state.page, pages);
      const slice = all.slice((state.page - 1) * PER_PAGE, state.page * PER_PAGE);
      const data = {
        title: 'Peminjaman Peralatan',
        crumbs: [{ label: 'Dashboard', href: '#/dashboard' }, { label: 'Peminjaman Peralatan' }],
        routePath: '/alat',
        equips: slice,
        pagination: Pagination(state.page, pages, (p) => { state.page = p; draw(); }),
        info: `Menampilkan ${slice.length} dari ${equips.all().length} peralatan terdaftar`,
        categories: equips.categories,
        state,
      };
      this.setLayout(DashboardLayout);
      this.render(equipmentList(data), data);
      this.bind(state, draw);
    };
    draw();
  }

  bind(state, draw) {
    document.getElementById('equip-search')?.addEventListener('input', (e) => {
      state.q = e.target.value; state.page = 1; draw();
    });
    document.getElementById('filter-category')?.addEventListener('change', (e) => {
      state.category = e.target.value; state.page = 1; draw();
    });
    document.getElementById('filter-status')?.addEventListener('change', (e) => {
      state.status = e.target.value; state.page = 1; draw();
    });
    document.querySelectorAll('[data-equip]').forEach((btn) => {
      btn.addEventListener('click', () => Router.navigate(`/alat/ajukan?id=${btn.dataset.equip}`));
    });
  }

  /** Wizard pengajuan alat (draft state di controller) */
  async create() {
    const equips = new EquipmentModel();
    const bookings = new BookingModel();
    await Promise.all([equips.load(), bookings.load()]);
    const draft = {
      step: 1, equipId: this.routeParams?.id || null,
      date: '', start: '', end: '', available: null,
      name: '', nim: '', email: '', qty: 1, pic: '', kind: 'Akademik', desc: '', agree: false, statement: false,
    };

    const data = {
      title: 'Pengajuan Peminjaman Peralatan',
      crumbs: [{ label: 'Dashboard', href: '#/dashboard' }, { label: 'Peminjaman Peralatan', href: '#/alat' }, { label: 'Ajukan' }],
      routePath: '/alat/ajukan',
      equips: equips.all(),
      draft,
    };

    const draw = () => {
      this.setLayout(DashboardLayout);
      this.render(bookingEquipmentForm({ ...data, draft: { ...draft } }), data);
      this.bindWizard(draft, draw, bookings);
    };
    draw();
  }

  bindWizard(draft, draw, bookings) {
    const $ = (id) => document.getElementById(id);
    const toast = (m) => alert(m);

    $('btn-check')?.addEventListener('click', () => {
      draft.equipId = $('w-equip').value; draft.date = $('w-date').value;
      draft.start = $('w-start').value; draft.end = $('w-end').value;
      if (!draft.equipId || !draft.date || !draft.start || !draft.end) return toast('Lengkapi jadwal terlebih dahulu.');
      if (draft.start >= draft.end) return toast('Jam selesai harus setelah jam mulai.');
      draft.available = !bookings.isConflict({ type: 'alat', itemId: draft.equipId, date: draft.date, start: draft.start, end: draft.end });
      draw();
    });

    $('btn-to-form')?.addEventListener('click', () => { draft.step = 2; draw(); });
    $('btn-back-1')?.addEventListener('click', () => { draft.step = 1; draw(); });

    $('btn-to-confirm')?.addEventListener('click', () => {
      const f = $('form-step2');
      if (!f.reportValidity()) return;
      draft.agree = $('w-agree').checked;
      if (!draft.agree) return toast('Centang persetujuan ketentuan terlebih dahulu.');
      draft.name = f.pname.value; draft.nim = f.pnim.value; draft.email = f.pemail.value;
      draft.qty = Number(f.pqty.value || 1);
      draft.pic = f.ppic.value; draft.kind = f.pkind.value; draft.desc = f.pdesc.value;
      draft.step = 3; draw();
    });
    $('btn-back-2')?.addEventListener('click', () => { draft.step = 2; draw(); });
    $('w-statement')?.addEventListener('change', (e) => { draft.statement = e.target.checked; });

    $('btn-submit')?.addEventListener('click', () => {
      if (!draft.statement) return toast('Centang pernyataan kebenaran terlebih dahulu.');
      bookings.save({
        code: bookings.nextCode('alat'), type: 'alat', item: new EquipmentModel().find(draft.equipId)?.name || '',
        itemId: draft.equipId, borrower: draft.name, role: 'Mahasiswa', email: draft.email, qty: draft.qty,
        pic: draft.pic, phone: '-', activity: draft.desc || draft.kind, kind: draft.kind,
        date: draft.date, start: draft.start, end: draft.end, status: 'menunggu', createdAt: new Date().toISOString(),
      });
      Modal_show('Pengajuan peralatan berhasil dikirim dan sedang menunggu persetujuan.');
      document.getElementById('modal-ok')?.addEventListener('click', () => Router.navigate('/riwayat'));
    });
  }
}
export default EquipmentBookingController;

function Modal_show(html) {
  const wrap = document.createElement('div');
  wrap.className = 'fixed inset-0 z-50 grid place-items-center bg-black/50 p-4';
  wrap.innerHTML = `<div class="card max-w-sm w-full p-6 text-center">
    <div class="mx-auto mb-3 grid h-12 w-12 place-items-center rounded-full bg-brand-soft text-brand-light text-2xl">âœ“</div>
    <h3 class="mb-2 text-lg font-bold text-slate-800">Pengajuan Terkirim</h3>
    <p class="mb-5 text-sm text-slate-500">${html}</p>
    <button id="modal-ok" class="btn-primary w-full justify-center">Lihat Riwayat</button>
  </div>`;
  document.body.appendChild(wrap);
}


