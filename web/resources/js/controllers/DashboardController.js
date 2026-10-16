// DashboardController.js â€“ dashboard Koordinator Lab
import { Controller } from "@/core/Controller.js";
import { DashboardLayout } from "@/views/layouts/DashboardLayout.js";
import { dashboard } from "@/views/pages/user/dashboard.js";
import { BookingModel } from "@/models/BookingModel.js";
import { RoomModel } from "@/models/RoomModel.js";
import { EquipmentModel } from "@/models/EquipmentModel.js";
import { ActivityModel } from "@/models/ActivityModel.js";

export class DashboardController extends Controller {
    async index() {
        const bookings = new BookingModel();
        const rooms = new RoomModel();
        const equips = new EquipmentModel();
        const acts = new ActivityModel();

        const data = {
            title: "Halaman Dashboard",
            crumbs: [{ label: "Dashboard" }],
            routePath: "/dashboard",
            stats: bookings.stats(),
            totalRooms: rooms.all().length,
            totalEquips: equips.all().length,
            pending: bookings
                .filter((b) => b.status === "menunggu")
                .slice(0, 5),
            activities: acts.latest(3),
        };

        this.setLayout(DashboardLayout);
        this.render(dashboard(data), data);
        this.bind();
    }

    bind() {
        document
            .getElementById("link-all-activity")
            ?.addEventListener("click", (e) => {
                e.preventDefault();
            });
    }
}
export default DashboardController;

