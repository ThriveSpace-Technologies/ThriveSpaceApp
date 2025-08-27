import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../utils/animation_constants.dart';

class AnimatedCircularProgress extends StatefulWidget {
  final double progress;
  final double size;
  final double strokeWidth;
  final Color? progressColor;
  final Color? backgroundColor;
  final Widget? center;
  final Duration animationDuration;
  final bool autoStart;

  const AnimatedCircularProgress({
    super.key,
    required this.progress,
    this.size = 120,
    this.strokeWidth = 8,
    this.progressColor,
    this.backgroundColor,
    this.center,
    this.animationDuration = const Duration(milliseconds: 1200),
    this.autoStart = true,
  });

  @override
  State<AnimatedCircularProgress> createState() => _AnimatedCircularProgressState();
}

class _AnimatedCircularProgressState extends State<AnimatedCircularProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: WellnessAnimations.chartCurve,
    ));

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedCircularProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.progress != oldWidget.progress) {
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.progress,
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: WellnessAnimations.chartCurve,
      ));
      
      _controller.forward(from: 0.0);
    }
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              // Progress circle
              CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _CircularProgressPainter(
                  progress: _animation.value,
                  strokeWidth: widget.strokeWidth,
                  progressColor: widget.progressColor ?? colorScheme.primary,
                  backgroundColor: widget.backgroundColor ?? 
                      colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
              
              // Center content
              if (widget.center != null)
                widget.center!
              else
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(_animation.value * 100).round()}%',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.primary,
                      ),
                    ),
                    Text(
                      'Complete',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class _CircularProgressPainter extends CustomPainter {
  final double progress;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;

  _CircularProgressPainter({
    required this.progress,
    required this.strokeWidth,
    required this.progressColor,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background circle
    final backgroundPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, backgroundPaint);

    // Progress arc
    final progressPaint = Paint()
      ..color = progressColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const startAngle = -math.pi / 2;
    final sweepAngle = 2 * math.pi * progress;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularProgressPainter oldDelegate) {
    return progress != oldDelegate.progress ||
           progressColor != oldDelegate.progressColor ||
           backgroundColor != oldDelegate.backgroundColor;
  }
}

// Animated linear progress bar
class AnimatedLinearProgress extends StatefulWidget {
  final double progress;
  final double height;
  final Color? progressColor;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final Duration animationDuration;
  final bool autoStart;

  const AnimatedLinearProgress({
    super.key,
    required this.progress,
    this.height = 8,
    this.progressColor,
    this.backgroundColor,
    this.borderRadius,
    this.animationDuration = const Duration(milliseconds: 800),
    this.autoStart = true,
  });

  @override
  State<AnimatedLinearProgress> createState() => _AnimatedLinearProgressState();
}

class _AnimatedLinearProgressState extends State<AnimatedLinearProgress>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: widget.progress,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: WellnessAnimations.chartCurve,
    ));

    if (widget.autoStart) {
      _startAnimation();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 200));
    if (mounted) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? 
                colorScheme.outline.withValues(alpha: 0.1),
            borderRadius: widget.borderRadius ?? 
                BorderRadius.circular(widget.height / 2),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: _animation.value.clamp(0.0, 1.0),
            child: Container(
              decoration: BoxDecoration(
                color: widget.progressColor ?? colorScheme.primary,
                borderRadius: widget.borderRadius ?? 
                    BorderRadius.circular(widget.height / 2),
              ),
            ),
          ),
        );
      },
    );
  }
}

// Animated step progress indicator
class AnimatedStepProgress extends StatefulWidget {
  final int totalSteps;
  final int currentStep;
  final Color? activeColor;
  final Color? inactiveColor;
  final double stepSize;
  final Duration animationDuration;

  const AnimatedStepProgress({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    this.activeColor,
    this.inactiveColor,
    this.stepSize = 12,
    this.animationDuration = const Duration(milliseconds: 400),
  });

  @override
  State<AnimatedStepProgress> createState() => _AnimatedStepProgressState();
}

class _AnimatedStepProgressState extends State<AnimatedStepProgress>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;
  late List<Animation<Color?>> _colorAnimations;

  @override
  void initState() {
    super.initState();
    
    _controllers = List.generate(
      widget.totalSteps,
      (index) => AnimationController(
        duration: widget.animationDuration,
        vsync: this,
      ),
    );

    _scaleAnimations = _controllers.map((controller) =>
      Tween<double>(begin: 0.7, end: 1.0).animate(CurvedAnimation(
        parent: controller,
        curve: WellnessAnimations.gentleEase,
      ))
    ).toList();

    _colorAnimations = [];
    _updateAnimations();
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(AnimatedStepProgress oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (widget.currentStep != oldWidget.currentStep) {
      _updateAnimations();
    }
  }

  void _updateAnimations() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    _colorAnimations = _controllers.map((controller) =>
      ColorTween(
        begin: widget.inactiveColor ?? 
            colorScheme.outline.withValues(alpha: 0.3),
        end: widget.activeColor ?? colorScheme.primary,
      ).animate(controller)
    ).toList();

    // Animate active steps
    for (int i = 0; i < widget.totalSteps; i++) {
      if (i < widget.currentStep) {
        _controllers[i].forward();
      } else {
        _controllers[i].reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.totalSteps, (index) {
        return Padding(
          padding: EdgeInsets.only(
            right: index < widget.totalSteps - 1 ? 8 : 0,
          ),
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _scaleAnimations[index],
              _colorAnimations[index],
            ]),
            builder: (context, child) {
              return Transform.scale(
                scale: _scaleAnimations[index].value,
                child: Container(
                  width: widget.stepSize,
                  height: widget.stepSize,
                  decoration: BoxDecoration(
                    color: _colorAnimations[index].value,
                    shape: BoxShape.circle,
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}