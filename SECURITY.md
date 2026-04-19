# Security Policy

## Supported Versions

| Version | Supported |
|---------|-----------|
| latest `main` | ✅ |
| older releases | ❌ |

## Reporting a Vulnerability

**Do not open a public GitHub issue for security vulnerabilities.**

Report vulnerabilities privately by emailing the maintainer or using
[GitHub's private vulnerability reporting](https://github.com/tmarto/london-quest/security/advisories/new).

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

You will receive a response within **72 hours**.

## Scope

This app stores data locally only (SharedPreferences). It has no backend, no user accounts, and no network calls except loading attraction images from Wikimedia Commons.

Key areas to consider:
- Local data exposure on rooted devices
- Third-party dependencies (monitored via Dependabot)
- Firebase Crashlytics data collection (opt-in, requires `flutterfire configure`)
