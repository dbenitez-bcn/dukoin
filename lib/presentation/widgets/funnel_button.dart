import 'package:dukoin/presentation/widgets/category_filter_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class FunnelButton extends StatelessWidget {
  final int count = 2;

  FunnelButton({super.key});

  void _openBottomSheetModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return CategoryFilterBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isClear = count == 0;
    return GestureDetector(
      onTap: () => _openBottomSheetModal(context),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Card.outlined(
            color: isClear ? null : Theme.of(context).colorScheme.primary,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                LucideIcons.funnel,
                size: 16,
                color: isClear
                    ? Colors.grey
                    : Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          Positioned(
            right: -6,
            top: 2,
            child: RedBadge(text: count.toString(), size: isClear ? 0 : 20),
          ),
        ],
      ),
    );
  }
}

class RedBadge extends StatelessWidget {
  final String text; // e.g. "3"
  final double size; // diameter

  const RedBadge({super.key, required this.text, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          color: Theme.of(context).colorScheme.onError,
          fontSize: size * 0.55,
          fontWeight: FontWeight.w700,
          height: 1, // keeps text vertically centered
        ),
      ),
    );
  }
}
