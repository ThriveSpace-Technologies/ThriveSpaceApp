import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../widgets/animated/animated_button.dart';
import '../../utils/animation_constants.dart';

class WelcomeScreen extends StatefulWidget {
  final VoidCallback onGetStarted;

  const WelcomeScreen({
    super.key,
    required this.onGetStarted,
  });

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    // Initialize animation controllers with wellness timing (200-400ms)
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400), // Calm timing
      vsync: this,
    );
    
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300), // Smooth timing
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 400), // Gentle timing
      vsync: this,
    );

    // Setup animations with wellness curves (ease-in-out, cubic-bezier)
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOutCubic, // Soft easing
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOutCubic, // Smooth transition
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.9,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeOutBack, // Subtle bounce
    ));

    // Start entrance animations with staggered timing
    _startAnimations();
  }

  void _startAnimations() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) _scaleController.forward();
    
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) _fadeController.forward();
    
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) _slideController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.only(
            left: 16.0,
            right: 16.0,
            // Use safe area padding for iOS
            bottom: MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              
              // Constrained content area matching React design (max-w-xs = 320px)
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320),
                child: Column(
                  children: [
                    // Logo with scale animation
                    AnimatedBuilder(
                      animation: _scaleAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _scaleAnimation.value,
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: isDark 
                                  ? const Color(0xFF2C2C2E) // Muted background in dark
                                  : const Color(0xFFF5F5F5), // Muted background in light
                              borderRadius: BorderRadius.circular(16), // rounded-2xl
                              boxShadow: isDark
                                  ? [
                                      BoxShadow(
                                        color: colorScheme.primary.withValues(alpha: 0.2),
                                        blurRadius: 8,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.05),
                                        blurRadius: 4,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                            ),
                            child: Icon(
                              LucideIcons.heart,
                              size: 32, // w-8 h-8
                              color: colorScheme.primary,
                            ),
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 32), // space-y-8
                    
                    // App name and tagline with fade animation
                    AnimatedBuilder(
                      animation: _fadeAnimation,
                      builder: (context, child) {
                        return Opacity(
                          opacity: _fadeAnimation.value,
                          child: Column(
                            children: [
                              const Text(
                                'ThriveSpace',
                                style: TextStyle(
                                  fontSize: 24, // Large heading
                                  fontWeight: FontWeight.w700, // Bold
                                  height: 1.3, // line-height
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8), // space-y-2
                              Text(
                                'Mindful Wellness,\nAnytime',
                                style: TextStyle(
                                  fontSize: 14, // Small text
                                  fontWeight: FontWeight.w400, // Regular
                                  color: colorScheme.onSurface.withValues(alpha: 0.6), // muted-foreground
                                  height: 1.4,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    
                    const SizedBox(height: 32), // space-y-8 total
                    
                    // Description with slide animation - exact React layout
                    SlideTransition(
                      position: _slideAnimation,
                      child: AnimatedBuilder(
                        animation: _fadeAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _fadeAnimation.value,
                            child: Column(
                              children: [
                                'Discover',
                                'inner peace',
                                'and build',
                                'healthy',
                                'habits with',
                                'personalized',
                                'wellness',
                                'guidance',
                              ].map((text) => Padding(
                                padding: const EdgeInsets.only(bottom: 4), // space-y-1
                                child: Text(
                                  text,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                                    height: 1.3, // leading-relaxed
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )).toList(),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              
              const Spacer(flex: 2),
              
              // Get Started button with enhanced animation
              SlideTransition(
                position: _slideAnimation,
                child: AnimatedBuilder(
                  animation: _fadeAnimation,
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimation.value,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 24), // pt-6
                        child: AnimatedWellnessButton(
                          onPressed: widget.onGetStarted,
                          backgroundColor: colorScheme.primary,
                          borderRadius: BorderRadius.circular(16), // rounded-2xl
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32, // px-8
                              vertical: 12,   // py-3
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.white, // text-primary-foreground
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}