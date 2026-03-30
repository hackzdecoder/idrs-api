<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class StudentIdInfoResource extends JsonResource
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
      'student_id' => $this->student_id,
      'first_name' => $this->first_name,
      'middle_initial' => $this->middle_initial,
      'surname' => $this->surname,
      'suffix_name' => $this->suffix_name,
      'name_to_appear_on_id' => $this->name_to_appear_on_id,
      'nick_name' => $this->nick_name,
      'birth_date' => $this->birth_date,
      'gender' => $this->gender,
      'residential_address' => $this->residential_address,
      'emergency_contact_person' => $this->emergency_contact_person,
      'emergency_contact_number' => $this->emergency_contact_number,
      'student_picture' => $this->student_picture,
      'level' => $this->level,
      'section_course' => $this->section_course,
      'lrn' => $this->lrn,
      'student_type' => $this->student_type,
      'esc_voucher_recipient' => $this->esc_voucher_recipient,
      'esc_number' => $this->esc_number,
      'parent_first_name' => $this->parent_first_name,
      'parent_surname' => $this->parent_surname,
      'parent_email' => $this->parent_email,
      'id_info_status' => $this->id_info_status,
      'id_info_approval_date' => $this->id_info_approval_date,
      'class_details_status' => $this->class_details_status,
      'class_details_approval_date' => $this->class_details_approval_date,
      'id_print_status' => $this->id_print_status,
      'id_print_date' => $this->id_print_date,
      'id_reprint_status' => $this->id_reprint_status,
      'id_reprint_date' => $this->id_reprint_date,
      'id_reprint_count' => $this->id_reprint_count,
      'sms_app_credentials' => $this->sms_app_credentials,
      'sms_app_created_at' => $this->sms_app_created_at,
      'account_status' => $this->account_status,
      'created_at' => $this->created_at,
    ];
  }
}