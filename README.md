# 📱 Flutter User App

A simple Flutter application demonstrating **API integration, pagination, search,Pull to refresh, caching, and state management using BLoC**.

---

## 🚀 Features

* ✅ Fetch users from API
* ✅ Infinite scrolling (pagination)
* ✅ Search users by name
* ✅ Pull to Refresh included
* ✅ User detail screen
* ✅ Error handling with retry
* ✅ Clean architecture (Data, Domain, Presentation layers)
* ✅ BLoC state management

---

## 📂 Project Structure

```
lib/
│
├── core/
│   ├── network/        # API service
│   └── utils/          # Cache helper (SharedPreferences)
│
├── features/
│   └── users/
│       ├── data/
│       │   ├── model/  # UserModel
│       │   └── repositories/
│       │
│       ├── domain/
│       │   ├── entities/
│       │   └── repositories/
│       │
│       └── presentation/
│           ├── bloc/   # UserBloc
│           └── pages/  # UI screens
│
├── injection_container.dart
└── main.dart
```

---

## 🛠️ Tech Stack

* Flutter
* Dart
* BLoC (flutter_bloc)
* HTTP package
* SharedPreferences (caching)
* Clean Architecture

---

## 📡 API Used

```
https://reqres.in/api/users
```

---

## ▶️ Getting Started

### 1. Clone the repository

```
git clone https://github.com/Prajakta2212/userdata.git
cd user_app
```

---

### 2. Install dependencies

```
flutter pub get
```

---

### 3. Run the app

```
flutter run(can run on chrome and as well can create apk of it)
```

---

### 4. Build APK

```
flutter build apk
```

---

## 🔍 Key Functionalities

### 🔹 Pagination

* Loads users page by page
* duplicate calls(for showing pagination)
* Stops when no more data

---

### 🔹 Search

* Filters users locally
* Removes duplicate results
* Instant UI update

---

### 🔹 Detail_screen

* shows Detail of the use like (ID, Name, E-mail)
* Bcak Button to go to previous screen and even in the appbar same
* Instant UI update

---

### 🔹 Caching

* Stores API response locally
* Displays cached data when offline

---

## ⚠️ Known Issues

* Avatar images from API may not load on Flutter Web due to CORS restrictions
* Fallback image is used to handle this

---

## 💡 Improvements (Future Scope)

* Add shimmer loading effect
* Can add a Social Media site of the user on click can go to that
* Add unit & widget tests

---

## 🧠 Architecture

This project follows **Clean Architecture**:

* **Data Layer** → API & Models
* **Domain Layer** → Business logic
* **Presentation Layer** → UI & BLoC

---

## 👩‍💻 Author

**Prajakta Narayankar**

---

## ⭐ If you like this project

Give it a ⭐ on GitHub!

---
