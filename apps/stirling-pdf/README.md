# Stirling-PDF

Stirling-PDF is a robust, local web-based PDF manipulation tool. It allows you to merge, split, compress, edit, convert, and sign PDF files while maintaining complete privacy, as no data is sent to third-party APIs.

## Features
- **PDF Manipulation**: Merge, split, rotate, crop, compress, sign, and convert PDF documents.
- **OCR Support**: Preconfigured with OCR capabilities using English language packs (`en_GB`).
- **Security & Privacy**: Login security enabled (`SECURITY_ENABLELOGIN: "true"`) with telemetry/analytics disabled.

## Ports & Configuration
- **Port**: `STIRLING_PDF_WEB_UI_PORT` (typically 8080).
- **Environment Variables**:
  - `APP_PUID`/`APP_PGID`: Container ownership parameters.
  - `HOST_TZ`: Host timezone configuration.
  - `SECURITY_ENABLELOGIN`: Enables UI-based user authentication.
- **Directory Mounts**:
  - `/usr/share/tessdata` — Directory containing Tesseract OCR language datasets.
  - `/configs` — Application configuration database.
  - `/logs` — Server application logs.
  - `/pipeline` — Automated PDF ingestion/processing pipeline path.
