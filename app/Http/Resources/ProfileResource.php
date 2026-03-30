<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ProfileResource extends JsonResource
{
  /**
   * Transform the resource into an array.
   *
   * @return array<string, mixed>
   */
  public function toArray(Request $request): array
  {
    $data = [
      'id' => $this->id,
      'role' => $this->role,
      'fullname' => $this->fullname,
      'created_at' => $this->created_at,
      'updated_at' => $this->updated_at,
    ];

    // Conditionally add user data when relationship is loaded
    if ($this->whenLoaded('user')) {
      $data['user'] = new UserResource($this->user);
    }

    return $data;
  }
}