import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/navigation_state.dart';
import 'package:dukoin/styles/dukoin_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'bouncy_nav_item.dart';

class NavItem {
  final IconData icon;
  final String label;

  const NavItem({required this.icon, required this.label});
}

class BouncyBottomNavBar extends StatefulWidget {
  List<NavItem> _items(BuildContext context) => [
    NavItem(
      icon: LucideIcons.house,
      label: AppLocalizations.of(context)!.navTabHome,
    ),
    NavItem(
      icon: LucideIcons.clock,
      label: AppLocalizations.of(context)!.navTabHistory,
    ),
    NavItem(
      icon: LucideIcons.chartArea,
      label: AppLocalizations.of(context)!.navTabStats,
    ),
    NavItem(
      icon: LucideIcons.settings,
      label: AppLocalizations.of(context)!.navTabSettings,
    ),
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
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(widget._items(context).length, (index) {
              final item = widget._items(context)[index];
              return Expanded(
                child: BouncyNavItem(
                  icon: item.icon,
                  label: item.label,
                  index: index,
                  onTap: () {
                    NavigationStateProvider.of(context).setPageIndex(index);
                    HapticFeedback.mediumImpact();
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
