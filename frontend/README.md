# Pest Shield Mobile App - Frontend

Flutter application for pest detection and analysis using mobile camera.

## Setup

1. **Install Flutter:**
   - Download from [flutter.dev](https://flutter.dev)
   - Run `flutter doctor` to verify installation

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure API endpoint (Optional):**
   
   By default connects to `https://api-pest.onrender.com`.
   
   For local development:
   ```bash
   flutter run --dart-define=API_BASE_URL=http://192.168.x.x:8000
   ```
   Replace `192.168.x.x` with your machine's IP address.

## Running the App

```bash
# Debug mode  
flutter run

# Release build (Android)
flutter build apk --release

# Release build (iOS)
flutter build ipa --release

# Web
flutter run -d chrome
```

## Project Structure

```
lib/
├── main.dart              # App entry point
├── screens/
│   ├── home_screen.dart       # Camera capture & upload
│   ├── profile_screen.dart    # User profile
│   ├── settings_screen.dart   # App settings
│   ├── shell_screen.dart      # Navigation shell
│   └── tips_screen.dart       # Pest tips
├── services/
│   └── pest_classifier.dart   # API integration
└── theme/
    └── app_theme.dart         # UI theming
```

## Features

- 📷 **Camera Integration**: Capture pest images in real-time
- 📤 **Image Upload**: Send to backend for analysis
- 🤖 **AI Results**: Receive pest identification, confidence, and recommendations
- 💾 **Image Gallery**: Browse device gallery and upload
- ⚙️ **Settings**: Configure API endpoint
- 📚 **Tips**: Educational pest management information

## Dependencies

- `image_picker: ^1.1.2` - Camera and gallery access
- `google_fonts: ^6.2.1` - Typography
- `image: ^4.3.0` - Image processing
- `http: ^1.2.2` - HTTP requests
- `http_parser` - Multipart form handling

## API Integration

The app communicates with the backend `/analyze-pest` endpoint:

```dart
// Example from pest_classifier.dart
POST /analyze-pest
Content-Type: multipart/form-data
file: <image bytes>
```

See [services/pest_classifier.dart](lib/services/pest_classifier.dart) for implementation details.

## Environment Setup

For local API development:

1. Start backend server:
   ```bash
   cd ../backend
   python -m venv venv
   source venv/bin/activate
   pip install -r requirements.txt
   uvicorn main:app --reload --host 0.0.0.0 --port 8000
   ```

2. Get your machine IP:
   ```bash
   # Windows
   ipconfig
   
   # Mac/Linux
   ifconfig
   ```

3. Run Flutter with API override:
   ```bash
   flutter run --dart-define=API_BASE_URL=http://YOUR_IP:8000
   ```

## Troubleshooting

**"Cannot connect to API":**
- Ensure backend is running
- Check `API_BASE_URL` matches actual server address
- Verify device/emulator has network access

**"Expected an image file" error:**
- Ensure image is JPEG or PNG
- Check file size isn't too large (>10MB)
- Verify `Content-Type` header is set correctly

**Camera permission denied:**
- Grant camera permissions in app settings
- Re-install app if permissions were denied initially

**Image upload timeout:**
- Check network connection
- Try smaller image file
- Increase Flutter HTTP timeout (modify `pest_classifier.dart`)

## Building Release

**Android:**
```bash
flutter build apk --release
# Output: build/app/outputs/apk/release/app-release.apk
```

**iOS:**
```bash
flutter build ipa --release
# Output: build/ios/ipa/
```

## Version Info

- Flutter: ^3.10.4
- Dart: ^3.10.4
- Android SDK: 21+
- iOS: 11+

## Contributors

Group 26B - Pest Shield Ghana Project
