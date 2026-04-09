<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>SchoolMANAGER - Student Login Credentials</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      line-height: 1.6;
      color: #333;
      background: #f5f5f5;
      margin: 0;
      padding: 0;
    }

    .container {
      max-width: 600px;
      margin: 20px auto;
      background: #fff;
      border-radius: 8px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .header {
      background: #2563eb;
      color: white;
      padding: 30px;
      text-align: center;
    }

    .header h1 {
      margin: 0;
      font-size: 24px;
    }

    .content {
      padding: 30px;
    }

    .credentials-box {
      background: #f8fafc;
      border: 1px solid #e2e8f0;
      border-radius: 8px;
      padding: 20px;
      margin: 20px 0;
    }

    .credential-label {
      font-weight: bold;
      color: #64748b;
      font-size: 14px;
      text-transform: uppercase;
    }

    .credential-value {
      font-size: 18px;
      color: #1e293b;
      font-family: monospace;
      background: white;
      padding: 8px 12px;
      border-radius: 4px;
      border: 1px solid #cbd5e1;
      margin-top: 5px;
    }

    .button {
      display: inline-block;
      background: #2563eb;
      color: white;
      text-decoration: none;
      padding: 12px 30px;
      border-radius: 6px;
      font-weight: bold;
      margin: 20px 0;
    }

    .footer {
      background: #f8fafc;
      padding: 20px;
      text-align: center;
      font-size: 12px;
      color: #64748b;
      border-top: 1px solid #e2e8f0;
    }
  </style>
</head>

<body>
  <div class="container">
    <div class="header">
      <h1>SchoolMANAGER</h1>
      <p style="margin: 10px 0 0; opacity: 0.9;">Student Login Credentials</p>
    </div>
    <div class="content">
      <p>Dear Parent/Guardian,</p>
      <p>Your child's student ID registration has been approved. Below are the login credentials for accessing the
        SchoolMANAGER system.</p>
      <div style="margin: 20px 0;">
        <p><strong>Student Name:</strong> {{ $studentName }}</p>
        <p><strong>Student ID:</strong> {{ $studentId }}</p>
        <p><strong>School Code:</strong> {{ $schoolCode }}</p>
      </div>
      <div class="credentials-box">
        <div style="margin-bottom: 15px;">
          <div class="credential-label">Username</div>
          <div class="credential-value">{{ $username }}</div>
        </div>
        <div>
          <div class="credential-label">Password</div>
          <div class="credential-value">{{ $password }}</div>
        </div>
      </div>
      <p>Please keep these credentials safe.</p>
      <div style="text-align: center;">
        <a href="{{ $loginUrl }}" class="button">Login to SchoolMANAGER</a>
      </div>
      <p style="margin-top: 20px;"><strong>Important:</strong> For security reasons, we recommend changing your password
        after your first login.</p>
    </div>
    <div class="footer">
      <p>This is an automated message from SchoolMANAGER. Please do not reply to this email.</p>
      <p>&copy; {{ date('Y') }} SchoolMANAGER. All rights reserved.</p>
    </div>
  </div>
</body>

</html>