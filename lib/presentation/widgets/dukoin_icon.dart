import 'package:dukoin/styles/theme.dart';
import 'package:flutter/material.dart';

class DukoinIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final bool isSolid;
  final bool isCircular;

  const DukoinIcon({
    super.key,
    required this.icon,
    required this.color,
    this.size = 24.0,
    this.isSolid = false,
    this.isCircular = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withAlpha(isSolid ? 255 : 64),
        borderRadius: BorderRadius.circular(isCircular ? (size + 16) / 2 : appBorderRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: isSolid ? Colors.white : color, size: size),
      ),
    );
  }
}
