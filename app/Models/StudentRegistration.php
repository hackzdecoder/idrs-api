<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class StudentRegistration extends Model
{
    use HasFactory;

    protected $table = 'student_registrations';
    protected $primaryKey = 'id';
    public $incrementing = true;
    protected $keyType = 'int';
    public $timestamps = true;

    protected $fillable = [
        'user_id',
        'student_id',
        'school_code',
        'lrn',
        'first_name',
        'middle_name',
        'last_name',
        'suffix',
        'nickname',
        'present_address',
        'permanent_address',
        'profile_img',
        'registration_type',
        'registration_status',
    ];

    protected $casts = [
        'created_at' => 'datetime',
        'updated_at' => 'datetime',
    ];

    /**
     * Get the user that owns the student registration.
     */
    public function user()
    {
        return $this->belongsTo(User::class, 'user_id', 'user_id');
    }

    /**
     * Get the full name attribute.
     */
    public function getFullNameAttribute()
    {
        $fullName = $this->first_name;
        
        if ($this->middle_name) {
            $fullName .= ' ' . $this->middle_name;
        }
        
        $fullName .= ' ' . $this->last_name;
        
        if ($this->suffix) {
            $fullName .= ' ' . $this->suffix;
        }
        
        return $fullName;
    }

    /**
     * Get the formatted name (Last, First Middle) attribute.
     */
    public function getFormattedNameAttribute()
    {
        $name = $this->last_name . ', ' . $this->first_name;
        
        if ($this->middle_name) {
            $name .= ' ' . substr($this->middle_name, 0, 1) . '.';
        }
        
        if ($this->suffix) {
            $name .= ' ' . $this->suffix;
        }
        
        return $name;
    }
}