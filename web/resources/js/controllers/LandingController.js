// LandingController.js – halaman landing (publik)
import { Controller } from "@/core/Controller.js";
import { PublicLayout } from "@/views/layouts/PublicLayout.js";
import { landing } from "@/views/pages/public/landing.js";

export class LandingController extends Controller {
    index() {
        this.setLayout(PublicLayout);
        this.render(landing());
    }
}
export default LandingController;
