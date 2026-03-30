<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class StudentProfileResource extends JsonResource
{
  /**
   * Transform the resource into an array.
   *
   * @return array<string, mixed>
   */
  public function toArray(Request $request): array
  {
    return [
      'student_id' => $this->student_id,
      'user_id' => $this->user_id,
      'school_code' => $this->school_code,
      'lrn' => $this->lrn,
      'first_name' => $this->first_name,
      'middle_name' => $this->middle_name,
      'last_name' => $this->last_name,
      'suffix' => $this->suffix,
      'full_name' => $this->full_name,
      'formatted_name' => $this->formatted_name,
      'nickname' => $this->nickname,
      'present_address' => $this->present_address,
      'permanent_address' => $this->permanent_address,
      'profile_img' => $this->profile_img,
      'registration_type' => $this->registration_type,
      'registration_status' => $this->registration_status,
      'created_at' => $this->created_at,
      'updated_at' => $this->updated_at,
    ];
  }
}