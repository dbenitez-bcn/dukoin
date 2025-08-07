import 'package:dukoin/l10n/app_localizations.dart';
import 'package:dukoin/presentation/state/theme_provider.dart';
import 'package:dukoin/presentation/widgets/dukoin_icon.dart';
import 'package:dukoin/presentation/widgets/settings_app_bar.dart';
import 'package:dukoin/presentation/widgets/theme_card_switch.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SettingsAppBar(),
            SizedBox(height: 16.0),
            ThemeCardSwitch(),
          ],
        ),
      ),
    );
  }
}
