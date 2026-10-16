<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AuthLoginTest extends TestCase
{
    use RefreshDatabase;

    private function makeUser(): User
    {
        return User::create([
            'name' => 'Test User',
            'nim' => '2021010001',
            'email' => 'test@example.com',
            'password' => 'password',
        ]);
    }

    public function test_login_screen_is_rendered(): void
    {
        $response = $this->get('/login');

        $response->assertOk();
        $response->assertSee('NIM/NIP');
    }

    public function test_user_can_login_with_nim(): void
    {
        $this->makeUser();

        $response = $this->post('/login', [
            'nim' => '2021010001',
            'password' => 'password',
        ]);

        $this->assertAuthenticated();
        $response->assertRedirect(route('dashboard'));
    }

    public function test_user_can_login_with_email(): void
    {
        $this->makeUser();

        $response = $this->post('/login', [
            'nim' => 'test@example.com',
            'password' => 'password',
        ]);

        $this->assertAuthenticated();
        $response->assertRedirect(route('dashboard'));
    }

    public function test_user_cannot_login_with_wrong_password(): void
    {
        $this->makeUser();

        $response = $this->post('/login', [
            'nim' => '2021010001',
            'password' => 'wrong-password',
        ]);

        $this->assertGuest();
        $response->assertSessionHasErrors('nim');
    }

    public function test_login_requires_fields(): void
    {
        $response = $this->post('/login', []);

        $response->assertSessionHasErrors(['nim', 'password']);
    }

    public function test_authenticated_user_can_access_dashboard(): void
    {
        $user = $this->makeUser();

        $response = $this->actingAs($user)->get('/dashboard');

        $response->assertOk();
        $response->assertSee($user->name);
    }

    public function test_guest_is_redirected_from_dashboard(): void
    {
        $response = $this->get('/dashboard');

        $response->assertRedirect('/login');
    }

    public function test_authenticated_user_can_logout(): void
    {
        $user = $this->makeUser();

        $response = $this->actingAs($user)->post('/logout');

        $this->assertGuest();
        $response->assertRedirect('/');
    }
}
