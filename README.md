# The Hub for Discovering Recycling Centers (TBD)

[YoungWonks](https://youngwonks.com) Open Source Project Summer 2022

Our project, **NAME**, taking place over the summer of 2022, second iteration of our open source initiative built by YoungWonks students to put their coding skills to work towards benefitting the community.

We, at YoungWonks, always believe in contributing towards a good cause in society. The coding skills of our students put us in a place where they can contribute in a way that has a social impact. It is with this in mind, that the students of YoungWonks have decided to engage in a socially beneficial open source coding real-world production level project.

## Clone the code repository

```bash
git clone https://github.com/YoungWonks/ywsos2022.git
cd ywsos2022
```

## Prerequisites

Backend:

- [Python > 3.8](https://python.org) _(NOTE: MacOS and Linux users should use the `python3` command, while Windows users should use `python`)_

Frontend:

- [NodeJS > 16.1](https://nodejs.org)

Mobile:

- [Flutter > 3.4](https://flutter.dev)
- [Android Studio](https://docs.flutter.dev/get-started/install/macos#android-setup) for Android development on Windows, MacOS, or Linux OR [Xcode](https://docs.flutter.dev/get-started/install/macos#ios-setup) for iOS development on MacOS

## Setting up Environment Variables (TODO)

## Setting up the Web Frontend (Client Folder)

```bash
cd client
npm install
npm run dev
```

Navigate to the URL displayed in the terminal in your web browser of choice.

## Setting up the Mobile Frontend (Mobile Folder)

Make sure to run `flutter doctor` and fix any issues with the SDK installation. Then, launch your emulator from either Android Studio or Xcode.

```bash
cd mobile
flutter pub get
flutter run lib/main.dart
```

## Setting up the Server Backend (Server Folder)

WINDOWS:

```bash
python -m venv server/venv
.\server\venv\Scripts\activate
pip install -r server/requirements.txt
python server/main.py
```

MAC/LINUX:

```bash
python3 -m venv server/venv
source server/venv/bin/activate
pip3 install -r server/requirements.txt
python3 server/main.py
```

Navigate to the URL displayed in the terminal in your web browser of choice.

_NOTE: When testing locally, the backend server should be running alongside the frontend platform being worked on._
