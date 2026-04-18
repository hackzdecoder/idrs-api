<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Welcome to SchoolMANAGER System</title>
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
      overflow: hidden;
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

    .section {
      margin-bottom: 25px;
    }

    .section-title {
      font-weight: 600;
      color: #2563eb;
      margin-bottom: 10px;
      font-size: 16px;
      border-bottom: 1px solid #e2e8f0;
      padding-bottom: 5px;
    }

    .info-table {
      width: 100%;
      border-collapse: collapse;
    }

    .info-table tr {
      margin-bottom: 8px;
    }

    .info-label {
      font-weight: 600;
      width: 280px;
      color: #64748b;
      padding: 6px 0;
      text-align: left;
    }

    .info-colon {
      width: 30px;
      color: #64748b;
      padding: 6px 0;
      text-align: center;
      font-weight: 600;
    }

    .info-value {
      color: #1e293b;
      padding: 6px 0;
      text-align: left;
    }

    .credentials-box {
      background: #f8fafc;
      border: 1px solid #e2e8f0;
      border-radius: 8px;
      padding: 20px;
      margin: 20px 0;
    }

    .credential-item {
      margin-bottom: 15px;
    }

    .credential-label {
      font-weight: bold;
      color: #64748b;
      font-size: 14px;
      text-transform: uppercase;
      letter-spacing: 0.5px;
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

    .links {
      margin: 20px 0;
      padding: 15px;
      background: #f0f9ff;
      border-left: 4px solid #2563eb;
      border-radius: 4px;
    }

    .links a {
      color: #2563eb;
      text-decoration: none;
      font-weight: 600;
    }

    .footer {
      background: #f8fafc;
      padding: 20px;
      font-size: 12px;
      color: #64748b;
      border-top: 1px solid #e2e8f0;
    }

    .disclaimer {
      font-size: 11px;
      color: #94a3b8;
      margin-top: 15px;
      font-style: italic;
    }

    .note {
      font-weight: 600;
      color: #dc2626;
      margin: 15px 0;
    }
  </style>
</head>

<body>
  <div class="container">
    <div class="header">
      <h1>Welcome to SchoolMANAGER System!</h1>
    </div>

    <div class="content">
      <p>This is to confirm that we have received the information that you have submitted for the printing of your
        child's School ID Card. The details we received are as follows:</p>

      <div class="section">
        <div class="section-title">Submitted Information</div>
        <table class="info-table">
          <tr>
            <td class="info-label">Name to Appear on ID Card</td>
            <td class="info-colon">:</td>
            <td class="info-value">{{ $name_to_appear_on_id ?? '—' }}</td>
          </tr>
          <tr>
            <td class="info-label">Residential Address</td>
            <td class="info-colon">:</td>
            <td class="info-value">{{ $residential_address ?? '—' }}</td>
          </tr>
          <tr>
            <td class="info-label">Emergency Contact Person</td>
            <td class="info-colon">:</td>
            <td class="info-value">{{ $emergency_contact_person ?? '—' }}</td>
          </tr>
          <tr>
            <td class="info-label">Emergency Contact Number</td>
            <td class="info-colon">:</td>
            <td class="info-value">{{ $emergency_contact_number ?? '—' }}</td>
          </tr>
        </table>
      </div>

      <p><em>The following information below are subject to the school's final confirmation and approval.</em></p>

      <div class="section">
        <table class="info-table">
          <tr>
            <td class="info-label">Level</td>
            <td class="info-colon">:</td>
            <td class="info-value">{{ $level ?? '—' }}</td>
          </tr>
          <tr>
            <td class="info-label">Section/Course</td>
            <td class="info-colon">:</td>
            <td class="info-value">{{ $section_course ?? '—' }}</td>
          </tr>
          <tr>
            <td class="info-label">LRN</td>
            <td class="info-colon">:</td>
            <td class="info-value">{{ $lrn ?? '—' }}</td>
          </tr>
          <tr>
            <td class="info-label">ESC Number</td>
            <td class="info-colon">:</td>
            <td class="info-value">{{ $esc_number ?? '—' }}</td>
          </tr>
        </table>
      </div>

      <p>Below are the login credentials for accessing the SchoolMANAGER system.</p>

      <div class="credentials-box">
        <div class="credential-item">
          <div class="credential-label">Username</div>
          <div class="credential-value">{{ $username ?? '—' }}</div>
        </div>
        <div class="credential-item">
          <div class="credential-label">Password</div>
          <div class="credential-value">{{ $password ?? '—' }}</div>
        </div>
      </div>

      <p>Please keep your account credentials safe. For security reasons, we recommend changing your password from time
        to time.</p>

      <div class="links">
        <p><strong>You can download the SchoolMANAGER mobile app at:</strong><br>
          <a href="#">WEBSITE LINK</a> and install it on your mobile android device.
        </p>

        <p><strong>You can also access the web app at:</strong><br>
          <a href="https://sms.schoolmanagerph.com">www.sms.schoolmanagerph.com</a>
        </p>
      </div>

      <div class="note">
        ***Please do not reply to this email. This is an automated confirmation that we have received your Student ID
        and Mobile/Web App Registration Details.***
      </div>

      <div class="disclaimer">
        This e-mail transmission is intended only for the addressee and may contain confidential information.
        Confidentiality is not waived if you are not the intended recipient of this e-mail, nor may you use, review,
        disclose, disseminate or copy any information contained in or attached to it. If you received this e-mail in
        error please delete it and any attachments and notify us immediately by reply e-mail. TaparSoft Enterprise does
        not warrant that any attachments are free from viruses or other defects. You assume all liability for any loss,
        damage or other consequences which may arise from opening or using the attachments.
      </div>
    </div>

    <div class="footer">
      <p>&copy; {{ date('Y') }} SchoolMANAGER. All rights reserved.</p>
    </div>
  </div>
</body>

</html>