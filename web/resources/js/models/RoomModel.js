// RoomModel.js – akses & filter data ruangan
import { Model } from "@/core/Model.js";
import { rooms } from "@/models/data/rooms.js";

export class RoomModel extends Model {
  constructor() {
    super(rooms);
  }

  search({ q = "", building = "", floor = "" } = {}) {
    return this.all().filter((r) => {
      const okQ =
        !q ||
        `${r.name} ${r.code} ${r.building}`
          .toLowerCase()
          .includes(q.toLowerCase());
      const okB = !building || r.building === building;
      const okF = !floor || r.floor === floor;
      return okQ && okB && okF;
    });
  }

  countByStatus(status) {
    return this.all().filter((r) => r.status === status).length;
  }
  get buildings() {
    return [...new Set(this.all().map((r) => r.building))];
  }
  get floors() {
    return [...new Set(this.all().map((r) => r.floor))];
  }
}
