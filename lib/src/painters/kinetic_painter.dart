import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../theme/futuristic_theme.dart';

class KineticPainter extends CustomPainter {
  final double animationValue;
  final int count;
  final double idleTime;
  final FuturisticTheme theme;

  final double pressValue;

  final Map<String, Color> customColors;
  final Map<String, bool> effectToggles;

  KineticPainter({
    required this.animationValue,
    required this.count,
    required this.idleTime,
    required this.theme,
    this.pressValue = 0.0,
    this.customColors = const {},
    this.effectToggles = const {},
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (count == 0) return;

    final double w = size.width;
    final double h = size.height;
    final double itemWidth = w / count;
    final double activeX = (animationValue + 0.5) * itemWidth;

    // IMPACT SHOCKWAVE (Physical Pulse)
    if (pressValue > 0.01 && (effectToggles['showImpact'] ?? true)) {
      final double waveRadius = w * 0.5 * pressValue;
      canvas.drawCircle(
        Offset(activeX, h / 2),
        waveRadius,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0 * (1.0 - pressValue)
          ..color = (customColors['impactColor'] ?? theme.accentColor)
              .withOpacity((0.3 * (1.0 - pressValue)).clamp(0.0, 1.0))
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 8),
      );
    }

    // 1. TECH BASE
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, w, h),
        const Radius.circular(24),
      ),
      Paint()
        ..color = (customColors['backgroundColor'] ?? const Color(0xFF12121A)),
    );

    // 2. KINETIC TILES (Grid of shingles)
    if (effectToggles['showTiles'] ?? true) {
      const double tileSize = 12.0;
      final tilePaint = Paint()..style = PaintingStyle.fill;

      for (double x = 0; x < w; x += tileSize + 2) {
        for (double y = 0; y < h; y += tileSize + 2) {
          final double distToActive = math.sqrt(
            math.pow(x - activeX, 2) + math.pow(y - h / 2, 2),
          );
          final double proximity = (1.0 - (distToActive / 150.0)).clamp(
            0.0,
            1.0,
          );

          // Impact proximity
          final double impactProximity = (1.0 - (distToActive / (w * 0.4)))
              .clamp(0.0, 1.0);

          // MOMENTUM PHYSICS
          final double impactOffset = impactProximity * pressValue * 35.0;
          final double horizontalShuffle =
              math.sin(x * 0.1 + idleTime * 5) * pressValue * 5.0;

          final double baseTilt = math.sin(proximity * math.pi) * 0.8;
          final double impactTilt = impactProximity * pressValue * math.pi;
          final double secondaryWobble =
              math.sin(idleTime * 15 + x) * pressValue * 0.1;

          final double tilt = baseTilt + impactTilt + secondaryWobble;

          canvas.save();
          canvas.translate(
            x + tileSize / 2 + horizontalShuffle,
            y + tileSize / 2 - impactOffset,
          );
          canvas.rotate(tilt);

          canvas.scale(1.0 + (impactProximity * pressValue * 0.6));

          // Tile color overrides
          final baseTileColor =
              customColors['tileBaseColor'] ?? const Color(0xFF1E1E2A);
          final activeTileColor =
              customColors['tileActiveColor'] ?? theme.accentColor;

          tilePaint.color = Color.lerp(
            baseTileColor,
            activeTileColor.withOpacity(0.8),
            proximity.clamp(0.0, 1.0),
          )!;

          if (impactProximity > 0.1) {
            tilePaint.color = Color.lerp(
              tilePaint.color,
              customColors['tileImpactColor'] ?? Colors.white,
              (impactProximity * pressValue).clamp(0.0, 0.4),
            )!;
          }

          canvas.drawRRect(
            RRect.fromRectAndRadius(
              Rect.fromCenter(
                center: Offset.zero,
                width: tileSize,
                height: tileSize,
              ),
              const Radius.circular(2),
            ),
            tilePaint,
          );

          if (proximity > 0.5 || impactProximity > 0.5) {
            canvas.drawRect(
              Rect.fromLTWH(-tileSize / 2, -tileSize / 2, tileSize, 1),
              Paint()
                ..color = Colors.white.withOpacity(
                  0.3 * math.max(proximity, pressValue),
                ),
            );
          }
          canvas.restore();
        }
      }
    }

    // 3. THE WAVE CONDUIT (Energy line)
    if (effectToggles['showConduit'] ?? true) {
      final conduitPaint = Paint()
        ..color = (customColors['conduitColor'] ?? theme.accentColor)
            .withOpacity(0.3)
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      canvas.drawLine(Offset(0, h / 2), Offset(w, h / 2), conduitPaint);

      canvas.drawCircle(
        Offset(activeX, h / 2),
        30,
        Paint()
          ..shader = ui.Gradient.radial(
            Offset(activeX, h / 2),
            30,
            [
              (customColors['conduitColor'] ?? theme.accentColor).withOpacity(
                0.2,
              ),
              Colors.transparent,
            ],
            [0.0, 1.0],
          )
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10),
      );
    }
  }

  @override
  bool shouldRepaint(covariant KineticPainter oldDelegate) => true;
}
