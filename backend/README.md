# Pest Shield API Backend

FastAPI server for pest image analysis using OpenRouter vision models.

## Setup

1. **Create virtual environment:**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```

3. **Configure API key:**
   ```bash
   cp .env.example .env
   # Edit .env and add OPENROUTER_API_KEY
   ```

## Running the Server

```bash
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

Visit `http://localhost:8000/docs` for interactive API documentation.

## Endpoints

### Health Check
```
GET /health
```
Returns `{"status": "ok"}`

### Pest Analysis
```
POST /analyze-pest
Content-Type: multipart/form-data

file: <binary image file>
```

**Response:**
```json
{
  "topLabel": "Pest Name",
  "confidence": 0.95,
  "topK": [
    {"label": "Pest Name", "score": 0.95},
    {"label": "Alternative Pest", "score": 0.04}
  ],
  "analysis": "Detailed pest analysis text...",
  "suggestions": "Management recommendations..."
}
```

## Environment Variables

- `OPENROUTER_API_KEY`: Required. API key from [OpenRouter](https://openrouter.ai)
- `OPENROUTER_BASE_URL`: Optional. Defaults to `https://openrouter.ai/api/v1`
- `PEST_VISION_MODEL`: Optional. Defaults to `openai/gpt-4o-mini`
- `CHRISKEY`: Alternative API key (falls back to OPENROUTER_API_KEY)

## Requirements

- Python 3.9+
- FastAPI 0.115.0+
- Uvicorn 0.32.0+
- OpenAI SDK 1.0.0+
- python-dotenv 1.0.0+

## CORS Configuration

The API allows requests from all origins (`allow_origins=["*"]`). 
Modify `CORSMiddleware` in `main.py` for production security.

## Common Issues

**503 Service Unavailable - Missing API Key:**
- Ensure `OPENROUTER_API_KEY` is set in `.env`

**Expected an image file error:**
- Verify multipart request includes `Content-Type: image/jpeg` or `image/png`
- The `http` package from Dart defaults to `application/octet-stream`; ensure correct MIME type is set

**Model not found:**
- Verify API key has access to the specified vision model
- Default: `openai/gpt-4o-mini` (check OpenRouter for available models)

## Deployment

Deploy to Render or any server supporting Python/FastAPI.
See `../render.yaml` for deployment configuration.
