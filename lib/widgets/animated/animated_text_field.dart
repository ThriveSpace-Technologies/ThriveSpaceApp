import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../utils/animation_constants.dart';

class AnimatedWellnessTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? errorText;
  final bool hasError;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;

  const AnimatedWellnessTextField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.errorText,
    this.hasError = false,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
  });

  @override
  State<AnimatedWellnessTextField> createState() => _AnimatedWellnessTextFieldState();
}

class _AnimatedWellnessTextFieldState extends State<AnimatedWellnessTextField>
    with TickerProviderStateMixin {
  late AnimationController _focusController;
  late AnimationController _errorController;
  late Animation<double> _focusAnimation;
  late Animation<double> _errorShakeAnimation;
  late Animation<Color?> _borderColorAnimation;

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    
    _focusController = AnimationController(
      duration: WellnessAnimations.smooth,
      vsync: this,
    );
    
    _errorController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _focusAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _focusController,
      curve: WellnessAnimations.gentleEase,
    ));

    _errorShakeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _errorController,
      curve: Curves.elasticOut,
    ));

    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusController.dispose();
    _errorController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedWellnessTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.hasError && !oldWidget.hasError) {
      _triggerErrorAnimation();
    }
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _isFocused) {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
      
      if (_isFocused) {
        _focusController.forward();
      } else {
        _focusController.reverse();
      }
    }
  }

  void _triggerErrorAnimation() {
    _errorController.forward().then((_) {
      _errorController.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    return AnimatedBuilder(
      animation: Listenable.merge([_focusAnimation, _errorShakeAnimation]),
      builder: (context, child) {
        final shakeValue = _errorShakeAnimation.value;
        final focusValue = _focusAnimation.value;
        
        // Create shake offset
        final shakeOffset = widget.hasError 
            ? Offset(4 * shakeValue * (1 - shakeValue * 2), 0)
            : Offset.zero;

        Color borderColor;
        if (widget.hasError) {
          borderColor = colorScheme.error;
        } else if (_isFocused) {
          borderColor = colorScheme.primary;
        } else {
          borderColor = colorScheme.outline.withValues(alpha: 0.3);
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.labelText != null) ...[
              AnimatedDefaultTextStyle(
                duration: WellnessAnimations.smooth,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: widget.hasError 
                      ? colorScheme.error
                      : _isFocused
                          ? colorScheme.primary
                          : colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                child: Text(widget.labelText!),
              ),
              const SizedBox(height: 8),
            ],
            
            Transform.translate(
              offset: shakeOffset,
              child: AnimatedContainer(
                duration: WellnessAnimations.smooth,
                curve: WellnessAnimations.gentleEase,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: borderColor,
                    width: _isFocused ? 2.0 : 1.0,
                  ),
                  boxShadow: [
                    if (_isFocused) ...[
                      BoxShadow(
                        color: isDark
                            ? colorScheme.primary.withValues(alpha: WellnessAnimations.darkModeGlow)
                            : colorScheme.primary.withValues(alpha: WellnessAnimations.lightModeGlow),
                        blurRadius: isDark ? 12 : 8,
                        spreadRadius: isDark ? 2 : 0,
                      ),
                    ],
                  ],
                ),
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  onTap: widget.onTap,
                  onChanged: widget.onChanged,
                  onEditingComplete: widget.onEditingComplete,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    prefixIcon: widget.prefixIcon != null
                        ? AnimatedContainer(
                            duration: WellnessAnimations.smooth,
                            child: Icon(
                              widget.prefixIcon,
                              size: 16,
                              color: widget.hasError
                                  ? colorScheme.error
                                  : _isFocused
                                      ? colorScheme.primary
                                      : colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                          )
                        : null,
                    suffixIcon: widget.suffixIcon,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.all(16),
                    hintStyle: TextStyle(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
              ),
            ),
            
            if (widget.errorText != null) ...[
              const SizedBox(height: 8),
              AnimatedOpacity(
                duration: WellnessAnimations.smooth,
                opacity: widget.hasError ? 1.0 : 0.0,
                child: Row(
                  children: [
                    Icon(
                      LucideIcons.alertCircle,
                      size: 16,
                      color: colorScheme.error,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        widget.errorText!,
                        style: TextStyle(
                          fontSize: 12,
                          color: colorScheme.error,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}