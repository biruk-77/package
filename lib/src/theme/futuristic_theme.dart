import 'package:flutter/material.dart';

class FuturisticTheme {
  final String name;
  final LinearGradient glowGradient;
  final Color accentColor;
  final Color baseColor;
  final Color particleColor;
  final Color backgroundColor;
  final Map<String, Color> customColors;
  final Map<String, bool> effectToggles;

  const FuturisticTheme({
    required this.name,
    required this.glowGradient,
    required this.accentColor,
    required this.baseColor,
    required this.particleColor,
    required this.backgroundColor,
    this.customColors = const {},
    this.effectToggles = const {},
  });

  FuturisticTheme copyWith({
    String? name,
    LinearGradient? glowGradient,
    Color? accentColor,
    Color? baseColor,
    Color? particleColor,
    Color? backgroundColor,
    Map<String, Color>? customColors,
    Map<String, bool>? effectToggles,
  }) {
    return FuturisticTheme(
      name: name ?? this.name,
      glowGradient: glowGradient ?? this.glowGradient,
      accentColor: accentColor ?? this.accentColor,
      baseColor: baseColor ?? this.baseColor,
      particleColor: particleColor ?? this.particleColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      customColors: customColors ?? this.customColors,
      effectToggles: effectToggles ?? this.effectToggles,
    );
  }

  // Cyberpunk theme
  const FuturisticTheme.cyberpunk()
    : name = 'Cyberpunk',
      glowGradient = const LinearGradient(
        colors: [Color(0xFF42E8E0), Color(0xFF7B26F7), Color(0xFF5C57F0)],
        stops: [0.1, 0.5, 0.9],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentColor = const Color(0xFF42E8E0),
      baseColor = const Color(0xFF181828),
      particleColor = const Color(0xFF80D8FF),
      backgroundColor = const Color(0xFF0A0A14),
      customColors = const {},
      effectToggles = const {};

  // Aurora theme
  const FuturisticTheme.aurora()
    : name = 'Aurora',
      glowGradient = const LinearGradient(
        colors: [Color(0xFF6DD5FA), Color(0xFFFF758C), Color(0xFFFFD700)],
        stops: [0.1, 0.5, 0.9],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentColor = const Color(0xFF6DD5FA),
      baseColor = const Color(0xFF1E2A3A),
      particleColor = const Color(0xFFFFD700),
      backgroundColor = const Color(0xFF0F172A),
      customColors = const {},
      effectToggles = const {};

  // Molten theme
  const FuturisticTheme.molten()
    : name = 'Molten',
      glowGradient = const LinearGradient(
        colors: [Color(0xFFFF4E50), Color(0xFFF9D423), Color(0xFFFF4E50)],
        stops: [0.0, 0.5, 1.0],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      accentColor = const Color(0xFFFF4E50),
      baseColor = const Color(0xFF2C0E0E),
      particleColor = const Color(0xFFF9D423),
      backgroundColor = const Color(0xFF1A0B0B),
      customColors = const {},
      effectToggles = const {};
}
