# Pest Shield Ghana — Group 26B

A Flutter mobile app with a Python FastAPI backend for pest detection and analysis using computer vision.

## Project Structure

```
pest_shield_app/
├── frontend/          # Flutter mobile app
│   ├── lib/          # Flutter Dart code
│   ├── android/      # Android native configs
│   ├── ios/          # iOS native configs
│   ├── pubspec.yaml  # Flutter dependencies
│   └── assets/       # App images and resources
├── backend/          # Python FastAPI server
│   ├── main.py       # FastAPI app with /analyze-pest endpoint
│   ├── requirements.txt
│   └── .env.example  # Environment variables template
├── .gitignore
└── README.md
```

## Quick Start

### Backend Setup

1. **Install Python dependencies:**
   ```bash
   cd backend
   pip install -r requirements.txt
   ```

2. **Configure API Key:**
   ```bash
   cp .env.example .env
   # Edit .env and add your OPENROUTER_API_KEY
   ```

3. **Run the API:**
   ```bash
   uvicorn main:app --reload --host 0.0.0.0 --port 8000
   ```
   The API will be available at `http://localhost:8000`

### Frontend Setup

1. **Install Flutter & Dependencies:**
   ```bash
   cd frontend
   flutter pub get
   ```

2. **Configure API Base URL (Optional):**
   By default connects to `https://api-pest.onrender.com`. 
   For local development:
   ```bash
   flutter run --dart-define=API_BASE_URL=http://your-machine-ip:8000
   ```

3. **Run the App:**
   ```bash
   # For Android
   flutter run

   # For iOS
   flutter run -d iphone

   # For Web
   flutter run -d chrome
   ```

## Features

- 📸 **Capture/Upload** pest images from camera or gallery
- 🤖 **AI Analysis** using OpenRouter vision API
- 📊 **Pest Detection** with confidence scores
- 💡 **Smart Suggestions** for pest management
- 🌍 **Multi-device** support (Android, iOS, Web)

## API Endpoints

### `POST /analyze-pest`

Analyzes an uploaded image and returns pest information.

**Request:**
- `file` (multipart): Image file (JPEG/PNG)

**Response:**
```json
{
  "topLabel": "Armyworm",
  "confidence": 0.95,
  "topK": [
    {"label": "Armyworm", "score": 0.95},
    {"label": "Cutworm", "score": 0.04}
  ],
  "analysis": "This is a dangerous pest affecting crops...",
  "suggestions": "Apply neem oil or..." 
}
```

## Environment Variables

See `backend/.env.example` for required variables:

| Variable | Required | Description |
|----------|----------|-------------|
| `OPENROUTER_API_KEY` | Yes | API key from OpenRouter |
| `OPENROUTER_BASE_URL` | No | API endpoint (default: openrouter.ai) |
| `PEST_VISION_MODEL` | No | Vision model (default: openai/gpt-4o-mini) |

## Deployment

The app is configured for deployment via Render using `render.yaml`. See [RENDER_DEPLOY.md](RENDER_DEPLOY.md) for details.

## Development

- **Flutter Version:** ^3.10.4
- **Python Version:** ^3.9
- **Key Dependencies:**
  - Frontend: `image_picker`, `google_fonts`, `http`
  - Backend: `fastapi`, `uvicorn`, `openai`, `python-dotenv`

## Troubleshooting

**Image upload fails:**
- Ensure API is running and accessible
- Check `API_BASE_URL` matches backend server
- Verify image matches MIME type (JPEG/PNG)

**API shows "Expected an image file":**
- FastAPI validates `Content-Type` header
- Use multipart form data with correct MIME type

**Missing model error:**
- Set `OPENROUTER_API_KEY` in `.env`
- Verify API key has access to vision models

## Contributors

Group 26B - Pest Shield Ghana Project

SAGOE Wiredu Robert

KYEREMEH Kuruwa Henrietta 

AGYEMANG Kelvin  

BILLA John Moses 

ADJEI Tutu Mark

## License
Copyright@2026

Private project — do not distribute without permission.
