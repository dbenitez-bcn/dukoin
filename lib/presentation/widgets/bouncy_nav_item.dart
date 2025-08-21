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
    with TickerProviderStateMixin {
  late AnimationController _tapController; // for bounce
  late AnimationController _pressController; // for press down
  late Animation<double> _tapScale;
  late Animation<double> _pressScale;

  @override
  void initState() {
    super.initState();

    // Bounce animation (1.0 -> 1.2 -> 1.0)
    _tapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _tapScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.15), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.15, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _tapController, curve: Curves.easeOut));

    // Press down animation (1.0 -> 0.9)
    _pressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _pressScale = Tween<double>(
      begin: 1.0,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _pressController, curve: Curves.easeOut));
  }

  void _handleTap() {
    // release press down before bounce
    _pressController.reverse();
    _tapController.forward(from: 0);
    widget.onTap();
  }

  @override
  void dispose() {
    _tapController.dispose();
    _pressController.dispose();
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
      onTapDown: (_) => _pressController.forward(),
      // scale down
      onTapCancel: () => _pressController.reverse(),
      // reset if cancelled
      onTapUp: (_) => _pressController.reverse(),
      // reset when finger up
      child: AnimatedBuilder(
        animation: Listenable.merge([_tapController, _pressController]),
        builder: (context, child) {
          // multiply both scales together
          final scale = _tapScale.value * _pressScale.value;

          return Transform.scale(
            scale: scale,
            child: StreamBuilder(
              stream: NavigationStateProvider.of(context).currentPageStream,
              initialData: NavigationStateProvider.of(context).currentPageIndex,
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
                    borderRadius: BorderRadius.circular(16),
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
