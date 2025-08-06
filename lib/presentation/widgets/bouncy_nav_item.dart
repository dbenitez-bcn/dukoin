import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:flutter/material.dart';

class BouncyNavItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final int index;
  final VoidCallback onTap;

  const BouncyNavItem({
    super.key,
    required this.icon,
    required this.label,
    required this.index,
    required this.onTap,
  });

  @override
  State<BouncyNavItem> createState() => _BouncyNavItemState();
}

class _BouncyNavItemState extends State<BouncyNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _handleTap() {
    _controller.forward(from: 0);
    widget.onTap();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isCurrentPage(AsyncSnapshot<int> snapshot) {
    if (snapshot.hasData) {
      return snapshot.data == widget.index;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: StreamBuilder(
              stream: NavigationState.of(context).currentPageStream,
              initialData: NavigationState.of(context).currentPageIndex,
              builder: (context, asyncSnapshot) {
                bool isActive = isCurrentPage(asyncSnapshot);
                return Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? colorScheme.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget.icon,
                        color: isActive ? colorScheme.primary : Colors.grey,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.label,
                        style: TextStyle(
                          color: isActive ? colorScheme.primary : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
