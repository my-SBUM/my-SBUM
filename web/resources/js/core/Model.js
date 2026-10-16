// Model.js – base class: akses data (API PHP Laravel dulu, fallback mock lokal)
import { Store } from './Store.js';

/** Ambil koleksi dari API PHP (routes/api.php), fallback ke seed lokal bila gagal */
export async function fetchCollection(name, fallback) {
  try {
    const res = await fetch(`/api/${name}`, { headers: { Accept: 'application/json' } });
    if (res.ok) {
      const rows = await res.json();
      if (Array.isArray(rows) && rows.length) return rows;
    }
  } catch (e) {
    // API PHP tidak jalan (mis. hanya vite dev murni) -> pakai mock
  }
  const saved = Store.get(name);
  return saved && saved.length ? saved : fallback;
}

export class Model {
  constructor(rows, key) {
    this.rows = rows;
    this.key = key; // nama koleksi di Store (localStorage), opsional
    this._loaded = null; // promise agar load() idempotent
  }

  /** Muat data dari API PHP (fallback mock). Harus dipanggil sebelum all() di alur async */
  async load() {
    if (!this._loaded) {
      const rows = await fetchCollection(this.key || this.collectionName(), this.rows);
      this.rows = rows;
      this._loaded = rows;
    }
    return this;
  }

  collectionName() {
    return this.constructor.name.replace(/Model$/, '').toLowerCase();
  }

  /** Semua data (sinkron setelah load()) */
  all() {
    if (this.key) {
      const saved = Store.get(this.key);
      if (saved && saved.length) this.rows = saved;
    }
    return this.rows;
  }

  /** Cari satu berdasarkan id */
  find(id) {
    return this.all().find((r) => String(r.id) === String(id)) || null;
  }

  /** Filter dengan predicate */
  filter(fn) {
    return this.all().filter(fn);
  }

  /** Kirim perubahan ke API PHP (best-effort), lalu persist lokal */
  async syncToApi(method, path, body) {
    try {
      await fetch(path, {
        method,
        headers: { 'Content-Type': 'application/json', Accept: 'application/json' },
        body: JSON.stringify(body),
      });
    } catch (e) {
      // API PHP tidak jalan -> tetap simpan lokal
    }
  }

  /** Tambah / update data (kirim ke API PHP bila ada, lalu persist ke Store) */
  save(row) {
    const rows = this.all();
    const idx = rows.findIndex((r) => String(r.id) === String(row.id));
    if (idx >= 0) rows[idx] = { ...rows[idx], ...row };
    else
      rows.push({
        id: rows.length ? Math.max(...rows.map((r) => Number(r.id))) + 1 : 1,
        ...row,
      });
    this.persist(rows);
    // kirim ke API PHP tanpa menunggu (fire-and-forget)
    const apiPath = this.apiPath();
    if (apiPath) {
      if (idx >= 0) this.syncToApi('POST', `${apiPath}/${row.id}`, row);
      else this.syncToApi('POST', apiPath, row);
    }
    return row;
  }

  apiPath() {
    switch (this.collectionName()) {
      case 'booking': return '/api/bookings';
      case 'admin': return '/api/admins';
      case 'room': return '/api/rooms';
      case 'equipment': return '/api/equipments';
      default: return null;
    }
  }

  remove(id) {
    const rows = this.all().filter((r) => String(r.id) !== String(id));
    this.rows = rows;
    this.persist(rows);
  }

  persist(rows) {
    if (this.key) Store.set(this.key, rows);
    this.rows = rows;
  }
}
