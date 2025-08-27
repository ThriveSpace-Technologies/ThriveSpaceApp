import 'package:flutter/material.dart';
import '../../utils/animation_constants.dart';

class AnimatedWellnessCard extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double borderRadius;
  final int animationDelay;
  final bool enableHover;
  final bool enableRipple;

  const AnimatedWellnessCard({
    super.key,
    required this.child,
    this.onTap,
    this.margin,
    this.padding,
    this.backgroundColor,
    this.borderRadius = 16,
    this.animationDelay = 0,
    this.enableHover = true,
    this.enableRipple = true,
  });

  @override
  State<AnimatedWellnessCard> createState() => _AnimatedWellnessCardState();
}

class _AnimatedWellnessCardState extends State<AnimatedWellnessCard>
    with TickerProviderStateMixin {
  late AnimationController _entranceController;
  late AnimationController _hoverController;
  late AnimationController _pressController;
  
  late Animation<double> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _hoverAnimation;
  late Animation<double> _scaleAnimation;

  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    
    _entranceController = AnimationController(
      duration: WellnessAnimations.cardEntrance,
      vsync: this,
    );
    
    _hoverController = AnimationController(
      duration: WellnessAnimations.smooth,
      vsync: this,
    );
    
    _pressController = AnimationController(
      duration: WellnessAnimations.buttonPress,
      reverseDuration: WellnessAnimations.buttonRelease,
      vsync: this,
    );

    // Entrance animations
    _slideAnimation = Tween<double>(
      begin: WellnessAnimations.cardSlideOffset,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: WellnessAnimations.cardCurve,
    ));

    _fadeAnimation = Tween<double>(
      begin: WellnessAnimations.hiddenOpacity,
      end: WellnessAnimations.visibleOpacity,
    ).animate(CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOut,
    ));

    // Hover animation
    _hoverAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: WellnessAnimations.gentleEase,
    ));

    // Press animation
    _scaleAnimation = Tween<double>(
      begin: WellnessAnimations.restScale,
      end: WellnessAnimations.pressScale,
    ).animate(CurvedAnimation(
      parent: _pressController,
      curve: WellnessAnimations.buttonCurve,
    ));

    _startEntranceAnimation();
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _hoverController.dispose();
    _pressController.dispose();
    super.dispose();
  }

  void _startEntranceAnimation() async {
    await Future.delayed(Duration(milliseconds: widget.animationDelay));
    if (mounted) {
      _entranceController.forward();
    }
  }

  void _handleHover(bool isHovered) {
    if (!widget.enableHover) return;
    
    setState(() => _isHovered = isHovered);
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onTap == null) return;
    setState(() => _isPressed = true);
    _pressController.forward();
  }

  void _handleTapUp(TapUpDetails details) {
    if (widget.onTap == null) return;
    setState(() => _isPressed = false);
    _pressController.reverse();
  }

  void _handleTapCancel() {
    if (widget.onTap == null) return;
    setState(() => _isPressed = false);
    _pressController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: Listenable.merge([
        _entranceController,
        _hoverController,
        _scaleAnimation,
      ]),
      builder: (context, child) {
        final hoverValue = _hoverAnimation.value;
        final backgroundColor = widget.backgroundColor ?? colorScheme.surface;
        
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: MouseRegion(
                onEnter: (_) => _handleHover(true),
                onExit: (_) => _handleHover(false),
                child: GestureDetector(
                  onTapDown: _handleTapDown,
                  onTapUp: _handleTapUp,
                  onTapCancel: _handleTapCancel,
                  onTap: widget.onTap,
                  child: Container(
                    margin: widget.margin ?? const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      border: Border.all(
                        color: colorScheme.outline.withValues(alpha: 0.1),
                        width: 0.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: isDark
                              ? colorScheme.primary.withValues(
                                  alpha: hoverValue * WellnessAnimations.darkModeGlow,
                                )
                              : Colors.black.withValues(
                                  alpha: 0.05 + (hoverValue * 0.1),
                                ),
                          blurRadius: isDark 
                              ? 8 + (hoverValue * 16)
                              : 4 + (hoverValue * 8),
                          spreadRadius: isDark 
                              ? hoverValue * 2
                              : 0,
                          offset: Offset(0, 2 + (hoverValue * 4)),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      child: Material(
                        color: Colors.transparent,
                        child: widget.enableRipple && widget.onTap != null
                            ? InkWell(
                                onTap: widget.onTap,
                                splashColor: colorScheme.primary.withValues(alpha: 0.1),
                                highlightColor: colorScheme.primary.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(widget.borderRadius),
                                child: Padding(
                                  padding: widget.padding ?? const EdgeInsets.all(16),
                                  child: widget.child,
                                ),
                              )
                            : Padding(
                                padding: widget.padding ?? const EdgeInsets.all(16),
                                child: widget.child,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Staggered animation widget for lists of cards
class StaggeredWellnessCardList extends StatelessWidget {
  final List<Widget> children;
  final int staggerDelayMs;
  final ScrollController? scrollController;

  const StaggeredWellnessCardList({
    super.key,
    required this.children,
    this.staggerDelayMs = 100,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: children.length,
      itemBuilder: (context, index) {
        return AnimatedWellnessCard(
          animationDelay: index * staggerDelayMs,
          child: children[index],
        );
      },
    );
  }
}