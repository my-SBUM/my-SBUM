// UserModel.js – model akun demo (login mock)
import { Model } from "@/core/Model.js";
import { users } from "@/models/data/users.js";

export class UserModel extends Model {
  constructor() {
    super(users);
  }

  /** Verifikasi kredensial mock */
  authenticate(username, password) {
    return (
      this.all().find(
        (u) =>
          u.username.toLowerCase() === username.toLowerCase() &&
          u.password === password,
      ) || null
    );
  }
}
