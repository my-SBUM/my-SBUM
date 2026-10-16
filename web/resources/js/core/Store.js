// Store.js – state ringan: user login mock & data lokal, persist ke localStorage
const KEY_USER = "mysbum:user";
const KEY_DB = "mysbum:db";

/** User yang sedang login (mock) */
export const Store = {
  getUser() {
    try {
      return JSON.parse(localStorage.getItem(KEY_USER));
    } catch {
      return null;
    }
  },
  setUser(user) {
    if (user) localStorage.setItem(KEY_USER, JSON.stringify(user));
    else localStorage.removeItem(KEY_USER);
  },
  /** Simpan koleksi mock (mis. bookings/admins) agar persist in-memory */
  get(key) {
    try {
      return JSON.parse(localStorage.getItem(`${KEY_DB}:${key}`));
    } catch {
      return null;
    }
  },
  set(key, value) {
    localStorage.setItem(`${KEY_DB}:${key}`, JSON.stringify(value));
  },
};
