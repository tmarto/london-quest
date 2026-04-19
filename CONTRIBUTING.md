# Contributing

## Prerequisites

- Flutter 3.29+ — [install](https://docs.flutter.dev/get-started/install)
- Android SDK (for Android builds)
- Xcode 15+ (for iOS builds, macOS only)

## Setup

```bash
git clone https://github.com/tmarto/london-quest.git
cd london-quest
flutter pub get
flutter test
```

## Workflow

1. Fork the repo
2. Create a branch: `git checkout -b feat/my-change`
3. Make changes
4. Ensure CI passes locally:
   ```bash
   flutter analyze --fatal-warnings
   flutter test --coverage
   ```
5. Open a pull request against `main`

## Branch naming

| Prefix | Use |
|--------|-----|
| `feat/` | New feature |
| `fix/` | Bug fix |
| `chore/` | Tooling, deps, CI |
| `docs/` | Documentation only |

## Commit style

Follow [Conventional Commits](https://www.conventionalcommits.org):

```
feat: add result screen animation
fix: timer not cancelled on dispose
chore(deps): bump shared_preferences to 2.3.0
```

## Testing

- Unit + widget tests live in `test/`
- Integration (E2E) tests live in `integration_test/`
- Coverage threshold: **60%** — PRs that drop below will fail CI

## Firebase / Crashlytics

The repo ships a placeholder `lib/firebase_options.dart`.
To connect to a real Firebase project:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

Do **not** commit real `google-services.json` files.
