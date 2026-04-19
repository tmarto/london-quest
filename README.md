# 🇬🇧 London Quest

Quiz app for the Marto family London trip — May 2026.

Ines and Pedro answer questions about each landmark before visiting it.
Ana uses teach mode to prepare the explanations.

---

## Screenshots

<p align="center">
  <img src="docs/screenshots/player_select.png" width="18%" alt="Player Select" />
  <img src="docs/screenshots/home.png" width="18%" alt="Home" />
  <img src="docs/screenshots/day.png" width="18%" alt="Day Screen" />
  <img src="docs/screenshots/quiz.png" width="18%" alt="Quiz" />
  <img src="docs/screenshots/teach.png" width="18%" alt="Teach Mode" />
</p>

---

## Players

| Player | Mode |
|--------|------|
| 👧 Inês | Quiz |
| 👦 Pedro | Quiz |
| 👩 Ana | Teach (study cards with answers revealed) |

---

## Features

- **4 days × 13 attractions × 10 questions** = 130 total points
- Per-player best score saved locally (SharedPreferences)
- Retake any quiz — only improves score, never lowers it
- 15-second timer per question
- Fun fact revealed after each answer
- Attraction photo loaded from Wikimedia Commons
- Ana's teach mode: all questions with correct answers + explanations

---

## Trip Itinerary

| Day | Date | Attractions |
|-----|------|-------------|
| 1 | 29 Apr | Westminster & Big Ben, Trafalgar Square & Piccadilly |
| 2 | 30 Apr | Natural History Museum, Hyde Park, Science Museum |
| 3 | 1 May | British Museum, Madame Tussauds, Buckingham Palace |
| 4 | 2 May | Tower of London, Tower Bridge, HMS Belfast, St Paul's, Millennium Bridge |

---

## Tech Stack

- Flutter (Dart) — Android
- `shared_preferences` — local score persistence
- Wikimedia Commons — attraction images
- GitHub Actions — CI: test → build APK on every push

---

## CI/CD

Every push to `main`:
1. `flutter test`
2. On success → `flutter build apk --release`
3. APK uploaded as artifact (30-day retention)

---

## Build locally

\`\`\`bash
flutter pub get
flutter run           # debug
flutter build apk --release
\`\`\`

APK output: `build/app/outputs/flutter-apk/app-release.apk`
