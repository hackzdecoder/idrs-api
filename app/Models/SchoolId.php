<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Builder;

class SchoolId extends Model
{
  use HasFactory;

  protected $table = 'school_id';

  protected $primaryKey = 'id';

  public $incrementing = true;

  public $timestamps = false;

  protected $fillable = [
    'id',
    'school_code',
    'school_name',
    'school_email',
    'school_logo',
  ];

  protected $casts = [];

  protected $hidden = [];

  /**
   * Scope a query to search using FULLTEXT index
   */
  public function scopeSearch(Builder $query, string $term): Builder
  {
    return $query->whereFullText([
      'id',
      'school_code',
      'school_name',
      'school_logo'
    ], $term);
  }

  /**
   * Scope a query to filter by school code
   */
  public function scopeBySchoolCode(Builder $query, ?string $schoolCode): Builder
  {
    if ($schoolCode) {
      return $query->where('school_code', 'like', '%' . $schoolCode . '%');
    }
    return $query;
  }

  /**
   * Scope a query to filter by school name
   */
  public function scopeBySchoolName(Builder $query, ?string $schoolName): Builder
  {
    if ($schoolName) {
      return $query->where('school_name', 'like', '%' . $schoolName . '%');
    }
    return $query;
  }

  /**
   * Get school by code (case-insensitive)
   */
  public static function findByCode(string $schoolCode): ?self
  {
    return self::where('school_code', $schoolCode)
      ->orWhere('school_code', strtolower($schoolCode))
      ->orWhere('school_code', strtoupper($schoolCode))
      ->first();
  }

  /**
   * Get school email by code
   */
  public static function getEmailByCode(string $schoolCode): ?string
  {
    $school = self::findByCode($schoolCode);
    return $school ? $school->school_email : null;
  }

  /**
   * Get school name by code
   */
  public static function getNameByCode(string $schoolCode): ?string
  {
    $school = self::findByCode($schoolCode);
    return $school ? $school->school_name : null;
  }
}