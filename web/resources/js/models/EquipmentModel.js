// EquipmentModel.js – akses & filter data peralatan
import { Model } from "@/core/Model.js";
import { equipments } from "@/models/data/equipments.js";

export class EquipmentModel extends Model {
  constructor() {
    super(equipments);
  }

  search({ q = "", category = "", status = "" } = {}) {
    return this.all().filter((e) => {
      const okQ =
        !q ||
        `${e.name} ${e.code} ${e.category}`
          .toLowerCase()
          .includes(q.toLowerCase());
      const okC = !category || e.category === category;
      const okS = !status || e.status === status;
      return okQ && okC && okS;
    });
  }

  countByStatus(status) {
    return this.all().filter((e) => e.status === status).length;
  }
  get categories() {
    return [...new Set(this.all().map((e) => e.category))];
  }
}
