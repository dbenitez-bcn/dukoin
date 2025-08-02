import 'package:flutter/material.dart';

import 'bouncy_nav_item.dart';

class NavItem {
  final IconData icon;
  final String label;

  const NavItem({
    required this.icon,
    required this.label,
  });
}
class BouncyBottomNavBar extends StatefulWidget {
  final List<NavItem> _items = const [
    NavItem(icon: Icons.home, label: 'Home'),
    NavItem(icon: Icons.settings, label: 'Settings'),
  ];
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const BouncyBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });

  @override
  State<BouncyBottomNavBar> createState() => _BouncyBottomNavBarState();
}

class _BouncyBottomNavBarState extends State<BouncyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(widget._items.length, (index) {
            final item = widget._items[index];
            return BouncyNavItem(
              icon: item.icon,
              label: item.label,
              isActive: widget.currentIndex == index,
              onTap: () => widget.onItemSelected(index),
            );
          }),
        ),
      ),
    );
  }
}