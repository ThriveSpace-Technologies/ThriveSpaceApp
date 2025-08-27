import 'package:flutter/material.dart';
import '../../utils/animation_constants.dart';

class AnimatedWellnessButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool enabled;
  final double elevation;

  const AnimatedWellnessButton({
    super.key,
    required this.child,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.borderRadius,
    this.enabled = true,
    this.elevation = 0,
  });

  @override
  State<AnimatedWellnessButton> createState() => _AnimatedWellnessButtonState();
}

class _AnimatedWellnessButtonState extends State<AnimatedWellnessButton>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _glowController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  bool _isPressed = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: WellnessAnimations.buttonPress,
      reverseDuration: WellnessAnimations.buttonRelease,
      vsync: this,
    );
    _glowController = AnimationController(
      duration: WellnessAnimations.smooth,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: WellnessAnimations.restScale,
      end: WellnessAnimations.pressScale,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: WellnessAnimations.buttonCurve,
    ));

    _glowAnimation = Tween<double>(
      begin: 0.0,
      end: WellnessAnimations.hoverGlow,
    ).animate(CurvedAnimation(
      parent: _glowController,
      curve: WellnessAnimations.smoothEase,
    ));
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!widget.enabled) return;
    setState(() => _isPressed = true);
    _scaleController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (!widget.enabled) return;
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  void _handleTapCancel() {
    if (!widget.enabled) return;
    setState(() => _isPressed = false);
    _scaleController.reverse();
  }

  void _handleHover(bool isHovered) {
    if (!widget.enabled) return;
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _glowController.forward();
    } else {
      _glowController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return MouseRegion(
      onEnter: (_) => _handleHover(true),
      onExit: (_) => _handleHover(false),
      child: GestureDetector(
        onTapDown: _handleTapDown,
        onTapUp: _handleTapUp,
        onTapCancel: _handleTapCancel,
        onTap: widget.enabled ? widget.onPressed : null,
        child: AnimatedBuilder(
          animation: Listenable.merge([_scaleAnimation, _glowAnimation]),
          builder: (context, child) {
            final glowIntensity = _glowAnimation.value;
            final backgroundColor = widget.backgroundColor ?? colorScheme.primary;
            
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: WellnessAnimations.quickFade,
                curve: WellnessAnimations.gentleEase,
                padding: widget.padding ?? const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: _isPressed
                      ? _darkenColor(backgroundColor, 0.1)
                      : backgroundColor,
                  borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
                  boxShadow: [
                    if (widget.elevation > 0 || glowIntensity > 0) ...[
                      BoxShadow(
                        color: isDark
                            ? backgroundColor.withValues(alpha: glowIntensity)
                            : Colors.black.withValues(alpha: 0.1 + glowIntensity),
                        blurRadius: isDark 
                            ? 8 + (glowIntensity * 12)
                            : 4 + (glowIntensity * 8),
                        spreadRadius: isDark 
                            ? glowIntensity * 2
                            : 0,
                        offset: Offset(0, widget.elevation.toDouble() + glowIntensity * 4),
                      ),
                    ],
                  ],
                ),
                child: AnimatedDefaultTextStyle(
                  duration: WellnessAnimations.quickFade,
                  style: TextStyle(
                    color: widget.foregroundColor ?? 
                           (widget.backgroundColor != null 
                               ? Colors.white
                               : colorScheme.onPrimary),
                    fontWeight: FontWeight.w500,
                  ),
                  child: widget.child,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _darkenColor(Color color, double amount) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0)).toColor();
  }
}