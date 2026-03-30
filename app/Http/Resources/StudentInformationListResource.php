<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class StudentInformationListResource extends JsonResource
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
            'user_id' => $this->user_id,
            'school_code' => $this->school_code,
            'student_id' => $this->student_id,
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
            'registration_type' => $this->registration_type,
            'registration_status' => $this->registration_status,
            'profile_img' => $this->profile_img,
            // User data from relationship
            'username' => $this->whenLoaded('user', $this->user?->username),
            'email' => $this->whenLoaded('user', $this->user?->email),
            'account_status' => $this->whenLoaded('user', $this->user?->account_status),
            'email_verified_at' => $this->whenLoaded('user', $this->user?->email_verified_at),
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
