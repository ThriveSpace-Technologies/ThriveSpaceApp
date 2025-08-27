import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onSignIn;
  final VoidCallback onSignUp;
  final VoidCallback onBack;
  final VoidCallback? onForgotPassword;

  const LoginScreen({
    super.key,
    required this.onSignIn,
    required this.onSignUp,
    required this.onBack,
    this.onForgotPassword,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    widget.onSignIn();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header with back button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: widget.onBack,
                    icon: Icon(
                      LucideIcons.arrowLeft,
                      color: colorScheme.onSurface.withOpacity(0.7),
                      size: 20,
                    ),
                    style: IconButton.styleFrom(
                      backgroundColor: colorScheme.surface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    
                    // Welcome text
                    Column(
                      children: [
                        Text(
                          'Welcome Back',
                          style: theme.textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Column(
                          children: [
                            'Continue',
                            'your',
                            'wellness',
                            'journey',
                          ]
                              .map((line) => Text(
                                    line,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      color: colorScheme.onSurface
                                          .withOpacity(0.6),
                                      height: 1.2,
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),

                    const SizedBox(height: 32),

                    // Social login buttons
                    Column(
                      children: [
                        _buildSocialButton(
                          icon: Icons.apple,
                          text: 'Continue with Apple',
                          backgroundColor: Colors.black,
                          textColor: Colors.white,
                          colorScheme: colorScheme,
                        ),
                        const SizedBox(height: 12),
                        _buildSocialButton(
                          icon: LucideIcons.mail,
                          text: 'Continue with Google',
                          backgroundColor: Colors.white,
                          textColor: Colors.black,
                          border: true,
                          colorScheme: colorScheme,
                        ),
                        const SizedBox(height: 12),
                        _buildSocialButton(
                          icon: Icons.facebook,
                          text: 'Continue with Facebook',
                          backgroundColor: const Color(0xFF1877F2),
                          textColor: Colors.white,
                          colorScheme: colorScheme,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: colorScheme.outline.withOpacity(0.3),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            'or',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: colorScheme.outline.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Email and password form
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Email field
                        Text(
                          'Email',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: 'Enter your email',
                            prefixIcon: Icon(
                              LucideIcons.mail,
                              size: 16,
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        
                        const SizedBox(height: 16),

                        // Password field
                        Text(
                          'Password',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            hintText: 'Enter your password',
                            prefixIcon: Icon(
                              LucideIcons.lock,
                              size: 16,
                              color: colorScheme.onSurface.withOpacity(0.6),
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              icon: Icon(
                                _isPasswordVisible
                                    ? LucideIcons.eyeOff
                                    : LucideIcons.eye,
                                size: 16,
                                color: colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            contentPadding: const EdgeInsets.all(16),
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Forgot password
                        Center(
                          child: TextButton(
                            onPressed: widget.onForgotPassword,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    // Sign in button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleSignIn,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Sign up link
                    Column(
                      children: [
                        Text(
                          "Don't",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        Text(
                          "have",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        Text(
                          "an",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        TextButton(
                          onPressed: widget.onSignUp,
                          child: Text(
                            'account?',
                            style: TextStyle(
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String text,
    required Color backgroundColor,
    required Color textColor,
    required ColorScheme colorScheme,
    bool border = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$text - Coming Soon!'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          elevation: border ? 0 : 2,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: border
                ? BorderSide(color: colorScheme.outline.withOpacity(0.3))
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}