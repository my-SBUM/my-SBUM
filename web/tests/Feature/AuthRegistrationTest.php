<?php

namespace Tests\Feature;

use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Schema;
use Tests\TestCase;

class AuthRegistrationTest extends TestCase
{
    use RefreshDatabase;

    protected function setUp(): void
    {
        parent::setUp();

        Schema::table('users', function (Blueprint $table): void {
            $table->unsignedBigInteger('id_number')->unique();
            $table->string('phone_number', 15);
            $table->string('role');
        });

        Schema::create('lecturers', function (Blueprint $table): void {
            $table->unsignedBigInteger('id_number')->primary();
            $table->timestamps();
        });
    }

    public function test_registration_form_uses_the_identity_field_expected_by_the_controller(): void
    {
        $this->get(route('register'))
            ->assertOk()
            ->assertSee('name="id_number"', false)
            ->assertDontSee('name="identity_number"', false);
    }

    public function test_registration_persists_user_and_role_profile(): void
    {
        $response = $this->post(route('register.store'), [
            'role' => 'lecturer',
            'name' => 'Test Lecturer',
            'id_number' => '3312101045',
            'email' => 'lecturer@example.test',
            'phone_number' => '081234567890',
            'password' => 'password123',
            'password_confirmation' => 'password123',
        ]);

        $response->assertRedirect(route('login'));

        $user = DB::table('users')->where('id_number', '3312101045')->first();
        $this->assertNotNull($user);
        $this->assertSame('Test Lecturer', $user->name);
        $this->assertSame('lecturer', $user->role);
        $this->assertTrue(Hash::check('password123', $user->password));
        $this->assertDatabaseHas('lecturers', ['id_number' => '3312101045']);
    }

    public function test_registration_validation_errors_are_shown_without_saving_a_user(): void
    {
        $response = $this->from(route('register'))->post(route('register.store'), [
            'role' => 'lecturer',
            'name' => 'Test Lecturer',
            'email' => 'lecturer@example.test',
            'phone_number' => '081234567890',
            'password' => 'password123',
            'password_confirmation' => 'password123',
        ]);

        $response->assertRedirect(route('register'))
            ->assertSessionHasErrors('id_number');

        $this->get(route('register'))
            ->assertSee('Pendaftaran gagal.')
            ->assertSee('id number');

        $this->assertDatabaseCount('users', 0);
    }
}
