<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class UserResource extends JsonResource
{
  /**
   * Transform the resource into an array.
   *
   * @return array<string, mixed>
   */
  public function toArray(Request $request): array
  {
    return [
      'id' => $this->id,
      'school_code' => $this->school_code,
      'school_email' => $this->school_email,
      'student_id' => $this->student_id,
      'mobile_number' => $this->mobile_number,
      'username' => $this->username,
      'account_name' => $this->account_name,
      'role' => $this->user_role,
      'account_status' => $this->account_status,
      'last_successful_login' => $this->last_successful_login,
      'created_at' => $this->created_at,
    ];
  }
}