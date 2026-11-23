<?php

namespace App\Http\Controllers;

use App\Models\Fasilitas;
use App\Models\Ruangan;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

class RuanganController extends Controller
{
    public function index()
    {
        // Eager load relasi fasilitasRelasi agar query cepat dan ringan
        $ruangans = Ruangan::with('fasilitasRelasi')
            ->orderBy('id_ruangan', 'desc')
            ->get();

        $pics = $this->getDaftarPic();

        return view('admin.kelola-ruangan', compact('ruangans', 'pics'));
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'kode_ruangan' => 'required|string|max:255|unique:ruangans,kode_ruangan',
            'name_ruangan' => 'required|string|max:255',
            'nama_gedung' => 'required|string|max:150',
            'nomor_lantai' => 'required|integer|min:1',
            'id_number' => 'required|integer|exists:pics,id_number',
            'kapasitas' => 'required|integer|min:1',
            'status_ruangan' => 'required|in:tersedia,tidak_tersedia',
            'fasilitas' => 'nullable|array',
            'fasilitas.*' => 'string|max:100',
            'fasilitas_lainnya' => 'nullable|string|max:255',
            'deskripsi_ruangan' => 'nullable|string',
            'foto_ruangan' => 'nullable|image|mimes:jpeg,png,jpg,webp|max:5120',
        ], [
            'kode_ruangan.unique' => 'Kode ruangan sudah terdaftar, gunakan kode lain.',
            'id_number.exists' => 'PIC yang dipilih tidak terdaftar di tabel pics.',
            'foto_ruangan.max' => 'Ukuran foto ruangan maksimal 5MB.',
        ]);

        // 1. Gabungkan checkbox fasilitas + fasilitas tambahan (+ Lainnya)
        $daftarFasilitas = $request->input('fasilitas', []);
        if ($request->filled('fasilitas_lainnya')) {
            $tambahan = array_filter(array_map('trim', explode(',', $request->input('fasilitas_lainnya'))));
            $daftarFasilitas = array_values(array_unique(array_merge($daftarFasilitas, $tambahan)));
        }

        // 2. Ambil biner gambar untuk kolom LONGBLOB (path_foto)
        $fotoBiner = null;
        if ($request->hasFile('foto_ruangan')) {
            $fotoBiner = file_get_contents($request->file('foto_ruangan')->getRealPath());
        }

        // 3. Resolusi ID Foreign Key Gedung, Lantai & PIC
        $idGedung = $this->resolveIdGedung($validated['nama_gedung']);
        $nomorLantai = $this->resolveNomorLantai((int) $validated['nomor_lantai'], $idGedung);
        $idNumber = (int) $validated['id_number'];
        $namaPic = $this->getNamaPicByIdNumber($idNumber);

        // 4. Simpan metadata deskripsi, lokasi, dan nama PIC
        $metaDeskripsi = json_encode([
            '_meta' => true,
            'deskripsi' => $validated['deskripsi_ruangan'] ?? '',
            'lokasi' => trim($validated['nama_gedung']) . ' Lt. ' . $validated['nomor_lantai'],
            'pic_name' => $namaPic,
        ], JSON_UNESCAPED_UNICODE);

        DB::transaction(function () use ($validated, $fotoBiner, $metaDeskripsi, $idGedung, $idNumber, $nomorLantai, $daftarFasilitas) {
            // 5. Simpan data utama ke tabel ruangans
            $ruangan = Ruangan::create([
                'kode_ruangan' => strtoupper(trim($validated['kode_ruangan'])),
                'name_ruangan' => $validated['name_ruangan'],
                'kapasitas' => $validated['kapasitas'],
                'deskripsi_ruangan' => $metaDeskripsi,
                'status_ruangan' => $validated['status_ruangan'],
                'path_foto' => $fotoBiner,
                'id_gedung' => $idGedung,
                'id_number' => $idNumber,
                'nomor_lantai' => $nomorLantai,
            ]);

            // 6. Simpan setiap item fasilitas ke tabel fasilitas dengan id_ruangan
            foreach ($daftarFasilitas as $namaFasilitas) {
                Fasilitas::create([
                    'nama_fasilitas' => $namaFasilitas,
                    'id_ruangan' => $ruangan->id_ruangan,
                ]);
            }
        });

        return redirect()
            ->route('kelola.ruangan.admin')
            ->with('success', 'Data ruangan "' . $validated['name_ruangan'] . '" dan fasilitasnya berhasil disimpan!');
    }

    private function getDaftarPic()
    {
        $userTable = Schema::hasTable('users') ? 'users' : (Schema::hasTable('user') ? 'user' : null);
        if (!$userTable || !Schema::hasTable('pics')) {
            return collect();
        }

        $userCols = Schema::getColumnListing($userTable);
        $nameCol = in_array('name', $userCols) ? 'name' : 'nama';
        $idCol = in_array('id_number', $userCols) ? 'id_number' : 'id';

        return DB::table('pics')
            ->join($userTable, 'pics.id_number', '=', "{$userTable}.{$idCol}")
            ->select(
                'pics.id_number as id_number',
                "{$userTable}.{$nameCol} as nama_pic"
            )
            ->orderBy("{$userTable}.{$nameCol}", 'asc')
            ->get();
    }

    private function getNamaPicByIdNumber(int $idNumber): string
    {
        $userTable = Schema::hasTable('users') ? 'users' : (Schema::hasTable('user') ? 'user' : null);
        if (!$userTable) {
            return 'PIC #' . $idNumber;
        }

        $userCols = Schema::getColumnListing($userTable);
        $nameCol = in_array('name', $userCols) ? 'name' : 'nama';
        $idCol = in_array('id_number', $userCols) ? 'id_number' : 'id';

        $user = DB::table($userTable)->where($idCol, $idNumber)->first();
        return $user ? $user->{$nameCol} : ('PIC #' . $idNumber);
    }

    private function resolveIdGedung(string $namaGedung): int
    {
        $table = Schema::hasTable('gedung') ? 'gedung' : (Schema::hasTable('gedungs') ? 'gedungs' : null);
        if (!$table) {
            return 1;
        }

        $columns = Schema::getColumnListing($table);
        $pkCol = in_array('id_gedung', $columns) ? 'id_gedung' : 'id';
        $nameCol = collect(['nama_gedung', 'name_gedung', 'nama', 'name'])->first(fn($c) => in_array($c, $columns));

        if ($nameCol) {
            $existing = DB::table($table)->where($nameCol, trim($namaGedung))->first();
            if ($existing) {
                return (int) $existing->{$pkCol};
            }

            $insertData = [$nameCol => trim($namaGedung)];
            if (in_array('kode_gedung', $columns))
                $insertData['kode_gedung'] = 'GD-' . rand(100, 999);
            if (in_array('deskripsi', $columns))
                $insertData['deskripsi'] = '-';
            if (in_array('created_at', $columns))
                $insertData['created_at'] = now();
            if (in_array('updated_at', $columns))
                $insertData['updated_at'] = now();

            return (int) DB::table($table)->insertGetId($insertData);
        }

        $first = DB::table($table)->first();
        return $first ? (int) $first->{$pkCol} : 1;
    }

    public function destroy($id)
    {
        $ruangan = Ruangan::findOrFail($id);
        $namaRuangan = $ruangan->name_ruangan;

        DB::transaction(function () use ($ruangan) {
            Fasilitas::where('id_ruangan', $ruangan->id_ruangan)->delete();
            $ruangan->delete();
        });

        return redirect()
            ->route('kelola.ruangan.admin')
            ->with('success', 'Data ruangan "' . $namaRuangan . '" berhasil dihapus!');
    }

    private function resolveNomorLantai(int $lantai, int $idGedung): int
    {
        $table = Schema::hasTable('lantai') ? 'lantai' : (Schema::hasTable('lantais') ? 'lantais' : null);
        if (!$table) {
            return $lantai;
        }

        $columns = Schema::getColumnListing($table);
        $pkCol = in_array('nomor_lantai', $columns) ? 'nomor_lantai' : 'id';

        $existing = DB::table($table)->where($pkCol, $lantai)->first();
        if ($existing) {
            return (int) $existing->{$pkCol};
        }

        $insertData = [$pkCol => $lantai];
        if (in_array('id_gedung', $columns))
            $insertData['id_gedung'] = $idGedung;
        if (in_array('nama_lantai', $columns))
            $insertData['nama_lantai'] = 'Lantai ' . $lantai;
        if (in_array('name_lantai', $columns))
            $insertData['name_lantai'] = 'Lantai ' . $lantai;
        if (in_array('created_at', $columns))
            $insertData['created_at'] = now();
        if (in_array('updated_at', $columns))
            $insertData['updated_at'] = now();

        DB::table($table)->insert($insertData);
        return $lantai;
    }
}