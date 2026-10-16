// tools/export-json.mjs – generate data/*.json dari data/*.js agar API PHP bisa membaca
import { readFileSync, writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const dir = join(
    dirname(fileURLToPath(import.meta.url)),
    "../resources/js/models/data",
);
for (const name of [
    "rooms",
    "equipments",
    "bookings",
    "activities",
    "admins",
]) {
    const src = readFileSync(join(dir, `${name}.js`), "utf8");
    const mod = await import(
        `file://${join(dir, `${name}.js`).replace(/\\/g, "/")}`
    );
    const rows = mod[name] ?? Object.values(mod)[0];
    writeFileSync(join(dir, `${name}.json`), JSON.stringify(rows, null, 2));
    console.log(`wrote ${name}.json (${rows.length} rows)`);
}
