# StudyMate AI

StudyMate AI is a Flutter app for keeping study plans, deadlines, daily tasks, and focus sessions in one place. It is built to make the next step feel manageable, even when the whole semester does not.

## Screenshots

<table>
  <tr>
    <td align="center" width="50%"><img src="assets/readme/dashboard.jpg" alt="StudyMate AI dashboard showing study overview" width="300"></td>
    <td align="center" width="50%"><img src="assets/readme/pomodoro.jpg" alt="StudyMate AI Pomodoro focus timer" width="300"></td>
  </tr>
  <tr>
    <td align="center"><strong>Daily overview</strong><br>Exams, tasks, focus sessions, and modules in one view.</td>
    <td align="center"><strong>Pomodoro focus</strong><br>A 25-minute sprint, with a reset button for when life happens.</td>
  </tr>
  <tr>
    <td align="center" colspan="2"><img src="assets/readme/splash.jpg" alt="StudyMate AI app launch screen" width="260"><br><strong>StudyMate AI launch screen</strong></td>
  </tr>
</table>

## Feature concept visuals

These original vector mockups visualize the study-planning and exam/task flows described below. They are illustrative concepts, not screenshots of shipped app screens.

<table>
  <tr>
    <td align="center" width="50%"><img src="assets/readme/concept-study-plan.svg" alt="Illustrative StudyMate AI study plan with subject tasks and progress" width="340"></td>
    <td align="center" width="50%"><img src="assets/readme/concept-exams-tasks.svg" alt="Illustrative StudyMate AI exam countdown and daily task list" width="340"></td>
  </tr>
  <tr>
    <td align="center"><strong>Study planning</strong><br>Study sessions and progress at a glance.</td>
    <td align="center"><strong>Exams and tasks</strong><br>Countdowns and small daily wins in one place.</td>
  </tr>
</table>

## Built with

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase">
</p>

## What it can do

- Sign up and log in with Firebase Authentication.
- Track exams and countdowns.
- Generate study plans with the Google Gemini API.
- Organize daily tasks and monitor progress on the dashboard.
- Run Pomodoro focus sessions.
- Manage a personal profile.

## Tech stack

- Flutter and Dart
- Firebase Authentication
- Cloud Firestore
- Google Gemini API

## Run locally

1. Install the Flutter SDK and configure an emulator or connected device.
2. Clone this repository and run `flutter pub get` from the project directory.
3. Add the Firebase configuration files for your own Firebase project and configure the Gemini API key as expected by the app.
4. Run `flutter run`.

The images in **Screenshots** are genuine app captures, lightly trimmed around the device status bar. The feature visuals above are illustrative concepts.
