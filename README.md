<div align="center">
  <img src="assets/icons/quran.png" alt="Quran Play Logo" width="100" />
  <h1>Quran Play</h1>
  <p><strong>A beautifully crafted Flutter app to explore and listen to the Holy Quran.</strong></p>

  <p>
    <img src="https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white" />
    <img src="https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white" />
    <img src="https://img.shields.io/badge/GetX-4.x-8B5CF6" />
    <img src="https://img.shields.io/badge/just__audio-0.9.x-EF4444" />
    <img src="https://img.shields.io/badge/License-MIT-green" />
  </p>
</div>

---

## ✨ Features

- 📖 **Browse all 114 Surahs** with name, translation, and verse count
- 🔍 **Search Surahs** by name or translation in real-time
- 🎵 **Stream Quran recitations** per-ayah with one tap
- ⏭️ **Playlist mode** — auto-advance through all ayahs in a Surah
- ⏩ **Seekable progress bar** with time display for each track
- ⏪ **Previous / Next** controls for playlist navigation
- 🔴 **Active ayah highlight** — Arabic text turns red while playing
- 🌙 **Full dark mode** support with semantic color system
- 💤 **Shimmer loading** states for smooth UX
- 📱 **Responsive layout** powered by ScreenUtil

---

## 🛠️ Tech Stack

| Layer | Library |
|---|---|
| Framework | [Flutter](https://flutter.dev) |
| State Management | [GetX](https://pub.dev/packages/get) |
| HTTP Client | [Dio](https://pub.dev/packages/dio) |
| Audio Engine | [just_audio](https://pub.dev/packages/just_audio) |
| Responsive UI | [flutter_screenutil](https://pub.dev/packages/flutter_screenutil) |
| Internationalization | [intl](https://pub.dev/packages/intl) |

---

## 🌐 API

Data is powered by the free [AlQuran Cloud API](https://alquran.cloud/api):

```
Base URL: https://api.alquran.cloud/v1
```

| Endpoint | Description |
|---|---|
| `GET /surah` | Fetch all 114 Surahs |
| `GET /surah/{id}/en.asad` | Fetch ayahs with English translation |

Audio recitation is streamed from the CDN provided by the API response (`audio` field per ayah).

> 📌 No API key required. Free and open for public use.

---

## 🗂️ Project Structure

```
lib/
├── app/
│   ├── app.dart                 # App entry point & MaterialApp setup
│   ├── app_bindings.dart        # GetX dependency injection
│   └── app_constants.dart       # App-wide constants (base URL, etc.)
│
├── controllers/
│   ├── audio_controller.dart    # Audio playback engine (playlist & single)
│   ├── ayah_controller.dart     # Ayah list state management
│   └── surah_controller.dart    # Surah list & search state
│
├── core/
│   ├── network/                 # Dio client, interceptors, exceptions
│   ├── theme/                   # Colors, typography, dimensions, theme
│   └── widgets/                 # Reusable UI components
│       ├── app_card.dart
│       ├── app_no_data.dart
│       ├── app_shimmer.dart
│       ├── app_text.dart
│       ├── app_text_field.dart
│       └── surah_number.dart
│
├── data/
│   ├── models/                  # Surah & Ayah data models
│   └── services/                # API service layer
│
├── routes/
│   ├── app_pages.dart           # Route definitions
│   └── app_routes.dart          # Route name constants
│
├── views/
│   ├── surah_page.dart          # Surah list screen
│   └── ayah_page.dart           # Ayah list + audio player screen
│
└── main.dart
```

---

## 🚀 Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) >= 3.x
- Dart >= 3.x
- Android Studio / VS Code
- An Android or iOS device / emulator

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/your-username/quran-play.git
cd quran-play

# 2. Install dependencies
flutter pub get

# 3. Generate launcher icons
flutter pub run flutter_launcher_icons

# 4. Run the app
flutter run
```

---

## 🎨 Design Credits

This app's visual design was inspired by modern mobile UI trends. Huge thanks to the following resources:

### 🖼️ Icons
Icons used in this app are sourced from **[Flaticon](https://www.flaticon.com/)**.
> Please refer to Flaticon's license when using icons commercially.

### 🎨 Illustrations
Illustrations are sourced from **[unDraw](https://undraw.co/)** — open-source illustrations for any idea.
> unDraw illustrations are free to use without attribution.

### 💡 Design Inspiration
UI design was inspired by beautiful mobile app concepts on **[Dribbble](https://dribbble.com/)**.
> Search "Quran app UI", "Islamic app design", "Audio player Flutter" for references.

---

## 📦 Dependencies

```yaml
dependencies:
  flutter_screenutil: ^5.9.3   # Responsive sizing
  get: ^4.7.3                  # State management & routing
  dio: ^5.9.2                  # HTTP networking
  just_audio: ^0.9.44          # Audio streaming
  intl: ^0.20.2                # Date/number formatting

dev_dependencies:
  flutter_launcher_icons: ^0.14.4
  flutter_lints: ^5.0.0
  build_runner: ^2.4.15
  mockito: ^5.4.6
```

---

## 🙏 Acknowledgements

- **[AlQuran Cloud](https://alquran.cloud/)** — Free Quran API & audio CDN
- **[Flaticon](https://www.flaticon.com/)** — App icons
- **[unDraw](https://undraw.co/)** — SVG illustrations
- **[Dribbble](https://dribbble.com/)** — Design inspiration
- **[Flutter](https://flutter.dev)** & the amazing open-source community


---

<div align="center">
  <p>Made with ❤️ and Flutter</p>
  <p>
    <a href="https://alquran.cloud/">API</a> •
    <a href="https://flaticon.com/">Icons</a> •
    <a href="https://undraw.co/">Illustrations</a> •
    <a href="https://dribbble.com/">Design Inspiration</a>
  </p>
</div>
