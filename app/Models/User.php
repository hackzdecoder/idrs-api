<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Laravel\Sanctum\HasApiTokens;

class User extends Authenticatable
{
  use HasFactory, Notifiable, HasApiTokens;

  public $timestamps = false; // Keep this as false

  protected $fillable = [
    'user_id',
    'username',
    'school_email',
    'email',
    'password',
    'user_role',
    'account_status',
    'email_verified_at',
    'student_id',
    'school_code',
    'account_name',
    'mobile_number',
    'last_successful_login',
  ];

  protected $hidden = [
    'password',
    'remember_token',
  ];

  protected function casts(): array
  {
    return [
      'email_verified_at' => 'datetime',
      'password' => 'hashed',
      'last_successful_login' => 'datetime',
    ];
  }

  public function isSuperAdmin(): bool
  {
    return $this->user_role === 'Super Admin';
  }

  public function isAdmin(): bool
  {
    return $this->user_role === 'Admin';
  }

  public function isStudent(): bool
  {
    return $this->user_role === 'Student';
  }

  public function hasRole($roles): bool
  {
    if (is_array($roles)) {
      return in_array($this->user_role, $roles);
    }
    return $this->user_role === $roles;
  }

  public function studentIdInfo()
  {
    return $this->hasOne(StudentIdInfo::class, 'student_id', 'student_id')
      ->where('school_code', $this->school_code);
  }
}