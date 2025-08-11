import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final SupabaseClient _supabase = Supabase.instance.client;
  
  // Get current user
  User? get currentUser => _supabase.auth.currentUser;
  
  // Get auth state stream
  Stream<AuthState> get authStateChanges => _supabase.auth.onAuthStateChange;
  
  // Check if user is authenticated
  bool get isAuthenticated => currentUser != null;
  
  // Sign up with email and password
  Future<AuthResponse> signUp({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: metadata,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Sign in with email and password
  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Sign out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
  
  // Reset password
  Future<void> resetPassword({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      rethrow;
    }
  }
  
  // Update user profile
  Future<UserResponse> updateProfile({
    Map<String, dynamic>? data,
  }) async {
    try {
      final response = await _supabase.auth.updateUser(
        UserAttributes(data: data),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
  
  // Get user profile data
  Map<String, dynamic>? get userMetadata => currentUser?.userMetadata;
  
  // Check if email is confirmed
  bool get isEmailConfirmed => currentUser?.emailConfirmedAt != null;
}