# Aurum Bank — Flutter Fintech (Material 3 + Mock API)

A production-quality, **cross-platform** fintech app built from a single Flutter codebase that
runs on **iOS, Android, Web, macOS, Windows and Linux**. It is strictly **Material 3 (Material
You)** with full light/dark themes and platform **dynamic color**, adapts from phone → tablet →
desktop, and consumes a **mock REST API** through a proper Dio networking + repository layer.
There is **no hardcoded business data in the UI** — every screen loads from the API and has real
loading (shimmer), empty and error states.

## Tech stack

| Concern | Choice |
| --- | --- |
| State management | Riverpod 3 (`flutter_riverpod`, manual `Notifier`/`AsyncNotifier`) |
| Routing | `go_router` (deep links, web URLs, adaptive `StatefulShellRoute`) |
| Networking | `dio` (auth, logging & latency/chaos interceptors) |
| Models | `freezed` + `json_serializable` (immutable, codegen) |
| Charts | `fl_chart` |
| Storage | `flutter_secure_storage` (token) + `shared_preferences` (theme/locale) |
| Adaptivity | `LayoutBuilder` breakpoints + `dynamic_color` |
| Misc | `intl`, `cached_network_image`, `local_auth` (optional biometric unlock) |

## Architecture

Feature-first clean architecture. See [`docs/ARCHITECTURE.md`](docs/ARCHITECTURE.md) for the full
contract (models, providers, shared widgets).

```
lib/
  core/        env, theme + design tokens, router, dio client + interceptors,
               storage, typed failures, formatters, providers
  data/        models (freezed), repositories (Dio-backed)
  features/    auth, onboarding, dashboard, accounts, transactions, transfer,
               cards, insights, notifications, settings, shell
               (each: application/ controllers + presentation/ screens)
  shared/      reusable widgets (async/loading/error/empty, cards, tiles, skeletons)
  app.dart     MaterialApp.router + dynamic color + theming
  main.dart    bootstraps SharedPreferences + ProviderScope
mock-api/      json-server: db.json, routes.json, server.js
```

Repositories expose domain (freezed) models; Riverpod controllers hold UI state and call
repositories. API/JSON shapes never leak into the UI.

## Screens & flows

Splash → Onboarding → Auth (login / register / forgot password + optional biometric unlock) →
Dashboard (balance, card carousel, quick actions, recent activity) → Accounts & Cards (card
detail, freeze/unfreeze, add card) → Transactions (paginated, searchable, filterable list +
detail, two-pane on desktop) → Transfer (beneficiary → amount → review → confirm → success) →
Insights (donut, monthly trend, budgets) → Notifications (read/unread) → Settings (theme,
language, security, logout).

## Adaptive layout

| Width | Navigation | Layout |
| --- | --- | --- |
| `< 600dp` (phone) | bottom `NavigationBar` | single column |
| `600–840dp` (tablet) | `NavigationRail` | single column, larger padding |
| `> 840dp` (desktop/web) | extended `NavigationRail` | multi-pane (e.g. transactions list + detail) |

---

## 1. Prerequisites

- Flutter **3.44+** (stable), Dart 3.12+
- Node.js 18+ (for the mock API)

## 2. Run the mock API

```bash
cd mock-api
npm install
npm run start:custom   # full server: /auth/login, /auth/register, /transfers, /auth/me
# or: npm start        # plain json-server CRUD only
```

The API listens on `http://localhost:3000`. Endpoints:

```
POST  /auth/login        -> { token, user }
POST  /auth/register     -> { token, user }
GET   /auth/me           -> user
GET   /accounts
GET   /cards     GET /cards/:id     PATCH /cards/:id   (toggle "frozen")
GET   /transactions?accountId=&category=&from=&to=&q=&_page=&_limit=
GET   /transactions/:id
GET   /beneficiaries
POST  /transfers
GET   /insights/spending
GET   /notifications     PATCH /notifications/:id   (toggle "read")
```

Seed data: 1 user, 3 accounts, 3 cards, 40 transactions, 5 beneficiaries, 6 notifications,
and a spending-insights object.

## 3. Run the app

```bash
flutter pub get
dart run build_runner build      # generates *.freezed.dart / *.g.dart (first run / after model edits)
flutter run                      # pick a device, or use the flags below
```

### Per platform (no code changes required)

```bash
flutter run -d chrome            # Web
flutter run -d windows           # Windows
flutter run -d macos             # macOS
flutter run -d linux             # Linux
flutter run -d <android-device>  # Android
flutter run -d <ios-device>      # iOS (run `pod install` in ios/ on first build)
```

## 4. Switching the API base URL

`baseUrl` defaults to `http://localhost:3000` and is configurable at run time with no code
changes via `--dart-define`:

```bash
flutter run --dart-define=API_BASE_URL=http://10.0.2.2:3000     # Android emulator -> host
flutter run --dart-define=API_BASE_URL=http://192.168.1.20:3000 # physical device on LAN
```

The Dio chaos interceptor (300–800 ms latency + occasional GET failures, so loading/error states
are real) can be turned off:

```bash
flutter run --dart-define=SIMULATE_NETWORK=false
```

> **Android note:** the emulator reaches your machine at `10.0.2.2`, not `localhost`. For physical
> devices use your machine's LAN IP and ensure both are on the same network.

## 5. Quality checks

```bash
flutter analyze     # clean — no issues
flutter test        # unit + widget + repository (mocked Dio) tests
dart format .
```

## Platform notes

- **Windows desktop:** building with plugins requires symlink support — enable *Developer Mode*
  (`start ms-settings:developers`) once.
- **local_auth:** biometric unlock is optional and self-guarding — on platforms/devices without
  biometrics the button simply reports it is unavailable, so the app still builds and runs
  everywhere with no code changes.

## Demo credentials

Any email containing `@` and a password of 4+ characters works (the mock API accepts all logins).
The login screen is pre-filled with `alex@demo.app`.
