<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class Profile extends Model
{
  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'profiles';

  /**
   * The attributes that are mass assignable.
   *
   * @var array<int, string>
   */
  protected $fillable = [
    'id',
    'role',
    'fullname',
  ];

  /**
   * The attributes that should be cast.
   *
   * @var array<string, string>
   */
  protected $casts = [
    'created_at' => 'datetime',
    'updated_at' => 'datetime',
  ];

  /**
   * Indicates if the IDs are auto-incrementing.
   *
   * @var bool
   */
  public $incrementing = false;

  /**
   * The "type" of the primary key ID.
   *
   * @var string
   */
  protected $keyType = 'int';

  /**
   * Get the user that owns the profile.
   * Joins using id field (since profile id = user id for Admin/Super Admin)
   */
  public function user(): BelongsTo
  {
    return $this->belongsTo(User::class, 'id', 'id');
  }

  /**
   * Scope a query to search profiles using fulltext index.
   */
  public function scopeSearch($query, string $term)
  {
    return $query->whereFullText(['fullname'], $term);
  }

  /**
   * Scope a query to get profiles by role.
   */
  public function scopeByRole($query, string $role)
  {
    return $query->where('role', $role);
  }

  /**
   * Scope a query to get only admin profiles.
   */
  public function scopeAdmins($query)
  {
    return $query->where('role', 'Admin');
  }

  /**
   * Scope a query to get only super admin profiles.
   */
  public function scopeSuperAdmins($query)
  {
    return $query->where('role', 'Super Admin');
  }

  /**
   * Scope a query to get admin-level profiles (Admin or Super Admin).
   */
  public function scopeAdminLevel($query)
  {
    return $query->whereIn('role', ['Admin', 'Super Admin']);
  }
}