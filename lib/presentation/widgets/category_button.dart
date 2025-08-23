import 'package:dukoin/domain/expense.dart';
import 'package:dukoin/utils/utils.dart';
import 'package:flutter/material.dart';

class CategoryButton extends StatefulWidget {
  final ExpenseCategory category;
  final bool isActive;
  final ValueChanged<bool>? onChanged;

  const CategoryButton({
    super.key,
    required this.category,
    this.isActive = false,
    this.onChanged,
  });

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton>
    with SingleTickerProviderStateMixin {
  late bool _isActive;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _isActive = widget.isActive;

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    // Sequence: tap down (0 → 0.2), bounce up (0.2 → 1.0)
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(
          begin: 1.0,
          end: 0.95,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 20,
      ),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.95,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),

    ]).animate(_controller);
  }

  void _toggle() {
    setState(() => _isActive = !_isActive);
    widget.onChanged?.call(_isActive);
  }

  void _onTapDown(_) {
    _controller.animateTo(
      0.2,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  void _onTapUp(_) {
    _controller.forward(from: 0.2); // play bounce
    _toggle();
  }

  void _onTapCancel() {
    _controller.reverse(); // smoothly go back to 1.0
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 🎨 Style depending on state
    Color bgColor = theme.cardColor;
    Color borderColor = theme.dividerColor;
    Color textColor = theme.colorScheme.onSurface;
    FontWeight fontWeight = FontWeight.w500;

    if (_isActive) {
      bgColor = theme.colorScheme.primary.withAlpha(25);
      borderColor = theme.colorScheme.primary;
      textColor = theme.colorScheme.primary;
      fontWeight = FontWeight.w600;
    }

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: bgColor,
                border: Border.all(color: borderColor, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            "${getIconFromCategory(widget.category)} ${getCategoryTitle(context, widget.category)}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: textColor,
                              fontWeight: fontWeight,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedScale(
                    duration: const Duration(milliseconds: 200),
                    scale: _isActive ? 1 : 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        size: 14,
                        color: theme.colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
