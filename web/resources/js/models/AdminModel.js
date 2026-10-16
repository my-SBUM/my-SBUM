// AdminModel.js – CRUD administrator (persist ke localStorage)
import { Model } from "@/core/Model.js";
import { admins } from "@/models/data/admins.js";

export class AdminModel extends Model {
  constructor() {
    super(admins, "admins");
  }
}
