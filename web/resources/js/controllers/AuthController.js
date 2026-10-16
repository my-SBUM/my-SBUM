// AuthController.js – login & register (mock, simpan sesi di Store)
import { Controller } from "@/core/Controller.js";
import { AuthLayout } from "@/views/layouts/AuthLayout.js";
import { login } from "@/views/pages/auth/login.js";
import { register } from "@/views/pages/auth/register.js";
import { UserModel } from "@/models/UserModel.js";
import { Store } from "@/core/Store.js";
import { Router } from "@/core/Router.js";

export class AuthController extends Controller {
    login() {
        this.setLayout(AuthLayout);
        this.render(login());
        this.bindLogin();
    }

    register() {
        this.setLayout(AuthLayout);
        this.render(register());
        this.bindRegister();
    }

    /** Login mock: kredensial demo atau pilih akun demo */
    bindLogin() {
        const form = document.getElementById("form-login");
        const toggle = document.getElementById("toggle-pass");
        const pass = document.getElementById("password");
        toggle?.addEventListener("click", () => {
            pass.type = pass.type === "password" ? "text" : "password";
        });

        form.addEventListener("submit", (e) => {
            e.preventDefault();
            const username = form.username.value.trim();
            const password = form.password.value;
            const err = document.getElementById("login-error");
            err.classList.add("hidden");

            const user = new UserModel().authenticate(username, password);
            if (!user) {
                err.textContent =
                    "NIM/NIP/Email atau password salah. Gunakan akun demo di bawah.";
                err.classList.remove("hidden");
                return;
            }
            Store.setUser({
                name: user.name,
                role: user.role,
                roleLabel: user.roleLabel,
            });
            Router.navigate(user.role === "admin" ? "/admin" : "/dashboard");
        });

        document.querySelectorAll("[data-demo]").forEach((b) => {
            b.addEventListener("click", () => {
                form.username.value = b.dataset.demo;
                form.password.value = "demo123";
            });
        });
    }

    /** Register: validasi klien lalu tampilkan pesan sukses (belum tersambung backend) */
    bindRegister() {
        const form = document.getElementById("form-register");
        form.addEventListener("submit", (e) => {
            e.preventDefault();
            const ok = form.checkValidity();
            form.querySelectorAll(":invalid").forEach((el) =>
                el.classList.add("ring-2", "ring-red-400"),
            );
            const msg = document.getElementById("register-msg");
            if (ok) {
                msg.textContent =
                    "Pendaftaran berhasil (mock). Silakan login dengan akun demo.";
                msg.classList.remove("hidden", "text-red-600");
                msg.classList.add("text-brand-light");
            }
        });
    }
}
export default AuthController;
