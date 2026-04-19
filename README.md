# 🇬🇧 London Quest

Quiz app for the Marto family London trip — May 2026.

Inês and Pedro answer questions about each landmark before visiting it.
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
| 👧 Inês | Quiz (PT or EN) |
| 👦 Pedro | Quiz (PT or EN) |
| 👩 Ana | Teach mode + day score reset |

---

## Features

- **4 days × 13 attractions × 10 questions** — 130 questions total
- **Bilingual quiz** — choose Portuguese (normal points) or English (2× points)
- Answer options shuffled randomly on every question
- Per-player best score saved locally (SharedPreferences)
- Retake any quiz — only improves score, never lowers it
- 15-second timer per question
- Fun fact revealed after each answer
- Attraction photo loaded from Wikimedia Commons
- Ana's teach mode: all questions with correct answers + explanations revealed
- Ana can reset day scores for Pedro or Inês individually

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

- Flutter (Dart) — Android & iOS
- `shared_preferences` — local score persistence
- `package_info_plus` — build version display
- Wikimedia Commons — attraction images
- GitHub Actions — CI/CD: test → build APK + IPA → GitHub Release on tag

---

## CI/CD

Every push to `main`:
1. `flutter analyze` + `flutter test`
2. `flutter build apk --release` (Ubuntu)
3. `flutter build ipa --no-codesign` (macOS)

On `v*` tag push:
- GitHub Release created automatically
- APK + IPA attached to the release

---

## Build locally

```bash
flutter pub get
flutter run           # debug
flutter build apk --release          # Android
flutter build ipa --no-codesign      # iOS (no signing)
```

APK: `build/app/outputs/flutter-apk/app-release.apk`
