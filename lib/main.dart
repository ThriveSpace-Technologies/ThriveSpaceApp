import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'services/auth_service.dart';
import 'screens/onboarding/welcome_screen.dart';
import 'screens/onboarding/login_screen.dart';
import 'screens/onboarding/signup_screen.dart';
import 'widgets/main_navigation.dart';
import 'utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const ThriveSpaceApp());
}

class ThriveSpaceApp extends StatelessWidget {
  const ThriveSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return MaterialApp(
          title: 'ThriveSpace: Mindful Wellness',
          theme: AppTheme.lightTheme(lightDynamic),
          darkTheme: AppTheme.darkTheme(darkDynamic),
          themeMode: ThemeMode.system,
          home: const AppWrapper(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> {
  AppScreen _currentScreen = AppScreen.welcome;
  final _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  void _initializeApp() async {
    await Future.delayed(const Duration(seconds: 2)); // Splash duration

    // Check if user is authenticated
    final user = _authService.currentUser;

    if (user != null && _authService.isEmailConfirmed) {
      setState(() {
        _currentScreen = AppScreen.main;
      });
    } else {
      setState(() {
        _currentScreen = AppScreen.welcome;
      });
    }
  }

  void _handleSignIn() {
    setState(() {
      _currentScreen = AppScreen.main;
    });
  }

  void _handleSignUp() {
    setState(() {
      _currentScreen = AppScreen.main;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_currentScreen) {
      case AppScreen.welcome:
        return WelcomeScreen(
          onGetStarted: () => setState(() => _currentScreen = AppScreen.signin),
        );

      case AppScreen.signin:
        return LoginScreen(
          onSignIn: _handleSignIn,
          onSignUp: () => setState(() => _currentScreen = AppScreen.signup),
          onBack: () => setState(() => _currentScreen = AppScreen.welcome),
          onForgotPassword: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Forgot Password - Coming Soon!')),
            );
          },
        );

      case AppScreen.signup:
        return SignupScreen(
          onSignUp: _handleSignUp,
          onSignIn: () => setState(() => _currentScreen = AppScreen.signin),
          onBack: () => setState(() => _currentScreen = AppScreen.welcome),
        );

      case AppScreen.main:
        return const MainNavigation();
    }
  }
}

enum AppScreen {
  welcome,
  signin,
  signup,
  main,
}
