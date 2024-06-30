# Mini Gchat

## Overview

Mini Gchat is a simple streamlined group chat application built with Flutter. It enables multiple users to connect and communicate in a group chat setting. This application leverages Firebase Authentication for user signup and login, and Firebase Cloud Firestore for storing and backing up messages. The Hero widget is utilized to create smooth animations within the app.

## Features

- **Group Chat**: Enables multiple users to connect and chat in real-time.
- **Firebase Authentication**: Provides secure signup and login functionalities.
- **Message Backup**: Stores all messages in Firebase Cloud Firestore for backup.
- **Smooth Animations**: Implements the Hero widget for seamless transitions and animations.

## Installation

Follow the steps below to set up Mini Gchat:

1. **Clone the Repository**:
    ```bash
    git clone https://github.com/yourusername/mini_gchat.git
    cd mini_gchat
    ```

2. **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3. **Set Up Firebase**:
    - Navigate to the [Firebase Console](https://console.firebase.google.com/).
    - Create a new project or select an existing project.
    - Add an Android/iOS app to your Firebase project and download the `google-services.json` (for Android) or `GoogleService-Info.plist` (for iOS).
    - Place the downloaded file in the appropriate directory (`android/app` for Android, `ios/Runner` for iOS).
    - Enable Firebase Authentication and Firestore in your Firebase project.

4. **Run the Application**:
    ```bash
    flutter run
    ```

## Usage

1. **Signup/Login**: Users need to sign up or log in using their email and password.
2. **Chat**: Once logged in, users can join the group chat and start messaging.

## Dependencies

- animated_text_kit
- firebase_core
- firebase_auth
- cloud_firestore: ^5.0.2
- modal_progress_hud_nsn

## Contact

For questions or feedback, please email omamasajid345@gmail.com

---

Thank you for using Mini Gchat!

