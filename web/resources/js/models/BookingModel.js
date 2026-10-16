// BookingModel.js – peminjaman ruangan & alat: status, PIC, jadwal, cek bentrok
import { Model } from "@/core/Model.js";
import { bookings as seed } from "@/models/data/bookings.js";

export class BookingModel extends Model {
  constructor() {
    super(seed, "bookings");
  }

  byType(type) {
    return this.all().filter((b) => b.type === type);
  }

  countByStatus(status) {
    return this.all().filter((b) => b.status === status).length;
  }

  /** Cek bentrok jadwal utk item & tanggal tertentu (status aktif saja) */
  isConflict({ type, itemId, date, start, end }) {
    return this.all().some(
      (b) =>
        b.type === type &&
        String(b.itemId) === String(itemId) &&
        b.date === date &&
        ["menunggu", "disetujui"].includes(b.status) &&
        start < b.end &&
        end > b.start,
    );
  }

  /** Kode booking berikutnya utk tipe */
  nextCode(type) {
    const prefix = type === "alat" ? "ALT" : "RNG";
    const n = this.all().filter((b) => b.type === type).length + 1;
    return `${prefix}-${String(n).padStart(3, "0")}`;
  }

  /** Statistik sesuai PDF: menunggu, ruangan terjadwal, alat terjadwal */
  stats() {
    const rows = this.all();
    const active = ["menunggu", "disetujui"];
    return {
      menunggu: rows.filter((b) => b.status === "menunggu").length,
      ruanganAktif: rows.filter(
        (b) => b.type === "ruangan" && active.includes(b.status),
      ).length,
      alatAktif: rows.filter(
        (b) => b.type === "alat" && active.includes(b.status),
      ).length,
      disetujui: rows.filter((b) => b.status === "disetujui").length,
      ditolak: rows.filter((b) => b.status === "ditolak").length,
      totalAktif: rows.filter((b) => active.includes(b.status)).length,
    };
  }
}
