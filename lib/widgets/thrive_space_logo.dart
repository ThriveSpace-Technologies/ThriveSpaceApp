import 'package:flutter/material.dart';

class ThriveSpaceLogo extends StatelessWidget {
  final double size;
  final Color? primaryColor;
  final Color? secondaryColor;
  final Color? backgroundColor;

  const ThriveSpaceLogo({
    super.key,
    this.size = 80,
    this.primaryColor,
    this.secondaryColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final primary = primaryColor ?? const Color(0xFF22c55e);  // Fresh green
    final secondary = secondaryColor ?? const Color(0xFF10b981);  // Emerald  
    final bg = backgroundColor ?? Colors.white;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: 0.2),
            blurRadius: size * 0.1,
            offset: Offset(0, size * 0.05),
          ),
        ],
      ),
      child: ClipOval(
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Colors.white,
                primary.withValues(alpha: 0.05),
                secondary.withValues(alpha: 0.1),
              ],
              stops: const [0.0, 0.7, 1.0],
            ),
          ),
          child: Stack(
            children: [
              // Main leaf shape
              Positioned(
                top: size * 0.15,
                left: size * 0.3,
                child: CustomPaint(
                  size: Size(size * 0.4, size * 0.6),
                  painter: LeafPainter(
                    color: primary,
                    size: size,
                  ),
                ),
              ),
              
              // Smaller accent leaves
              Positioned(
                top: size * 0.25,
                right: size * 0.25,
                child: CustomPaint(
                  size: Size(size * 0.2, size * 0.3),
                  painter: LeafPainter(
                    color: secondary.withValues(alpha: 0.8),
                    size: size * 0.5,
                  ),
                ),
              ),
              
              // Growth/wellness dots
              Positioned(
                bottom: size * 0.2,
                left: size * 0.2,
                child: _buildWellnessDot(primary, size * 0.06),
              ),
              Positioned(
                bottom: size * 0.3,
                right: size * 0.15,
                child: _buildWellnessDot(secondary, size * 0.04),
              ),
              Positioned(
                top: size * 0.2,
                left: size * 0.15,
                child: _buildWellnessDot(primary.withValues(alpha: 0.6), size * 0.05),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buildWellnessDot(Color color, double dotSize) {
    return Container(
      width: dotSize,
      height: dotSize,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: dotSize * 0.2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

class LeafPainter extends CustomPainter {
  final Color color;
  final double size;

  LeafPainter({required this.color, required this.size});

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final width = canvasSize.width;
    final height = canvasSize.height;

    // Create leaf shape
    path.moveTo(width * 0.5, 0);
    path.quadraticBezierTo(width * 0.8, height * 0.2, width * 0.9, height * 0.5);
    path.quadraticBezierTo(width * 0.8, height * 0.8, width * 0.5, height);
    path.quadraticBezierTo(width * 0.2, height * 0.8, width * 0.1, height * 0.5);
    path.quadraticBezierTo(width * 0.2, height * 0.2, width * 0.5, 0);
    path.close();

    canvas.drawPath(path, paint);

    // Add leaf vein
    final veinPaint = Paint()
      ..color = color.withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final veinPath = Path();
    veinPath.moveTo(width * 0.5, height * 0.1);
    veinPath.lineTo(width * 0.5, height * 0.9);

    canvas.drawPath(veinPath, veinPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}