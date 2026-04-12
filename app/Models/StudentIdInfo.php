<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Builder;

class StudentIdInfo extends Model
{
  use HasFactory;

  protected $table = 'student_id_info';

  protected $primaryKey = 'id';

  public $incrementing = true;

  public $timestamps = false;

  protected $fillable = [
    'id',
    'school_code',
    'student_id',
    'first_name',
    'middle_initial',
    'surname',
    'suffix_name',
    'name_to_appear_on_id',
    'nick_name',
    'birth_date',
    'gender',
    'residential_address',
    'emergency_contact_person',
    'emergency_contact_number',
    'student_picture',
    'level',
    'section_course',
    'lrn',
    'student_type',
    'esc_voucher_recipient',
    'esc_number',
    'parent_first_name',
    'parent_surname',
    'parent_email',
    'id_info_status',
    'id_info_approval_date',
    'class_details_status',
    'class_details_approval_date',
    'id_print_status',
    'id_print_date',
    'id_reprint_status',
    'id_reprint_date',
    'id_reprint_count',
    'sms_app_credentials',
    'sms_app_created_at',
    'created_at',
  ];

  protected $casts = [
    'birth_date' => 'date',
    'id_info_approval_date' => 'datetime',
    'class_details_approval_date' => 'datetime',
    'id_print_date' => 'datetime',
    'id_reprint_date' => 'datetime',
    'sms_app_created_at' => 'datetime',
    'created_at' => 'datetime',
    'id_reprint_count' => 'integer',
    'esc_voucher_recipient' => 'boolean',
  ];

  protected $hidden = [];

  /**
   * Get the user associated with this student ID info
   */
  public function user()
  {
    return $this->belongsTo(User::class, 'student_id', 'student_id')
      ->where('users.school_code', '=', $this->school_code);
  }

  /**
   * Scope a query to search using FULLTEXT index
   */
  public function scopeSearch(Builder $query, string $term): Builder
  {
    return $query->whereFullText([
      'id',
      'school_code',
      'student_id',
      'first_name',
      'middle_initial',
      'surname',
      'suffix_name',
      'name_to_appear_on_id',
      'nick_name',
      'birth_date',
      'gender',
      'residential_address',
      'emergency_contact_person',
      'emergency_contact_number',
      'student_picture',
      'level',
      'section_course',
      'lrn',
      'student_type',
      'esc_voucher_recipient',
      'esc_number',
      'parent_first_name',
      'parent_surname',
      'parent_email',
      'id_info_status',
      'id_info_approval_date',
      'class_details_status',
      'class_details_approval_date',
      'id_print_status',
      'id_print_date',
      'id_reprint_status',
      'id_reprint_date',
      'id_reprint_count',
      'sms_app_credentials',
      'sms_app_created_at',
      'created_at'
    ], $term);
  }

  /**
   * Scope a query to filter by school code.
   */
  public function scopeBySchoolCode(Builder $query, ?string $schoolCode): Builder
  {
    if ($schoolCode) {
      return $query->where('school_code', 'like', '%' . $schoolCode . '%');
    }
    return $query;
  }

  /**
   * Scope a query to filter by student ID.
   */
  public function scopeByStudentId(Builder $query, ?string $studentId): Builder
  {
    if ($studentId) {
      return $query->where('student_id', 'like', '%' . $studentId . '%');
    }
    return $query;
  }

  /**
   * Scope a query to filter by ID info status.
   */
  public function scopeByIdInfoStatus(Builder $query, ?string $status): Builder
  {
    if ($status) {
      return $query->where('id_info_status', $status);
    }
    return $query;
  }

  /**
   * Scope a query to filter by class details status.
   */
  public function scopeByClassDetailsStatus(Builder $query, ?string $status): Builder
  {
    if ($status) {
      return $query->where('class_details_status', $status);
    }
    return $query;
  }

