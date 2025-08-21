import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:flutter/material.dart';

class DukoinAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const DukoinAppBar({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0.0),
      leading: DukoinIcon(
        icon: icon,
        color: Theme.of(context).colorScheme.primary,
        isSolid: true,
      ),
      title: Text(title, style: TextTheme.of(context).displayLarge),
      subtitle: Text(subtitle, style: TextTheme.of(context).bodyMedium),
    );
  }
}
