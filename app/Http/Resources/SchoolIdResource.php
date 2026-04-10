<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SchoolIdResource extends JsonResource
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
      'school_name' => $this->school_name,
      'school_email' => $this->school_email,
      'school_logo' => $this->school_logo,
    ];
  }
}