# 📖 Learn Quran

A Flutter mobile application that fetches and displays Quranic chapters (Surahs) and verses (Ayahs) using the [Quran.com API v4](https://api.quran.com/). This app is designed to help users explore and read the Quran easily on their mobile devices.

## ✨ Features

* 📚 Fetch and display a list of Quranic chapters (Surahs)
* 📖 View verses (Ayahs) for each Surah
* 🌐 Uses [Quran.com API v4](https://api.quran.com/api/v4) for accurate and structured Quranic data
* ⚡ Fast and responsive UI built with Flutter

## 📱 Screenshots

| Home Screen (Surah List)                  | Verses Screen (Ayahs)                   |
| ----------------------------------------- | --------------------------------------- |
| ![image](https://github.com/user-attachments/assets/550ea25a-9758-4151-ad88-e6666802fe13) | ![image](https://github.com/user-attachments/assets/3f81ff23-ad4e-429e-b9ee-99aa57cbb140) |


## 🚀 Getting Started

### Prerequisites

* Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
* Android Studio / Xcode for emulator or physical device deployment

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/ariqd/learn_quran.git
   cd learn_quran
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

## 🔌 API Reference

The app uses the [Quran.com API v4](https://api.quran.com/api/v4) to retrieve Quranic data.

* **Chapters (Surahs)**:
  `GET https://api.quran.com/api/v4/chapters`

* **Verses (Ayahs) for a Chapter**:
  `GET https://api.quran.com/api/v4/verses?chapter_number={id}&language=en`

> You can customize query parameters to include translations, tafsir, audio, etc. See full docs at [Quran.com API Docs](https://documenter.getpostman.com/view/10864440/SzYXWKPi).

## 📂 Project Structure

```plaintext
lib/
├── main.dart # App entry point. Displays list of Surahs
├── screens/
│   └── verse_list_page.dart # Displays Ayahs of a selected Surah
└── services/
    └── quran_api_service.dart # Handles HTTP requests to Quran API
```

## 📦 Dependencies

* [`http`](https://pub.dev/packages/http): For HTTP requests
* [`flutter/material.dart`](https://api.flutter.dev/flutter/material/material-library.html): UI components


## 🔜 Coming Soon
I am working on adding more features:

🔊 Audio Playback: Listen to the recitation of verses from various reciters

🌍 Translations: View translations in English and Indonesian

🚀 And more...

Stay tuned for updates and new releases!


## 📄 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.
