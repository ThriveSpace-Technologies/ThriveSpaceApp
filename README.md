# 🌱 ThriveSpace - Your Wellness Journey Awaits

<div align="center">
  <img src="assets/images/app-icon.png" alt="ThriveSpace Logo" width="120" height="120">
  
  **A comprehensive fitness and wellness community app built with Flutter & Supabase**
  
  [![Flutter Version](https://img.shields.io/badge/Flutter-3.24.0-blue.svg)](https://flutter.dev/)
  [![Supabase](https://img.shields.io/badge/Supabase-Integrated-green.svg)](https://supabase.com/)
  [![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
</div>

---

## ✨ Features

### 🏠 **Home Feed**
- Real-time fitness posts and updates
- Interactive stories from community members
- Like, comment, and share functionality
- Personalized content based on fitness goals

### 💬 **Messaging System**
- Direct messages with trainers and community members
- Group conversations for fitness challenges
- Real-time chat with online status indicators
- Media sharing capabilities

### 📊 **Progress Tracking**
- Personal fitness journey visualization
- Goal setting and achievement tracking
- Progress photos and measurements
- Workout history and statistics

### 🎓 **Learning Hub**
- Expert fitness tips and tutorials
- Nutrition guidance and meal plans
- Video workouts and exercise demonstrations
- Educational content from certified trainers

### 🔍 **Discovery**
- Find workout partners nearby
- Discover fitness events and challenges
- Search for specific exercises or routines
- Connect with like-minded fitness enthusiasts

### 👤 **Profile Management**
- Customizable user profiles
- Fitness level assessment
- Goal tracking and preferences
- Social connections and followers

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.24.0 or higher)
- Dart SDK (3.5.0 or higher)
- iOS Simulator / Android Emulator or Physical Device
- Supabase Account (for backend services)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/VigneshDharuman/ThriveSpaceApp.git
   cd ThriveSpaceApp
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your Supabase credentials
   ```

4. **Configure Supabase**
   - Create a new project at [Supabase](https://supabase.com)
   - Run the SQL scripts from `supabase_data_setup.md`
   - Update `.env` with your project URL and anon key

5. **Run the app**
   ```bash
   flutter run
   ```

---

## 🏗️ Architecture

```
lib/
├── main.dart                 # App entry point
├── screens/                  # UI screens
│   ├── home_screen.dart
│   ├── messages_screen.dart
│   ├── profile_screen.dart
│   └── onboarding/
├── services/                 # Business logic
│   ├── auth_service.dart     # Authentication
│   └── database_service.dart # Supabase operations
├── widgets/                  # Reusable components
│   ├── thrive_space_logo.dart
│   └── community_logo.dart
└── utils/                    # Utilities
    └── asset_manager.dart
```

### Tech Stack

- **Frontend**: Flutter (Dart)
- **Backend**: Supabase (PostgreSQL)
- **Authentication**: Supabase Auth
- **Real-time**: Supabase Realtime
- **Storage**: Supabase Storage (planned)
- **State Management**: StatefulWidgets + setState

---

## 🗄️ Database Schema

### Core Tables
- **profiles** - User profile information
- **posts** - Social media style posts
- **conversations** - Chat conversations
- **messages** - Individual messages
- **notifications** - System notifications
- **post_likes** - Post engagement tracking

See `supabase_data_setup.md` for complete schema and sample data.

---

## 🤝 Contributing

We welcome contributions to ThriveSpace! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Workflow

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Run tests (`flutter test`)
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Code Style

- Follow [Dart style guide](https://dart.dev/guides/language/effective-dart/style)
- Use meaningful variable names
- Comment complex logic
- Write tests for new features

---

## 🔧 Configuration

### Environment Variables

Create a `.env` file in the root directory:

```env
SUPABASE_URL=your_supabase_project_url
SUPABASE_ANON_KEY=your_supabase_anon_key
```

---

## 🐛 Known Issues

- Stories section may not load on first app launch (refresh fixes it)
- Some images may not display correctly in development mode
- Offline functionality is limited

See [Issues](https://github.com/VigneshDharuman/ThriveSpaceApp/issues) for full list.

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Team

- **Developer**: [Vignesh Dharuman](https://github.com/VigneshDharuman)
- **Design**: ThriveSpace Design Team
- **Backend**: Supabase Integration

---

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Supabase for backend-as-a-service
- Fitness community for inspiration and feedback
- Open source contributors

---

## 📞 Support

- 🐛 Issues: [GitHub Issues](https://github.com/VigneshDharuman/ThriveSpaceApp/issues)
- 💬 Discussions: [GitHub Discussions](https://github.com/VigneshDharuman/ThriveSpaceApp/discussions)

---

<div align="center">
  <strong>Made with ❤️ for the fitness community</strong>
</div>
