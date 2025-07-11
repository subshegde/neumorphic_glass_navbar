# 📦 neumorphic_glass_navbar

A beautiful and modern Flutter bottom navigation bar combining neumorphism and glassmorphism (frosted blur). Designed for elegant UI with depth, softness, and a vibrant translucent look that adapts to both light and dark themes.

## Screenshots


## ✨ Features

- 🧊 Glassmorphic blur with customizable opacity, tint, and vibrancy
- 🌑 Neumorphic highlights and shadows on selected tab
- 🎨 Supports light/dark mode and dynamic theming
- ⚙️ Fully customizable settings via `NeumorphicGlassNavbarSettings`
- 🎯 Selected item scaling animation
- 🔲 Rounded or circular selection design
- 📱 SafeArea + adaptive sizing for all screen types
---

## 🚀 Use Cases
- Modern apps that emphasize aesthetic navigation
- Dashboards, media apps, portfolios, or utility apps needing a visually immersive bottom bar
- UI experiments or design-forward prototypes
- Custom Android UI shells


## Getting Started

To use the `neumorphic_glass_navbar` package in your Flutter project, follow these steps:

### Prerequisites
Ensure you have the following installed on your system:
* [Flutter](https://flutter.dev/docs/get-started/install)
* [Dart](https://dart.dev/get-dart)

### Installation
1. Add the package dependency in your `pubspec.yaml` file:
    ```yaml
    dependencies:
      neumorphic_glass_navbar:
    ```

2. Install the dependencies by running the following command:
    ```bash
    flutter pub get
    ```

3. Import the package into your Dart file:
    ```dart
    import 'package:neumorphic_glass_navbar/neumorphic_glass_navbar.dart';
    ```

## Usage

Here’s how to integrate the `neumorphic_glass_navbar` widget into your Flutter app:

```dart
      bottomNavigationBar: NeumorphicGlassNavbar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Cart',
          ),
            BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Fav',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box),
            label: 'account',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        settings: const NeumorphicGlassNavbarSettings(
          maxBlurIntensity: 16.0,
          borderRadius: 16.0,
          opacity: 0.1,
          vibrancyIntensity: 0.21,
        ),
      ),
```
## 🚀 About Me
I'm Subrahmanya S. Hegde, a mobile app developer with expertise in Flutter and Kotlin, passionate about building high-performance, cross-platform applications. With skills in Kotlin, Node.js, Firebase, and Supabase, I create end-to-end solutions that deliver seamless user experiences.

I hold an MCA degree from MIT Manipal and have a strong passion for exploring new technologies.

Let’s build something great together! 
#### Happy Coding!


## Authors

- [@subshegde](https://www.github.com/subshegde)


## Feedback

If you have any feedback, please reach out to us at subrahmanya460@gmail.com

#### My Github
[![GitHub](https://img.shields.io/badge/-GitHub-black.svg?style=for-the-badge&logo=github&colorB=000000&colorA=333333)](https://github.com/subshegde)