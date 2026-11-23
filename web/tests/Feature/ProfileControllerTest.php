<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\Storage;
use Tests\TestCase;

class ProfileControllerTest extends TestCase
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
    }

    public function test_profile_photo_upload_is_saved_and_displayed(): void
    {
        Storage::fake('public');

        $user = User::factory()->create([
            'id_number' => '3312101045',
            'phone_number' => '081234567890',
            'role' => 'pj',
        ]);

        $response = $this->actingAs($user)->put(route('profile.update'), [
            'name' => $user->name,
            'email' => $user->email,
            'phone_number' => $user->phone_number,
            'profile_picture' => UploadedFile::fake()->image('profile.png'),
        ]);

        $response->assertRedirect()
            ->assertSessionHas('success', 'Profil berhasil diperbarui!');

        $profilePhotoPath = $user->fresh()->profile_picture;

        $this->assertNotNull($profilePhotoPath);
        Storage::disk('public')->assertExists($profilePhotoPath);
        $this->assertDatabaseHas('users', [
            'id_number' => $user->id_number,
            'profile_picture' => $profilePhotoPath,
        ]);

        $this->actingAs($user->fresh())
            ->get(route('profile.edit'))
            ->assertOk()
            ->assertSee('name="profile_picture"', false)
            ->assertSee('enctype="multipart/form-data"', false)
            ->assertSee(Storage::disk('public')->url($profilePhotoPath), false);
    }

    public function test_replacing_profile_photo_deletes_the_previous_file(): void
    {
        Storage::fake('public');

        $user = User::factory()->create([
            'id_number' => '3312101045',
            'phone_number' => '081234567890',
            'role' => 'pj',
        ]);
        $previousProfilePhotoPath = UploadedFile::fake()
            ->image('previous.png')
            ->storePublicly('profile-photos', 'public');
        $user->update(['profile_picture' => $previousProfilePhotoPath]);

        $this->actingAs($user)->put(route('profile.update'), [
            'name' => $user->name,
            'email' => $user->email,
            'phone_number' => $user->phone_number,
            'profile_picture' => UploadedFile::fake()->image('replacement.png'),
        ])->assertRedirect();

        $newProfilePhotoPath = $user->fresh()->profile_picture;

        $this->assertNotSame($previousProfilePhotoPath, $newProfilePhotoPath);
        Storage::disk('public')->assertMissing($previousProfilePhotoPath);
        Storage::disk('public')->assertExists($newProfilePhotoPath);
    }

    public function test_profile_photo_rejects_non_image_files(): void
    {
        Storage::fake('public');

        $user = User::factory()->create([
            'id_number' => '3312101045',
            'phone_number' => '081234567890',
            'role' => 'pj',
        ]);

        $this->from(route('profile.edit'))
            ->actingAs($user)
            ->put(route('profile.update'), [
                'name' => $user->name,
                'email' => $user->email,
                'phone_number' => $user->phone_number,
                'profile_picture' => UploadedFile::fake()->create('profile.pdf', 100, 'application/pdf'),
            ])
            ->assertRedirect(route('profile.edit'))
            ->assertSessionHasErrors([
                'profile_picture' => 'The profile picture field must be an image.',
            ]);

        $this->assertDatabaseHas('users', [
            'id_number' => $user->id_number,
            'profile_picture' => null,
        ]);
    }
}
