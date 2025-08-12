import 'package:flutter/material.dart';

@immutable
class DukoinColors extends ThemeExtension<DukoinColors> {
  final Color emeraldGreen;
  final Color relaxingTurquoise;
  final Color borderColor;
  final Color navBarBackground;
  final Color bodyColor;

  const DukoinColors({
    required this.emeraldGreen,
    required this.relaxingTurquoise,
    required this.borderColor,
    required this.navBarBackground,
    required this.bodyColor,
  });

  static const light = DukoinColors(
    emeraldGreen: Color(0xFF2ECC71),
    relaxingTurquoise: Color(0xFF06B6D4),
    borderColor: Color.fromRGBO(0, 0, 0, 0.1),
    navBarBackground: Colors.white,
    bodyColor: Color(0xFF616161)
  );

  static const dark = DukoinColors(
    emeraldGreen: Color(0xFF2BE379),
    relaxingTurquoise: Color(0xFF22D3EE),
    borderColor: Color(0xFF334155),
    navBarBackground: Color(0xCD1E293B),
    bodyColor: Colors.white70
  );

  @override
  DukoinColors copyWith({
    Color? emeraldGreen,
    Color? relaxingTurquoise,
    Color? borderColor,
    Color? navBarBackground,
    Color? bodyColor,
  }) {
    return DukoinColors(
      emeraldGreen: emeraldGreen ?? this.emeraldGreen,
      relaxingTurquoise: relaxingTurquoise ?? this.relaxingTurquoise,
      borderColor: borderColor ?? this.borderColor,
      navBarBackground: navBarBackground ?? this.navBarBackground,
      bodyColor: bodyColor ?? this.bodyColor,
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
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
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
    );
  }
}
