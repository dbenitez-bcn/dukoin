import 'package:flutter/material.dart';

@immutable
class DukoinColors extends ThemeExtension<DukoinColors> {
  final Color emeraldGreen;
  final Color relaxingTurquoise;
  final Color navBarBackground;
  final Color bodyColor;
  final Color accent;
  final Color shimmer;
  final Color shimmerAccent;

  const DukoinColors({
    required this.emeraldGreen,
    required this.relaxingTurquoise,
    required this.navBarBackground,
    required this.bodyColor,
    required this.accent,
    required this.shimmer,
    required this.shimmerAccent,
  });

  static const light = DukoinColors(
    emeraldGreen: Color(0xFF2ECC71),
    relaxingTurquoise: Color(0xFF06B6D4),
    navBarBackground: Colors.white,
    bodyColor: Color(0xFF616161),
    accent: Color(0xFFE0E7FF),
    shimmer: Color(0xFFE0E0E0),
    shimmerAccent: Color(0xFFF5F5F5),
  );

  static const dark = DukoinColors(
    emeraldGreen: Color(0xFF2BE379),
    relaxingTurquoise: Color(0xFF22D3EE),
    navBarBackground: Color(0xCD1E293B),
    bodyColor: Colors.white70,
    accent: Color(0xFF475569),
    shimmer: Color(0xFF2C2F38),
    shimmerAccent: Color(0xFF3A3F4A),
  );

  @override
  DukoinColors copyWith({
    Color? emeraldGreen,
    Color? relaxingTurquoise,
    Color? navBarBackground,
    Color? bodyColor,
    Color? accent,
    Color? shimmer,
    Color? shimmerAccent,
  }) {
    return DukoinColors(
      emeraldGreen: emeraldGreen ?? this.emeraldGreen,
      relaxingTurquoise: relaxingTurquoise ?? this.relaxingTurquoise,
      navBarBackground: navBarBackground ?? this.navBarBackground,
      bodyColor: bodyColor ?? this.bodyColor,
      accent: accent ?? this.accent,
      shimmer: shimmer ?? this.shimmer,
      shimmerAccent: shimmerAccent ?? this.shimmerAccent,
    );
  }

  @override
  DukoinColors lerp(ThemeExtension<DukoinColors>? other, double t) {
    if (other is! DukoinColors) return this;
    return DukoinColors(
      emeraldGreen: Color.lerp(emeraldGreen, other.emeraldGreen, t)!,
      relaxingTurquoise: Color.lerp(
        relaxingTurquoise,
        other.relaxingTurquoise,
        t,
      )!,
      navBarBackground: Color.lerp(
        navBarBackground,
        other.navBarBackground,
        t,
      )!,
      bodyColor: Color.lerp(
        bodyColor,
        other.bodyColor,
        t,
      )!,
      accent: Color.lerp(
        accent,
        other.accent,
        t,
      )!,
      shimmer: Color.lerp(
        shimmer,
        other.shimmer,
        t,
      )!,
      shimmerAccent: Color.lerp(
        shimmerAccent,
        other.shimmerAccent,
        t,
      )!,
    );
  }
}
