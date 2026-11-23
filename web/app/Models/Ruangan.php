<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Ruangan extends Model
{
    use HasFactory;

    protected $table = 'ruangans';
    protected $primaryKey = 'id_ruangan';

    protected $fillable = [
        'kode_ruangan',
        'name_ruangan',
        'kapasitas',
        'deskripsi_ruangan',
        'status_ruangan',
        'path_foto',
        'id_gedung',
        'id_number',
        'nomor_lantai',
    ];

    /**
     * Relasi ke tabel fasilitas (1 Ruangan punya banyak Fasilitas)
     */
    public function fasilitasRelasi()
    {
        return $this->hasMany(Fasilitas::class, 'id_ruangan', 'id_ruangan');
    }

    protected function parseMeta(): ?array
    {
        if (!empty($this->deskripsi_ruangan)) {
            $decoded = json_decode($this->deskripsi_ruangan, true);
            if (json_last_error() === JSON_ERROR_NONE && is_array($decoded) && isset($decoded['_meta'])) {
                return $decoded;
            }
        }
        return null;
    }

    public function getLokasiTeksAttribute()
    {
        $meta = $this->parseMeta();
        return $meta['lokasi'] ?? ('Gedung #' . $this->id_gedung . ' Lt. ' . $this->nomor_lantai);
    }

    public function getPicNameAttribute()
    {
        $meta = $this->parseMeta();
        return $meta['pic_name'] ?? ('PIC #' . $this->id_number);
    }

    /**
     * Mengambil daftar nama fasilitas dari tabel fasilitas
     */
    public function getFasilitasAttribute()
    {
        if ($this->relationLoaded('fasilitasRelasi') && $this->fasilitasRelasi->isNotEmpty()) {
            return $this->fasilitasRelasi->pluck('nama_fasilitas')->toArray();
        }

        $fromTable = $this->fasilitasRelasi()->pluck('nama_fasilitas')->toArray();
        if (!empty($fromTable)) {
            return $fromTable;
        }

        $meta = $this->parseMeta();
        return $meta['fasilitas'] ?? [];
    }

    public function getDeskripsiTeksAttribute()
    {
        $meta = $this->parseMeta();
        if ($meta !== null) {
            return $meta['deskripsi'] ?? '';
        }
        return $this->deskripsi_ruangan ?? '';
    }
}