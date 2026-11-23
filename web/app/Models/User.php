<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class User extends Authenticatable
{
    use HasFactory, Notifiable;

    /**
     * Nama primary key sesuai tabel database
     */
    protected $primaryKey = 'id_number';

    /**
     * Matikan auto-increment jika NIM/NIP diinput manual
     */
    public $incrementing = false;

    /**
     * Tipe data primary key
     */
    protected $keyType = 'string';

    /**
     * Kolom yang boleh diisi
     */
    protected $fillable = [
        'id_number',
        'name',
        'email',
        'phone_number',
        'profile_picture',
        'password',
        'role',
    ];

    /**
     * Kolom yang disembunyikan
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];
}
