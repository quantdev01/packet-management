# Packet management
Package Management System with Firebase (Flutter Desktop & Android)

## Description
This is a desktop and Android app developed in Flutter to streamline package management and retrieval using Firebase Firestore as a backend. The application enables users to register clients sending packages, document package details, and facilitate package retrieval at another location. Admins can monitor package statuses, making it easier to manage and verify client package records from any device.

## Features
Client Registration: Register client names and package details.
Package Tracking: View, update, and track package statuses (pending, retrieved).
Multi-Platform Access: Flutter desktop app for on-site use, with an Android version for remote monitoring by admins.
Firestore Integration: Secure and reliable data storage using Firebase Firestore.
## Architecture and Technologies
Flutter: For cross-platform development (desktop and Android).
Firebase Firestore: To store and manage client and package data.
Firebase Authentication: Optional, for user-based access control if admins need secure login.
## Installation and Setup
Prerequisites: Flutter SDK, Firebase account, Firestore setup.
## Clone the Repository:
bash
```
git clone https://github.com/yourusername/PackageManagementApp.git
```
Set Up Firebase:
Configure Firebase Firestore in the Firebase console.
Download google-services.json for Android and add it to your project.
Run the App:
bash
Copy code
```
flutter run
```
## Usage
Register a Client: On the desktop app, fill out client and package details, which are stored in Firestore.
Retrieve a Package: Search for a client’s name in the app to update the status as "retrieved."
Admin Access: Use the Android app to view the status of all packages and filter by retrieval status.
