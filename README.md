GitHub Repository:
https://github.com/Sadhana-4474/gk-lites

## GK Lite – MCQ Generator

### Setup
1. Clone repo
2. Run `flutter pub get`
3. Create `.env` file and add Gemini API key
4. Run app

### API Key Security
API key is stored in `.env`. Client-side exposure risk exists.
In production, a backend proxy should be used.

### Known Limitations
- Simple text parsing
- No backend
- Free tier API limit

### Tech Stack
Flutter, Gemini Flash API, REST

## AI Integration (Gemini API)

This project integrates Google Gemini API for generating MCQs from notes.

Due to billing restrictions on free-tier accounts, the application currently
uses a mock response for demonstration purposes.

The real API integration is fully implemented and can be enabled by setting:
useRealAPI = true in gemini_service.dart
