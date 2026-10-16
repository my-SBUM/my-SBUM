// AdminDashboardController.js â€“ dashboard Admin SBUM (PDF 7 & 8)
import { Controller } from "@/core/Controller.js";
import { DashboardLayout } from "@/views/layouts/DashboardLayout.js";
import { adminDashboard } from "@/views/pages/admin/dashboard.js";
import { BookingModel } from "@/models/BookingModel.js";
import { ActivityModel } from "@/models/ActivityModel.js";

export class AdminDashboardController extends Controller {
    async index() {
        const bookings = new BookingModel();
        const acts = new ActivityModel();
        const stats = bookings.stats();
        const data = {
            title: "Dashboard Admin",
            crumbs: [{ label: "Dashboard" }],
            routePath: "/admin",
            stats,
            activities: acts.latest(4),
            queue: bookings.filter((b) => b.status === "menunggu").slice(0, 3),
        };
        this.setLayout(DashboardLayout);
        this.render(adminDashboard(data), data);
        document.querySelectorAll("[data-review]").forEach((b) => {
            b.addEventListener(
                "click",
                () => (location.hash = "#/admin/persetujuan"),
            );
        });
    }
}
export default AdminDashboardController;


