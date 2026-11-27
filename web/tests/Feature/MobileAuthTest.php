<?php

namespace Tests\Feature;

use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class MobileAuthTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();
        config(['database.default' => 'sqlite', 'database.connections.sqlite.database' => ':memory:']);
        Schema::create('users', function (Blueprint $table) {
            $table->unsignedBigInteger('id_number')->primary();
            $table->string('email');
            $table->string('name');
            $table->string('role');
            $table->string('password');
            $table->boolean('is_active');
        });
        (require database_path('migrations/2026_04_12_151553_create_personal_access_tokens_table.php'))->up();
        DB::table('users')->insert([
            'id_number' => 12345, 'email' => 'uji@example.test', 'name' => 'Uji',
            'role' => 'mahasiswa', 'password' => Hash::make('sandi-uji'), 'is_active' => true,
        ]);
    }

    public function test_login_restore_and_revoke_only_current_session(): void
    {
        $login = fn ($identifier) => $this->postJson('/api/login', [
            'identifier' => $identifier, 'password' => 'sandi-uji',
        ])->assertOk()->json('token');
        $first = $login('12345');
        $second = $login('uji@example.test');
        $this->withToken($first)->getJson('/api/me')->assertOk()->assertJsonPath('role', 'mahasiswa');
        Auth::forgetGuards();
        $this->postJson('/api/logout')->assertNoContent();
        Auth::forgetGuards();
        $this->getJson('/api/me')->assertUnauthorized();
        Auth::forgetGuards();
        $this->withToken($second)->getJson('/api/me')->assertOk();
    }

    public function test_invalid_credentials_and_inactive_accounts_receive_no_token(): void
    {
        $this->postJson('/api/login', ['identifier' => '12345', 'password' => 'salah'])->assertUnauthorized();
        DB::table('users')->update(['is_active' => false]);
        $this->postJson('/api/login', ['identifier' => '12345', 'password' => 'sandi-uji'])->assertUnauthorized();
        $this->assertDatabaseCount('personal_access_tokens', 0);
    }
}
