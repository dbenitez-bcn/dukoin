import 'package:flutter/material.dart';

@immutable
class DukoinColors extends ThemeExtension<DukoinColors> {
  final Color emeraldGreen;
  final Color relaxingTurquoise;

  const DukoinColors({
    required this.emeraldGreen,
    required this.relaxingTurquoise,
  });

  static const light = DukoinColors(
    emeraldGreen: Color(0xFF2ECC71),
    relaxingTurquoise: Color(0xFF06B6D4),
  );

  static const dark = DukoinColors(
    emeraldGreen: Color(0xFF2BE379),
    relaxingTurquoise: Color(0xFF22D3EE),
  );

  @override
  DukoinColors copyWith({Color? emeraldGreen, Color? relaxingTeal}) {
    return DukoinColors(
      emeraldGreen: emeraldGreen ?? this.emeraldGreen,
      relaxingTurquoise: relaxingTeal ?? this.relaxingTurquoise,
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
    );
  }
}
