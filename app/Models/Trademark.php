<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Builder;

class Trademark extends Model
{
  use HasFactory;

  /**
   * Use the separate trademarks database connection
   */
  protected $connection = 'trademarks';

  /**
   * The table associated with the model.
   *
   * @var string
   */
  protected $table = 'companies';

  /**
   * The primary key associated with the table.
   *
   * @var string
   */
  protected $primaryKey = 'id';

  /**
   * Indicates if the IDs are auto-incrementing.
   *
   * @var bool
   */
  public $incrementing = true;

  /**
   * The data type of the primary key.
   *
   * @var string
   */
  protected $keyType = 'int';

  /**
   * Indicates if the model should be timestamped.
   *
   * @var bool
   */
  public $timestamps = true;

  /**
   * The attributes that are mass assignable.
   *
   * @var array<int, string>
   */
  protected $fillable = [
    'id',
    'copyright_name',
    'company_name',
    'publication_date',
  ];

  /**
   * The attributes that should be cast.
   *
   * @var array<string, string>
   */
  protected $casts = [
    'publication_date' => 'datetime',
    'created_at' => 'datetime',
    'updated_at' => 'datetime',
  ];

  /**
   * The attributes that should be hidden for serialization.
   *
   * @var array<int, string>
   */
  protected $hidden = [];

  // ==========================================================================
  // SCOPES
  // ==========================================================================

  /**
   * Scope a query to search companies using fulltext index.
   */
  public function scopeSearch(Builder $query, string $term): Builder
  {
    return $query->whereFullText(['copyright_name', 'company_name'], $term);
  }

  /**
   * Scope a query to get latest companies.
   */
  public function scopeLatest(Builder $query): Builder
  {
    return $query->orderBy('created_at', 'desc');
  }

  /**
   * Scope a query to get companies by copyright name.
   */
  public function scopeByCopyrightName(Builder $query, string $name): Builder
  {
    return $query->where('copyright_name', 'like', '%' . $name . '%');
  }

  /**
   * Scope a query to get companies by company name.
   */
  public function scopeByCompanyName(Builder $query, string $name): Builder
  {
    return $query->where('company_name', 'like', '%' . $name . '%');
  }

  /**
   * Scope a query to get active companies (with publication date not null).
   */
  public function scopeActive(Builder $query): Builder
  {
    return $query->whereNotNull('publication_date');
  }

  // ==========================================================================
  // ACCESSORS & MUTATORS
  // ==========================================================================

  /**
   * Get the full copyright notice.
   */
  public function getCopyrightNoticeAttribute(): string
  {
    return '© ' . now()->year . ' ' . $this->copyright_name . '. All rights reserved.';
  }

  /**
   * Get the company display name.
   */
  public function getDisplayNameAttribute(): string
  {
    return $this->company_name . ' (' . $this->copyright_name . ')';
  }

  /**
   * Get the formatted publication date.
   */
  public function getFormattedPublicationDateAttribute(): string
  {
    if ($this->publication_date) {
      return $this->publication_date->format('F d, Y');
    }
    return 'N/A';
  }

  // ==========================================================================
  // RELATIONSHIPS (Optional - if needed)
  // ==========================================================================

  /**
   * Get the user that created/owns this company.
   * Uncomment if you have a user_id field in the companies table
   */
  // public function user()
  // {
  //     return $this->belongsTo(User::class, 'user_id');
  // }
}