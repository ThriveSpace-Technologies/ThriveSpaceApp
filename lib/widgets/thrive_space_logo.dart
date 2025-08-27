import 'package:flutter/material.dart';

class ThriveSpaceLogo extends StatelessWidget {
  final double size;
  final Color? primaryColor;
  final Color? backgroundColor;
  final bool showTagline;
  final bool compact;

  const ThriveSpaceLogo({
    super.key,
    this.size = 80,
    this.primaryColor,
    this.backgroundColor,
    this.showTagline = false,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final primary = primaryColor ?? const Color(0xFF5f41c4);
    final bg = backgroundColor ?? Colors.transparent;

    // For compact mode, just show icon
    if (compact) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(size * 0.2),
        ),
        child: _buildFitnessIcon(primary, size),
      );
    }

    // For regular mode, show icon + text
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFitnessIcon(primary, size * 0.5),
                SizedBox(width: size * 0.1),
                Text(
                  'ThriveSpace',
                  style: TextStyle(
                    fontSize: size * 0.2,
                    fontWeight: FontWeight.bold,
                    color: primary,
                    letterSpacing: -0.3,
                  ),
                ),
              ],
            ),
            if (showTagline) ...[
              SizedBox(height: size * 0.05),
              Text(
                'Mindful Wellness',
                style: TextStyle(
                  fontSize: size * 0.08,
                  fontWeight: FontWeight.w400,
                  color: primary.withOpacity(0.7),
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildFitnessIcon(Color color, double iconSize) {
    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(iconSize * 0.25),
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Main dumbbell icon
          Icon(Icons.fitness_center, size: iconSize * 0.4, color: color),
          // Small accent dot
          Positioned(
            top: iconSize * 0.15,
            right: iconSize * 0.15,
            child: Container(
              width: iconSize * 0.1,
              height: iconSize * 0.1,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
