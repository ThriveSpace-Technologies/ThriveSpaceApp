import 'package:flutter/animation.dart';

class WellnessAnimations {
  // Duration constants for consistent timing
  static const Duration quickFade = Duration(milliseconds: 150);
  static const Duration smooth = Duration(milliseconds: 250);
  static const Duration gentle = Duration(milliseconds: 350);
  static const Duration calm = Duration(milliseconds: 400);
  static const Duration meditative = Duration(milliseconds: 600);

  // Wellness-focused easing curves
  static const Curve gentleEase = Curves.easeOutCubic;
  static const Curve smoothEase = Curves.easeInOutCubic;
  static const Curve calmEase = Curves.easeOutQuart;
  static const Curve breathingEase = Curves.easeInOutSine;

  // Scale values for press feedback
  static const double pressScale = 0.95;
  static const double hoverScale = 1.02;
  static const double restScale = 1.0;

  // Opacity values
  static const double hiddenOpacity = 0.0;
  static const double subtleOpacity = 0.6;
  static const double visibleOpacity = 1.0;

  // Offset values for slide animations
  static const double slideOffset = 20.0;
  static const double cardSlideOffset = 40.0;

  // Animation timing for different interactions
  static const Duration buttonPress = Duration(milliseconds: 100);
  static const Duration buttonRelease = Duration(milliseconds: 200);
  static const Duration cardEntrance = Duration(milliseconds: 400);
  static const Duration tabTransition = Duration(milliseconds: 300);
  static const Duration chartAnimation = Duration(milliseconds: 800);
  static const Duration messageSlideIn = Duration(milliseconds: 350);

  // Special curves for specific interactions
  static const Curve buttonCurve = Curves.easeOutQuart;
  static const Curve cardCurve = Curves.easeOutCubic;
  static const Curve tabCurve = Curves.easeInOutCubic;
  static const Curve chartCurve = Curves.easeOutCirc;
  static const Curve messageCurve = Curves.easeOutBack;

  // Glow and shadow intensities (for light vs dark mode)
  static const double lightModeGlow = 0.1;
  static const double darkModeGlow = 0.2;
  static const double hoverGlow = 0.15;
}

// Custom curves for wellness-specific animations
class WellnessCurves {
  // Breathing-like animation curve
  static const Curve breathingIn = Curves.easeInSine;
  static const Curve breathingOut = Curves.easeOutSine;
  
  // Gentle bounce for notifications
  static const Curve gentleBounce = Curves.elasticOut;
  
  // Meditation-inspired ease
  static const Curve mindfulEase = Curves.easeInOutCirc;
  
  // Progressive reveal
  static const Curve progressiveReveal = Curves.easeOutExpo;
}