  /**
   * Scope a query to filter by ID print status.
   */
  public function scopeByIdPrintStatus(Builder $query, ?string $status): Builder
  {
    if ($status) {
      return $query->where('id_print_status', $status);
    }
    return $query;
  }

  /**
   * Scope a query to filter by ID reprint status.
   */
  public function scopeByIdReprintStatus(Builder $query, ?string $status): Builder
  {
    if ($status) {
      return $query->where('id_reprint_status', $status);
    }
    return $query;
  }

  /**
   * Scope a query to filter by student type.
   */
  public function scopeByStudentType(Builder $query, ?string $studentType): Builder
  {
    if ($studentType) {
      return $query->where('student_type', $studentType);
    }
    return $query;
  }

  /**
   * Scope a query to filter by level.
   */
  public function scopeByLevel(Builder $query, ?string $level): Builder
  {
    if ($level) {
      return $query->where('level', $level);
    }
    return $query;
  }

  /**
   * Scope a query to filter by section/course.
   */
  public function scopeBySectionCourse(Builder $query, ?string $sectionCourse): Builder
  {
    if ($sectionCourse) {
      return $query->where('section_course', $sectionCourse);
    }
    return $query;
  }

  /**
   * Scope a query to filter by account status (from user relationship).
   */
  public function scopeByAccountStatus(Builder $query, ?string $status): Builder
  {
    if ($status) {
      return $query->whereHas('user', function ($q) use ($status) {
        $q->where('account_status', $status);
      });
    }
    return $query;
  }

  /**
   * Scope a query to filter by enrollment date range (created_at).
   */
  public function scopeByDateRange(Builder $query, ?string $dateFrom, ?string $dateTo): Builder
  {
    if ($dateFrom) {
      $query->whereDate('created_at', '>=', $dateFrom);
    }
    if ($dateTo) {
      $query->whereDate('created_at', '<=', $dateTo);
    }
    return $query;
  }

  /**
   * ✅ NEW: Scope a query to filter by ID info approval date range
   */
  public function scopeByIdInfoApprovalDateRange(Builder $query, ?string $dateFrom, ?string $dateTo): Builder
  {
    if ($dateFrom && $dateTo) {
      return $query->whereDate('id_info_approval_date', '>=', $dateFrom)
        ->whereDate('id_info_approval_date', '<=', $dateTo);
    }
    if ($dateFrom) {
      return $query->whereDate('id_info_approval_date', '>=', $dateFrom);
    }
    if ($dateTo) {
      return $query->whereDate('id_info_approval_date', '<=', $dateTo);
    }
    return $query;
  }

  /**
   * ✅ NEW: Scope a query to filter by class details approval date range
   */
  public function scopeByClassDetailsApprovalDateRange(Builder $query, ?string $dateFrom, ?string $dateTo): Builder
  {
    if ($dateFrom && $dateTo) {
      return $query->whereDate('class_details_approval_date', '>=', $dateFrom)
        ->whereDate('class_details_approval_date', '<=', $dateTo);
    }
    if ($dateFrom) {
      return $query->whereDate('class_details_approval_date', '>=', $dateFrom);
    }
    if ($dateTo) {
      return $query->whereDate('class_details_approval_date', '<=', $dateTo);
    }
    return $query;
  }

  /**
   * Scope a query to filter by email (using user relationship).
   */
  public function scopeByEmail(Builder $query, ?string $email): Builder
  {
    if ($email) {
      return $query->whereHas('user', function ($q) use ($email) {
        $q->where('email', 'like', '%' . $email . '%')
          ->orWhere('school_email', 'like', '%' . $email . '%');
      });
    }
    return $query;
  }

  /**
   * Scope a query to get students with user relationship.
   */
  public function scopeWithUser(Builder $query): Builder
  {
    return $query->with('user');
  }

  /**
   * Scope a query to order by latest created.
   */
  public function scopeLatest(Builder $query): Builder
  {
    return $query->orderBy('created_at', 'desc');
  }
}