import 'package:flutter/material.dart';

class DukoinIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final bool isSolid;

  const DukoinIcon({super.key, required this.icon, required this.color, this.size = 24.0, this.isSolid = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color.withAlpha(isSolid ? 255 : 64),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(icon, color: isSolid ? Colors.white : color, size: size),
      ),
    );
  }
}
