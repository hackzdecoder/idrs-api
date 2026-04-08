<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Trademark extends Model
{
  use HasFactory;

  protected $connection = 'trademarks';
  protected $table = 'companies';

  protected $fillable = [
    'copyright_name',
    'company_name',
    'publication_date',
  ];

  protected $casts = [
    'publication_date' => 'datetime',
  ];
}