import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../utils/animation_constants.dart';

class AnimatedMessageBubble extends StatefulWidget {
  final String message;
  final String senderName;
  final String? senderAvatar;
  final DateTime timestamp;
  final bool isMe;
  final int animationDelay;

  const AnimatedMessageBubble({
    super.key,
    required this.message,
    required this.senderName,
    this.senderAvatar,
    required this.timestamp,
    required this.isMe,
    this.animationDelay = 0,
  });

  @override
  State<AnimatedMessageBubble> createState() => _AnimatedMessageBubbleState();
}

class _AnimatedMessageBubbleState extends State<AnimatedMessageBubble>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    
    _slideController = AnimationController(
      duration: WellnessAnimations.messageSlideIn,
      vsync: this,
    );
    
    _scaleController = AnimationController(
      duration: WellnessAnimations.smooth,
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(widget.isMe ? 1.0 : -1.0, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: WellnessAnimations.messageCurve,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: WellnessAnimations.gentleEase,
    ));

    _startAnimation();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _startAnimation() async {
    await Future.delayed(Duration(milliseconds: widget.animationDelay));
    if (mounted) {
      _slideController.forward();
      await Future.delayed(const Duration(milliseconds: 100));
      if (mounted) {
        _scaleController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: Listenable.merge([_slideController, _scaleController]),
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: Row(
                  mainAxisAlignment: widget.isMe 
                      ? MainAxisAlignment.end 
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    if (!widget.isMe) ...[
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: widget.senderAvatar != null
                            ? NetworkImage(widget.senderAvatar!)
                            : null,
                        child: widget.senderAvatar == null
                            ? Icon(LucideIcons.user, size: 16)
                            : null,
                      ),
                      const SizedBox(width: 8),
                    ],
                    
                    Flexible(
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: widget.isMe
                              ? colorScheme.primary
                              : colorScheme.surface,
                          borderRadius: BorderRadius.circular(18).copyWith(
                            bottomRight: widget.isMe 
                                ? const Radius.circular(4)
                                : null,
                            bottomLeft: !widget.isMe 
                                ? const Radius.circular(4)
                                : null,
                          ),
                          border: widget.isMe
                              ? null
                              : Border.all(
                                  color: colorScheme.outline.withValues(alpha: 0.1),
                                ),
                        ),
                        child: Text(
                          widget.message,
                          style: TextStyle(
                            color: widget.isMe
                                ? colorScheme.onPrimary
                                : colorScheme.onSurface,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ),
                    
                    if (widget.isMe) ...[
                      const SizedBox(width: 8),
                      CircleAvatar(
                        radius: 16,
                        backgroundImage: widget.senderAvatar != null
                            ? NetworkImage(widget.senderAvatar!)
                            : null,
                        child: widget.senderAvatar == null
                            ? Icon(LucideIcons.user, size: 16)
                            : null,
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AnimatedMessageNotification extends StatefulWidget {
  final String message;
  final String senderName;
  final String? senderAvatar;
  final VoidCallback? onTap;
  final VoidCallback? onDismiss;

  const AnimatedMessageNotification({
    super.key,
    required this.message,
    required this.senderName,
    this.senderAvatar,
    this.onTap,
    this.onDismiss,
  });

  @override
  State<AnimatedMessageNotification> createState() => _AnimatedMessageNotificationState();
}

class _AnimatedMessageNotificationState extends State<AnimatedMessageNotification>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    
    _slideController = AnimationController(
      duration: WellnessAnimations.messageSlideIn,
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: WellnessAnimations.messageCurve,
    ));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOut,
    ));

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: WellnessAnimations.breathingEase,
    ));

    _startAnimation();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _startAnimation() async {
    _slideController.forward();
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      _pulseController.repeat(reverse: true);
    }
  }

  void _dismiss() {
    _slideController.reverse().then((_) {
      widget.onDismiss?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AnimatedBuilder(
      animation: Listenable.merge([_slideController, _pulseController]),
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Transform.scale(
              scale: _pulseAnimation.value,
              child: GestureDetector(
                onTap: widget.onTap,
                child: Container(
                  margin: const EdgeInsets.all(16),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: colorScheme.primary.withValues(alpha: 0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        blurRadius: 12,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: widget.senderAvatar != null
                                ? NetworkImage(widget.senderAvatar!)
                                : null,
                            child: widget.senderAvatar == null
                                ? Icon(LucideIcons.user, size: 20)
                                : null,
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: colorScheme.surface,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(width: 12),
                      
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.senderName,
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              widget.message,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withValues(alpha: 0.8),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      
                      IconButton(
                        onPressed: _dismiss,
                        icon: Icon(
                          LucideIcons.x,
                          size: 16,
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                    ],
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