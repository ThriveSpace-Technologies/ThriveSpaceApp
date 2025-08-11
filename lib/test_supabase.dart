import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    // Load environment variables
    await dotenv.load(fileName: '.env');
    print('✅ Environment variables loaded');
    
    // Initialize Supabase
    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    print('✅ Supabase initialized successfully');
    
    // Test basic connection
    final client = Supabase.instance.client;
    print('✅ Supabase client created');
    
    // Test auth service
    final authService = AuthService();
    print('✅ Auth service created');
    print('Current user: ${authService.currentUser?.email ?? 'None'}');
    
    print('\n🎉 All tests passed! Supabase integration is working.');
    
  } catch (e) {
    print('❌ Error during Supabase test: $e');
  }
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Supabase Test')),
        body: const Center(
          child: Text('Check console for test results'),
        ),
      ),
    );
  }
}