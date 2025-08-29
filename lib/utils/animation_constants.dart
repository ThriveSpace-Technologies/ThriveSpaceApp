import 'package:flutter/animation.dart';

class WellnessAnimations {
  // Duration constants matching requirements (200-400ms transitions)
  static const Duration quickFade = Duration(milliseconds: 200);
  static const Duration smooth = Duration(milliseconds: 300); 
  static const Duration gentle = Duration(milliseconds: 400);
  static const Duration calm = Duration(milliseconds: 350);
  static const Duration meditative = Duration(milliseconds: 600);

  // Wellness-focused easing curves (soft easing, ease-in-out, cubic-bezier)
  static const Curve gentleEase = Curves.easeInOutCubic; // Soft easing
  static const Curve smoothEase = Curves.easeInOut; // ease-in-out
  static const Curve calmEase = Curves.easeInOutQuart;
  static const Curve breathingEase = Curves.easeInOutSine;

  // Scale values for press feedback (button slightly scales down 0.95)
  static const double pressScale = 0.95; // Exact requirement
  static const double hoverScale = 1.02;
  static const double restScale = 1.0;

  // Opacity values
  static const double hiddenOpacity = 0.0;
  static const double subtleOpacity = 0.6;
  static const double visibleOpacity = 1.0;

  // Offset values for slide animations
  static const double slideOffset = 20.0;
  static const double cardSlideOffset = 30.0; // Gentle upward fade-in

  // Animation timing for different interactions
  static const Duration buttonPress = Duration(milliseconds: 150); // Quick press
  static const Duration buttonRelease = Duration(milliseconds: 250); // Smooth release
  static const Duration cardEntrance = Duration(milliseconds: 400); // Cards gently fade-in upward
  static const Duration tabTransition = Duration(milliseconds: 300); // Bottom tab smooth fade & slide
  static const Duration tabIndicator = Duration(milliseconds: 250); // Top tab underline slides
  static const Duration chartAnimation = Duration(milliseconds: 800); // Progress circles animate
  static const Duration messageSlideIn = Duration(milliseconds: 300); // Messages slide-in from right
  static const Duration inputFocus = Duration(milliseconds: 200); // Input focus glow
  static const Duration errorShake = Duration(milliseconds: 400); // Error shake effect

  // Special curves for specific interactions
  static const Curve buttonCurve = Curves.easeInOutCubic; // Soft button press
  static const Curve cardCurve = Curves.easeOutCubic; // Gentle card entrance
  static const Curve tabCurve = Curves.easeInOutCubic; // Smooth tab transitions
  static const Curve chartCurve = Curves.easeOutCirc; // Progress animation
  static const Curve messageCurve = Curves.easeOutQuart; // Message slide-in
  static const Curve focusCurve = Curves.easeInOutCubic; // Input focus
  static const Curve shakeCurve = Curves.elasticOut; // Error shake

  // Glow and shadow intensities (for light vs dark mode)
  static const double lightModeGlow = 0.08; // Soft shadows in light mode
  static const double darkModeGlow = 0.15; // Subtle glow accents in dark mode
  static const double hoverGlow = 0.12; // Hover glow intensity
  static const double focusGlow = 0.2; // Input focus glow (teal/purple)
  
  // Color darkening percentage for button press (darkens by ~10%)
  static const double buttonDarkenAmount = 0.1;
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