// ActivityModel.js – log aktivitas terbaru
import { Model } from "@/core/Model.js";
import { activities } from "@/models/data/activities.js";

export class ActivityModel extends Model {
  constructor() {
    super(activities);
  }

  latest(n = 3) {
    return this.all().slice(0, n);
  }
}
