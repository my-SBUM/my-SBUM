<?php

namespace App\Services;

use App\Models\Peminjaman;
use Illuminate\Support\Facades\DB;
use RuntimeException;

class PersetujuanService
{
    /**
     * Contoh kerangka service. Sesuaikan status dan aturan fase dengan SOP SBUM.
     */
    public function setujui(Peminjaman $peminjaman, int $userId, string $catatan = ''): void
    {
        DB::transaction(function () use ($peminjaman, $userId, $catatan) {
            // TODO: Validasi fase, role, dan status sebelum menyetujui.
            // Jangan aktifkan perubahan status sebelum aturan bisnis ditentukan.
            throw new RuntimeException(
                'PersetujuanService belum dikonfigurasi. Lengkapi aturan fase persetujuan terlebih dahulu.'
            );
        });
    }
}
