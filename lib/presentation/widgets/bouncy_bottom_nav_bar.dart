import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';

import 'bouncy_nav_item.dart';

class NavItem {
  final IconData icon;
  final String label;

  const NavItem({required this.icon, required this.label});
}

class BouncyBottomNavBar extends StatefulWidget {
  List<NavItem> _items(BuildContext context) => [
    NavItem(icon: Icons.home_rounded, label: AppLocalizations.of(context)!.navTab1),
    NavItem(icon: Icons.settings, label: AppLocalizations.of(context)!.navTab2),
  ];

  const BouncyBottomNavBar({super.key});

  @override
  State<BouncyBottomNavBar> createState() => _BouncyBottomNavBarState();
}

class _BouncyBottomNavBarState extends State<BouncyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).extension<DukoinColors>()!.navBarBackground,
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
          children: List.generate(widget._items(context).length, (index) {
            final item = widget._items(context)[index];
            return BouncyNavItem(
              icon: item.icon,
              label: item.label,
              index: index,
              onTap: () => NavigationStateProvider.of(context).setPageIndex(index),
            );
          }),
        ),
      ),
    );
  }
}
