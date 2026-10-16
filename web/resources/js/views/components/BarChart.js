// BarChart.js – bar chart bertumpuk SVG tanpa dependensi (Selesai/Menunggu/Ditolak)
const DAYS = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"];

export function BarChart(series) {
    const W = 560,
        H = 220,
        pad = 34,
        bw = 34;
    const max = Math.max(...series.map((s) => s[0] + s[1] + s[2]), 10);
    const chartH = H - 40;
    const cols = series
        .map((s, i) => {
            const x = pad + i * 74;
            const colors = ["#16A36B", "#F59E0B", "#DC2626"];
            let y = chartH;
            return s
                .map((v, j) => {
                    const h = (v / max) * (chartH - 20);
                    y -= h;
                    return `<rect x="${x}" y="${y}" width="${bw}" height="${h}" rx="3" fill="${colors[j]}"><title>${DAYS[i]}: ${v}</title></rect>`;
                })
                .join("");
        })
        .join("");
    const labels = series
        .map(
            (_, i) =>
                `<text x="${pad + i * 74 + bw / 2}" y="${H - 14}" text-anchor="middle" font-size="11" fill="#94a3b8">${DAYS[i]}</text>`,
        )
        .join("");
    return `
  <svg viewBox="0 0 ${W} ${H}" class="w-full" role="img" aria-label="Tren mingguan">
    <line x1="${pad - 8}" y1="${chartH}" x2="${W - 8}" y2="${chartH}" stroke="#E5E7EB"/>
    ${cols}${labels}
  </svg>`;
}
