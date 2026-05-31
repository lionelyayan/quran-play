# Changelog

All notable changes to **Quran Play** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Added
- _Upcoming features go here_

---

## [1.0.0] - 2025-05-31

### Added
- 📖 Browse all 114 Surahs with name, translation, and verse count
- 🔍 Real-time search by Surah name or translation
- 🎵 Stream individual ayah audio with one tap
- ⏭️ Playlist mode — auto-advance through all ayahs in a Surah
- ⏩ Seekable progress bar with elapsed / total time display
- ⏪ Previous / Next controls for playlist navigation
- 🔴 Active ayah highlight — Arabic text turns red while playing
- 🌙 Full dark mode support with semantic color system
- 💤 Shimmer loading states for Surah list and Ayah list
- 📱 Responsive layout with flutter_screenutil
- 🔊 Audio continues playing when navigating between pages
- 🔁 Fixed auto-advance bug (tracks were skipping every other ayah)

### Tech Stack
- Flutter 3.x / Dart 3.x
- GetX 4.x — state management & routing
- Dio 5.x — HTTP client with interceptors
- just_audio 0.9.x — audio streaming engine
- AlQuran Cloud API — Quran data & audio CDN

---

[Unreleased]: https://github.com/lionelyayan/quran-play/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/lionelyayan/quran-play/releases/tag/v1.0.0
